
import UIKit
import FSCalendar
import CalculateCalendarLogic

class EditReserveSettingViewController: UIViewController {
    
    //渡されてきた値
    var setting = ""
    
    //カレンダー
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet var calendarbackView: UIView!
    
    var customcolor = CustomColor()
    
    //土曜日、日曜日、祝日の取得
    let getdates = GetDates()
    
    //選択された日付配列
    var dates:[String] = []
    
    //カレンダー変数
    var PagecalenderDate: String = ""
    var mincalender: String = "2019/10/26"//最低で表示できない日付(昨日の日付)
    private var currentPage: Date?
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    private lazy var today: Date = {
        return Date()
    }()
    
    let number:[String] = ["1名",
                           "2名",
                           "3名",
                           "4名",
                           "5名",]
    
    let settingsnumber:[Int] = [10,13,2,5,2,11,4,5,13,2,5,2,11,4,5]
    //無理な日
    var notday:[String] = ["2019-09-15",
                           "2019-09-16",
                           "2019-09-17",
                           "2019-09-21",
                           "2019-09-01",
                           "2019-09-08",]
    
    let time:[String] = ["16:00",
                         "17:00",
                         "18:00",
                         "19:00",
                         "20:00",
                         "21:00",
                         "22:00",]
    
    var numberselect:IndexPath? = nil
    
    //選択されたらでるpickerview
    @IBOutlet var textField_number: UITextField!
    
    //pickerview
    private var pickerView:UIPickerView!
    private let pickerViewHeight:CGFloat = 240
    var pickerView_number: UIPickerView = UIPickerView()
    
    //pickerViewの上にのせるtoolbar
    private var pickerToolbar:UIToolbar!
    private let toolbarHeight:CGFloat = 40.0
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupNavigation()
        
        //pickerviewの基本設定
        pickersettings()
        setKeyboardAccessory()
        setkeyboardbutton()
        
        //textfieldの基本設定
        textfiledsettings()
        
        //UI部品の配置
        setUpView()
        
        //collectionviewの基本設定
        collectionSettings()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        //カレンダーの設定
        calendersettings()
        calenderdayColor()
    }
    
}
//navigation周り
extension EditReserveSettingViewController{
    func setupNavigation(){
        let selectBtn = UIBarButtonItem(title: "保存", style: .done, target: self, action: #selector(save))
        self.navigationItem.rightBarButtonItems = [selectBtn]
        
        self.navigationItem.title = "予約人数の設定"
    }
    @objc func save(){
        _ = SweetAlert().showAlert("変更保存しました", subTitle: "臨時休業になりました", style: AlertStyle.success)
        self.navigationController?.popViewController(animated: true)
    }
}

//カレンダー周り
extension EditReserveSettingViewController:FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance{
    
    func calendersettings(){
        // カレンダーの設定
        self.calendar.dataSource = self
        self.calendar.delegate = self
        calendar.frame = CGRect(x: 0, y: 235, width: view.frame.size.width, height: 500)
        calendar.backgroundColor = .clear
        calendar.appearance.selectionColor = .white
        calendar.appearance.todayColor = .white
        calendar.appearance.headerTitleColor = .white
        calendar.appearance.selectionColor = customcolor.selectColor()
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0 ;
        calendar.scope = .week
        
        //カレンダーの下に引いているview
        calendarbackView.backgroundColor = UIColor.init(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        calendarbackView.frame = CGRect(x: 0, y: 235, width: view.frame.size.width, height: 120)
        
        calendarBack()
        calendarNext()
        
        
    }
    
    func calenderdayColor(){
        self.calendar.calendarWeekdayView.weekdayLabels[0].text = "日"
        self.calendar.calendarWeekdayView.weekdayLabels[1].text = "月"
        self.calendar.calendarWeekdayView.weekdayLabels[2].text = "火"
        self.calendar.calendarWeekdayView.weekdayLabels[3].text = "水"
        self.calendar.calendarWeekdayView.weekdayLabels[4].text = "木"
        self.calendar.calendarWeekdayView.weekdayLabels[5].text = "金"
        self.calendar.calendarWeekdayView.weekdayLabels[6].text = "土"
        
        self.calendar.calendarWeekdayView.weekdayLabels[0].textColor =  UIColor.init(red: 255/255, green: 144/255, blue: 144/255, alpha: 1)
        self.calendar.calendarWeekdayView.weekdayLabels[1].textColor = UIColor.black
        self.calendar.calendarWeekdayView.weekdayLabels[2].textColor = UIColor.black
        self.calendar.calendarWeekdayView.weekdayLabels[3].textColor = UIColor.black
        self.calendar.calendarWeekdayView.weekdayLabels[4].textColor = UIColor.black
        self.calendar.calendarWeekdayView.weekdayLabels[5].textColor = UIColor.black
        self.calendar.calendarWeekdayView.weekdayLabels[6].textColor =  UIColor.init(red: 173/255, green: 212/255, blue: 255/255, alpha: 1)
    }
    
    
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        let getdates = GetDates()
        
        //予約無理な日
        for i in 0..<notday.count{
            if getdates.getday_from_date_to_String(date: date) == notday[i]{
                return UIColor.white
            }
        }
        return nil
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        calenderdayColor()
        
        //日付取得
        let tmpDate = Calendar(identifier: .gregorian)
        let year = tmpDate.component(.year, from: date)
        let month = tmpDate.component(.month, from: date)
        let day = tmpDate.component(.day, from: date)
        
        //選択された日付
        let date = "\(year)\(month)\(day)"
        
        //すでに選択された日付か判断する
        if dates.contains(date){
            dates.remove(value: date)
        }else{
            dates.append(date)
            print("aaaaa",dates)
        }
    }
    
