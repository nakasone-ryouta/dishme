

import UIKit
import FSCalendar
import CalculateCalendarLogic
import AMScrollingNavbar

class ChangeReserveViewController: UIViewController,FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance,ScrollingNavigationControllerDelegate{
    
    //電話のview
    @IBOutlet weak var callbarView: UIView!
    
    //カレンダー
    @IBOutlet weak var calendar: FSCalendar!
    
    var text_view1 = UITextField()
    var text_view2 = UITextField()
    var pickerView: UIPickerView = UIPickerView()
    var pickerView_number: UIPickerView = UIPickerView()
    
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
    
    var callnumber = "09038572079"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // デリゲートの設定
        self.calendar.dataSource = self
        self.calendar.delegate = self
        calendar.appearance.todayColor = UIColor.init(red:55/255, green: 151/255, blue: 240/255, alpha: 1)
        calendar.appearance.selectionColor = UIColor.init(red:55/255, green: 151/255, blue: 240/255, alpha: 1)
        calendar.appearance.headerTitleColor = UIColor.init(red:55/255, green: 151/255, blue: 240/255, alpha: 1)
        
        //電話番号
        callnumberLabel.text = callnumber
        
        
        pickersettings()    //pickerviewの基本設定
        textfiledsettings() //textfiledの基本設定
        
        setKeyboardAccessory()
        
        setupNavigation()
        
        //各ラベルインスタンス化
        addlabel()
        
    }
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    func setupNavigation(){
        let selectBtn = UIBarButtonItem(title: "予約", style: .done, target: self, action: #selector(savereservation))
        self.navigationItem.rightBarButtonItems = [selectBtn]
    }
    @objc func savereservation(){
        
    }
    
    @IBAction func callButton(_ sender: Any) {
        let url = NSURL(string: "tel://\(callnumber)")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url as URL)
        } else {
            UIApplication.shared.openURL(url as URL)
        }
    }
    //Date型にして返す
    func getdate(date: String) ->Date{
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "EEEEE", options: 0, locale: Locale.current)
        print(formatter.string(from: Date())) // 日
        formatter.dateFormat = "yyyy/MM/dd"
        formatter.locale = Locale(identifier: "ja_JP")
        let date = formatter.date(from: date)
        return date!
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    // 祝日判定を行い結果を返すメソッド(True:祝日)
    func judgeHoliday(_ date : Date) -> Bool {
        //祝日判定用のカレンダークラスのインスタンス
        let tmpCalendar = Calendar(identifier: .gregorian)
        
        // 祝日判定を行う日にちの年、月、日を取得
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        
        // CalculateCalendarLogic()：祝日判定のインスタンスの生成
        let holiday = CalculateCalendarLogic()
        
        return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
    }
    // date型 -> 年月日をIntで取得
    func getDay(_ date:Date) -> (Int,Int,Int){
        let tmpCalendar = Calendar(identifier: .gregorian)
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        return (year,month,day)
    }
    
    //曜日判定(日曜日:1 〜 土曜日:7)
    func getWeekIdx(_ date: Date) -> Int{
        let tmpCalendar = Calendar(identifier: .gregorian)
        return tmpCalendar.component(.weekday, from: date)
    }
    
    //今日の日付を取得
    func getToday(format:String = "yyyy/MM/dd HH:mm:ss") -> String {
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: now as Date)
    }
    //Date->String
    func getday_from_date_to_String(date: Date) ->String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    
    // 土日や祝日の日の文字色を変える
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {

        
        //無理な日
        for i in 0..<notday.count{
            if getday_from_date_to_String(date: date) == notday[i]{
                return UIColor.white
            }
        }
        return nil
    }
    
    //画像を貼る
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        calendar.appearance.todayColor = .white
        calendar.appearance.titleTodayColor = .black
    }
}


//pickerviewの基本設定
extension ChangeReserveViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    @objc func done(){
        text_view1.resignFirstResponder()
        text_view2.resignFirstResponder()
    }
    
    //pickerviewの中のレイアウト
    func setKeyboardAccessory() {
        let keyboardAccessory = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 36))
        keyboardAccessory.backgroundColor = UIColor.white
        text_view1.inputAccessoryView = keyboardAccessory
        text_view2.inputAccessoryView = keyboardAccessory
        
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
        text_view1.inputView = pickerView
        text_view1.frame = CGRect(x: 135, y: 491, width: 211, height: 50)
        text_view1.textAlignment = .right
        text_view1.font = UIFont.systemFont(ofSize: 17)
        text_view1.placeholder = "時間を決める"
        text_view1.addBorderBottom(height: 1.0, color: UIColor.lightGray)
        view.addSubview(text_view1)
        
        //人数
        text_view2.inputView = pickerView_number
        text_view2.frame = CGRect(x: 135, y: 569, width: 211, height: 50)
        text_view2.textAlignment = .right
        text_view2.font = UIFont.systemFont(ofSize: 17)
        text_view2.placeholder = "人数を決める"
        text_view2.addBorderBottom(height: 1.0, color: UIColor.lightGray)
        view.addSubview(text_view2)
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
            text_view2.text = "\(number[pickerView.selectedRow(inComponent: 0)])"
        default:
            text_view1.text = "\(time[pickerView.selectedRow(inComponent: 0)])"
        }
    }
}


extension ChangeReserveViewController{
    
    func addlabel(){
        timeLabel()
        numberLabel()
    }
    
    func timeLabel(){
        let label = UILabel()
        label.frame = CGRect(x: 136, y: 505, width: 0, height: 0)
        label.text = "時間帯"
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 16)
        label.sizeToFit()
        view.addSubview(label)
    }
    func numberLabel(){
        let label = UILabel()
        label.frame = CGRect(x: 136, y: 585, width: 0, height: 0)
        label.text = "人数"
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 16)
        label.sizeToFit()
        view.addSubview(label)
    }
}
