import UIKit
import FSCalendar
import CalculateCalendarLogic
import AMScrollingNavbar

class ReservationViewController: UIViewController,ScrollingNavigationControllerDelegate{
    
    //電話のview
    @IBOutlet weak var callbarView: UIView!
    //カレンダー
    @IBOutlet weak var calendar: FSCalendar!
    
    var customcolor = CustomColor()
    
    var getdates = GetDates()
    
    @IBOutlet var textField_time: UITextField!
    @IBOutlet var textField_number: UITextField!
    var pickerView: UIPickerView = UIPickerView()
    var pickerView_number: UIPickerView = UIPickerView()
    
    //カレンダー変数
    var PagecalenderDate: String = ""
    var mincalender: String = "2019/10/27"//最低で表示できない日付(明日の日付)
//    var maxcalender: String = "2019/11/24"//最高で表示できない日付
    private var currentPage: Date?
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    private lazy var today: Date = {
        return Date()
    }()
    
    //予約OKな日
    let nodate:[String] = ["2019/9/22",
                           "2019/9/23",
                           "2019/9/24",
                           "2019/9/25",]
    
    let time:[String] = ["16:00〜",
                         "17:00〜",
                         "18:00〜",
                         "19:00〜",
                         "20:00〜",]
    
    let number:[String] = ["1名",
                         "2名",
                         "3名",
                         "4名",
                         "5名",]
    //無理な日
    var notday:[String] = ["2019-09-15",
                           "2019-09-16",
                           "2019-09-17",
                           "2019-09-21",
                           "2019-09-01",
                           "2019-09-08",]
    
    @IBOutlet weak var callnumberLabel: UILabel!
    
    //電話番号
    var callnumber = "09038572079"
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // デリゲートの設定
        calendarsettings()
        calenderdayColor()

        
        //電話番号
        callnumberLabel.text = callnumber
        callnumberLabel.adjustsFontSizeToFitWidth = true
        
        
        pickersettings()    //pickerviewの基本設定
        textfiledsettings() //textfiledの基本設定
        
        setKeyboardAccessory()
        
        setupNavigation()
        
        //UI部品の配置
        setUpView()
        
    }
    
    
    @IBAction func callButton(_ sender: Any) {
        let url = NSURL(string: "tel://\(callnumber)")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url as URL)
        } else {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
//navigation周り
extension ReservationViewController{
    func setupNavigation(){
        let selectBtn = UIBarButtonItem(title: "予約", style: .done, target: self, action: #selector(savereservation))
        self.navigationItem.rightBarButtonItems = [selectBtn]
    }
    
    @objc func savereservation(){
        
        let text_view3 = textField_time.text! + textField_number.text!
        
        switch "" {
            
        case text_view3:
            return _ = SweetAlert().showAlert("予約できません", subTitle: "時間と人数を入力してください", style: AlertStyle.error)
            
        case textField_time.text:
            return _ = SweetAlert().showAlert("予約できません", subTitle: "時間を入力してください", style: AlertStyle.error)
        case textField_number.text:
            return _ = SweetAlert().showAlert("予約できません", subTitle: "人数を入力してください", style: AlertStyle.error)
        default:
            _ = SweetAlert().showAlert("予約しました", subTitle: "予約リストを見るには「予約」から見れます。", style: AlertStyle.success)
        }
    }
}

//カレンダー周り
extension ReservationViewController:FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance{
    
    func calendarsettings(){
        self.calendar.dataSource = self
        self.calendar.delegate = self
        calendar.frame = CGRect(x: 0, y: 155, width: view.frame.size.width, height: 500)
        calendar.appearance.todayColor = .white
        calendar.appearance.titleTodayColor = .lightGray
        calendar.appearance.selectionColor = customcolor.selectColor()
        calendar.appearance.headerTitleColor = customcolor.selectColor()
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0 ;
    
        calendar.scope = .week
        
        //カレンダーの戻るボタン,進むボタン
        calendarBack()
        calendarNext()
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        return .white
    }
    
    
    // 土日や祝日の日の文字色を変える
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
    
    //前の月を選択不可
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        if date .compare(Date()) == .orderedAscending {
            return false
        }
        else {
            return true
        }
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        calendar.appearance.todayColor = .white
        calendar.appearance.titleTodayColor = .black
    }
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("change page to \(self.formatter.string(from: calendar.currentPage))")
        PagecalenderDate = self.formatter.string(from: calendar.currentPage)
    }
    func minimumDate(for calendar: FSCalendar) -> Date {
        return self.formatter.date(from: mincalender)!
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
}

//カレンダーのUI部品
extension ReservationViewController{
    
    //週をbackする
    func calendarBack(){
        // UIButtonのインスタンスを作成する
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(calendarback), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 100,
                              y: 13,
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
                              y: 13,
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
extension ReservationViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    @objc func done(){
        textField_time.resignFirstResponder()
        textField_number.resignFirstResponder()
    }
    
    //pickerviewの中のレイアウト
    func setKeyboardAccessory() {
        let keyboardAccessory = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 36))
        keyboardAccessory.backgroundColor = UIColor.white
        textField_time.inputAccessoryView = keyboardAccessory
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
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true
        pickerView.backgroundColor = .white
        
        // ピッカー設定
        pickerView_number.delegate = self
        pickerView_number.dataSource = self
        pickerView_number.showsSelectionIndicator = true
        pickerView_number.backgroundColor = .white
    }
    //textの基本設定
    func textfiledsettings(){
        //時間帯
        textField_time.inputView = pickerView
        textField_time.textAlignment = .center
        textField_time.frame = CGRect(x: 0, y: 332, width: 375, height: 45)
        textField_time.font = UIFont.systemFont(ofSize: 17)
        textField_time.layer.borderWidth = 1
        textField_time.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
        textField_time.placeholder = "時間を決める"
        view.addSubview(textField_time)
        
        //人数
        textField_number.inputView = pickerView_number
        textField_number.textAlignment = .center
        textField_number.frame = CGRect(x: 0, y: 437, width: 375, height: 45)
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
        switch pickerView {
        case pickerView_number:
            return number.count
        default:
            return time.count
        }
    }
    
    // ドラムロールの各タイトル
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        switch pickerView {
        case pickerView_number:
            return number[row]
        default:
            return time[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView{
        case pickerView_number:
            textField_number.text = "\(number[pickerView.selectedRow(inComponent: 0)])"
        default:
            textField_time.text = "\(time[pickerView.selectedRow(inComponent: 0)])"
        }
    }
}

extension ReservationViewController{
    func setUpView(){
        dateLabel()
        timeLabel()
        numberLabel()
    }
    func dateLabel(){
        let label = UILabel()
        label.frame =  CGRect(x: 10, y: 166, width: 0, height: 0)
        label.text = "日付選択"
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "HelveticaNeue-Medium", size: 16)
        label.textAlignment = NSTextAlignment.right
        label.sizeToFit()
        view.addSubview(label)
    }
    
    func timeLabel(){
        let label = UILabel()
        label.frame =  CGRect(x: 10, y: 300, width: 0, height: 0)
        label.text = "時間帯"
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "HelveticaNeue-Medium", size: 16)
        label.textAlignment = NSTextAlignment.right
        label.sizeToFit()
        view.addSubview(label)
    }
    
    func numberLabel(){
        let label = UILabel()
        label.frame =  CGRect(x: 10, y: 416, width: 0, height: 0)
        label.text = "人数"
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "HelveticaNeue-Medium", size: 16)
        label.textAlignment = NSTextAlignment.right
        label.sizeToFit()
        view.addSubview(label)
    }
    
}