    //前の月を選択不可
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        if date .compare(Date()) == .orderedAscending {
            return false
        }
        else {
            return true
        }
    }
    
    //初期時のカレンダーcellの色
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        return UIColor.white
    }
    
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("change page to \(self.formatter.string(from: calendar.currentPage))")
        PagecalenderDate = self.formatter.string(from: calendar.currentPage)
    }
    
    //過ぎた日はスクロールできない
    func minimumDate(for calendar: FSCalendar) -> Date {
        return self.formatter.date(from: mincalender)!
    }
}

extension EditReserveSettingViewController{
    //週をbackする
    func calendarBack(){
        // UIButtonのインスタンスを作成する
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(calendarback), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 100,
                              y: 2,
                              width: 25,
                              height: 25);
        button.setImage(UIImage(named: "calenderback"), for: UIControl.State())
        calendar.addSubview(button)
    }
    
    //週をnextにする
    func calendarNext(){
        // UIButtonのインスタンスを作成する
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(calendarnext), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 250,
                              y: 2,
                              width: 25,
                              height: 25);
        button.setImage(UIImage(named: "calendarnext"), for: UIControl.State())
        calendar.addSubview(button)
    }
    
    @objc func calendarback(){
        if PagecalenderDate == mincalender{
            print("スクロールできません")
        }else{
            self.moveCurrentPage(moveUp: false)
        }
    }
    @objc func calendarnext(){
        self.moveCurrentPage(moveUp: true)
    }
    
    private func moveCurrentPage(moveUp: Bool) {
        
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.weekOfMonth = moveUp ? 1 : -1
        
        self.currentPage = calendar.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
        self.calendar.setCurrentPage(self.currentPage!, animated: true)
    }
}


//pickerviewの基本設定
extension EditReserveSettingViewController : UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    @objc func done(){
        textField_number.resignFirstResponder()
    }
    @objc func doneTapped(){
        UIView.animate(withDuration: 0.2){
            self.pickerToolbar.frame.origin.y = self.view.frame.height
            self.pickerView.frame.origin.y = self.view.frame.height + self.toolbarHeight
            self.collectionView.contentOffset.y = 0
        }
//        self.collectionView.deselectRow(at: pickerIndexPath, animated: true)
    }
    
    func setkeyboardbutton(){
        //pickerToolbar
        pickerToolbar = UIToolbar(frame:CGRect(x:0,y:view.frame.size.height,width:view.frame.size.width,height:toolbarHeight))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneBtn = UIBarButtonItem(title: "完了", style: .plain, target: self, action: #selector(self.doneTapped))
        pickerToolbar.items = [flexible,doneBtn]
        self.view.addSubview(pickerToolbar)
    }
    
    //pickerviewの中のレイアウト
    func setKeyboardAccessory() {
        let keyboardAccessory = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 36))
        keyboardAccessory.backgroundColor = UIColor.white
        textField_number.inputAccessoryView = keyboardAccessory
        
        //pickerviewの一番上の線
        let topBorder = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 0.5))
        topBorder.backgroundColor = UIColor.lightGray
        keyboardAccessory.addSubview(topBorder)
        
        //決定ボタン
        let completeButton = UIButton(frame: CGRect(x: keyboardAccessory.bounds.size.width - 48,
                                                    y: 0,
                                                    width: 48,
                                                    height: keyboardAccessory.bounds.size.height - 0.5 * 2))
        completeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        completeButton.setTitle("決定", for: .normal)
        completeButton.setTitleColor(UIColor.black, for: .normal)
        completeButton.setTitleColor(UIColor.init(red: 3/255, green: 125/255, blue: 201/255, alpha: 1),
                                     for: .highlighted)
        
        completeButton.addTarget(self, action: #selector(done), for: .touchUpInside)
        keyboardAccessory.addSubview(completeButton)
        
        //pickerviewの選ぶところ
        let bottomBorder = UIView(frame: CGRect(x: 0, y: keyboardAccessory.bounds.size.height - 0.5,
                                                width:  keyboardAccessory.bounds.size.width,
                                                height: 0.5))
        bottomBorder.backgroundColor = UIColor.white
        keyboardAccessory.addSubview(bottomBorder)
    }
    
    //pickerviewの基本設定
    func pickersettings(){
        
        // ピッカー設定
        pickerView_number.delegate = self
        pickerView_number.dataSource = self
        pickerView_number.showsSelectionIndicator = true
        pickerView_number.backgroundColor = .white
        
        //pickerView
        pickerView = UIPickerView(frame:CGRect(x:0,y:view.frame.size.height + toolbarHeight,
                                               width:view.frame.size.width,height:pickerViewHeight))
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.backgroundColor = UIColor.white
        self.view.addSubview(pickerView)
    }
    //textの基本設定
    func textfiledsettings(){
        
        //人数
        textField_number.delegate = self
        textField_number.inputView = pickerView_number
        textField_number.textAlignment = .center
        textField_number.frame = CGRect(x: 0, y: 148, width: 375, height: 45)
        textField_number.font = UIFont.systemFont(ofSize: 17)
        textField_number.placeholder = "人数を決める"
        textField_number.layer.borderWidth = 1
        textField_number.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
        view.addSubview(textField_number)
    }
    
    // ドラムロールの列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // ドラムロールの行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return number.count
    }
    
    // ドラムロールの各タイトル
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return number[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case pickerView_number:
            textField_number.text = "\(number[pickerView.selectedRow(inComponent: 0)])"
        default:
            let cell = collectionView.cellForItem(at: numberselect!) as! EditReserveCollectionViewCell
            cell.numberLabel.text = "\(settingsnumber[pickerView.selectedRow(inComponent: 0)])名"
            cell.numberLabel.sizeToFit()
            collectionView.reloadData()
            //tableviewのindexpathを取得する
            break;

        }
    }
}

