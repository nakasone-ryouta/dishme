import UIKit
import FSCalendar
import CalculateCalendarLogic
import AMScrollingNavbar

class ReservationViewController: UIViewController,ScrollingNavigationControllerDelegate{
    
    //電話のview
    @IBOutlet weak var callbarView: UIView!
    //カレンダー
    @IBOutlet weak var calendar: FSCalendar!
    
    var getdates = GetDates()
    
    @IBOutlet var textField_time: UnderLineTextField!
    @IBOutlet var textField_number: UnderLineTextField!
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
    
    //電話番号
    var callnumber = "09038572079"
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // デリゲートの設定
        calendarsettings()

        
        //電話番号
        callnumberLabel.text = callnumber
        callnumberLabel.adjustsFontSizeToFitWidth = true
        
        
        pickersettings()    //pickerviewの基本設定
        textfiledsettings() //textfiledの基本設定
        
        setKeyboardAccessory()
        
        setupNavigation()
        
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
        calendar.appearance.todayColor = UIColor.init(red:55/255, green: 151/255, blue: 240/255, alpha: 1)
        calendar.appearance.selectionColor = UIColor.init(red:55/255, green: 151/255, blue: 240/255, alpha: 1)
        calendar.appearance.headerTitleColor = UIColor.init(red:55/255, green: 151/255, blue: 240/255, alpha: 1)
    }
    
    
    // 土日や祝日の日の文字色を変える
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        
        //予約無理な日
        for i in 0..<notday.count{
            if getdates.getday_from_date_to_String(date: date) == notday[i]{
                return UIColor.white
            }
        }
        return nil
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        calendar.appearance.todayColor = .white
        calendar.appearance.titleTodayColor = .black
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
        textField_time.textAlignment = .right
        textField_time.font = UIFont.systemFont(ofSize: 17)
        textField_time.placeholder = "時間を決める"
        view.addSubview(textField_time)
        
        //人数
        textField_number.inputView = pickerView_number
        textField_number.textAlignment = .right
        textField_number.font = UIFont.systemFont(ofSize: 17)
        textField_number.placeholder = "人数を決める"
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