extension EditReserveSettingViewController{
    func setUpView(){
        numberLabel()
        dateLabel()
        timeLabel()
    }

    
    func numberLabel(){
        let label = UILabel()
        label.frame =  CGRect(x: 10, y: 131, width: 0, height: 0)
        label.text = "平均予約人数/1時間"
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "HelveticaNeue-Medium", size: 13)
        label.textAlignment = NSTextAlignment.right
        label.sizeToFit()
        view.addSubview(label)
    }
    func dateLabel(){
        let label = UILabel()
        label.frame =  CGRect(x: 10, y: 220, width: 0, height: 0)
        label.text = "日付"
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "HelveticaNeue-Medium", size: 13)
        label.textAlignment = NSTextAlignment.right
        label.sizeToFit()
        view.addSubview(label)
    }
    func timeLabel(){
        let label = UILabel()
        label.frame =  CGRect(x: 10, y: 384, width: 0, height: 0)
        label.text = "時間"
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "HelveticaNeue-Medium", size: 13)
        label.textAlignment = NSTextAlignment.right
        label.sizeToFit()
        view.addSubview(label)
    }
}

extension EditReserveSettingViewController :UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionSettings(){
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.frame = CGRect(x: 0, y: 401, width: view.frame.size.width, height: 80)
        collectionView.backgroundColor = UIColor.init(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return time.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! EditReserveCollectionViewCell
        
        //cellの基本設定
        cellsettings(cell: cell)
        
        cell.timeLabel.text = time[indexPath.row]
        cell.numberLabel.text = "\(settingsnumber[indexPath.row])名"
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! EditReserveCollectionViewCell
        cell.layer.borderColor = customcolor.selectColor().cgColor
        
        numberselect = indexPath
        
        //ピッカービューをリロード
        pickerView.reloadAllComponents()
        
        //ピッカービューを表示
        UIView.animate(withDuration: 0.2) {
            self.pickerToolbar.frame.origin.y = self.view.frame.height - self.pickerViewHeight - self.toolbarHeight
            self.pickerView.frame = CGRect(x:0,y:self.view.frame.height - self.pickerViewHeight,
                                           width:self.view.frame.width,height:self.pickerViewHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! EditReserveCollectionViewCell
        cell.layer.borderColor = UIColor.init(red: 219/255, green: 219/255, blue: 219/255, alpha: 1).cgColor
    }
    
    //cellの設定周り
    func cellsettings(cell:EditReserveCollectionViewCell){
        cell.backgroundColor = .white
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.init(red: 219/255, green: 219/255, blue: 219/255, alpha: 1).cgColor
        cell.layer.cornerRadius = 5
        cell.layer.masksToBounds = true
        
        cell.timeLabel.sizeToFit()
        cell.numberLabel.sizeToFit()
    }
}
