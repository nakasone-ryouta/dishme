

import UIKit
import FSCalendar
import CalculateCalendarLogic
import AMScrollingNavbar
import SnapKit

class ChangeReserveViewController: UIViewController,FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance,ScrollingNavigationControllerDelegate{
    
    //電話のview
    @IBOutlet weak var callbarView: UIView!
    
    //カレンダー
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet var text_view1: UITextField!
    @IBOutlet var text_view2: UITextField!
    
    //    var text_view1 = UITextField()
//    var text_view2 = UITextField()
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
        
        //カレンダーの基本設定
        calendersettings()
        
        //電話番号
        callnumberLabel.text = callnumber
        callnumberLabel.adjustsFontSizeToFitWidth = true
        
        
        pickersettings()    //pickerviewの基本設定
        textfiledsettings() //textfiledの基本設定
        
        setKeyboardAccessory()
        
        setupNavigation()
        
    }
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func changeButton(_ sender: UIButton) {
        _ = SweetAlert().showAlert("予約が変更されました", subTitle: "", style: AlertStyle.success)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func callButton(_ sender: Any) {
        let url = NSURL(string: "tel://\(callnumber)")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url as URL)
        } else {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
}
//カレンダー周り
extension ChangeReserveViewController{
    func calendersettings(){
        // デリゲートの設定
        self.calendar.dataSource = self
        self.calendar.delegate = self
        calendar.appearance.todayColor = UIColor.init(red:55/255, green: 151/255, blue: 240/255, alpha: 1)
        calendar.appearance.selectionColor = UIColor.init(red:55/255, green: 151/255, blue: 240/255, alpha: 1)
        calendar.appearance.headerTitleColor = UIColor.init(red:55/255, green: 151/255, blue: 240/255, alpha: 1)
    }
    // 土日や祝日の日の文字色を変える
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        
        let gatedates = GetDates()
        
        //無理な日
        for i in 0..<notday.count{
            if gatedates.getday_from_date_to_String(date: date) == notday[i]{
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

//navigation周り
extension ChangeReserveViewController{
    func setupNavigation(){
        let selectBtn = UIBarButtonItem(title: "予約", style: .done, target: self, action: #selector(savereservation))
        self.navigationItem.rightBarButtonItems = [selectBtn]
    }
    @objc func savereservation(){
        
    }
}

//textfieldの基本設定
extension ChangeReserveViewController{
    //textの基本設定
    func textfiledsettings(){
        let maxwidth = view.frame.size.width
        let maxheight = view.frame.size.height
        //時間帯
        text_view1.inputView = pickerView
        text_view1.textAlignment = .right
        text_view1.font = UIFont.systemFont(ofSize: 17)
        text_view1.placeholder = "時間を決める"
        view.addSubview(text_view1)
        
        
        //人数
        text_view2.inputView = pickerView_number
        text_view2.textAlignment = .right
        text_view2.font = UIFont.systemFont(ofSize: 17)
        text_view2.placeholder = "人数を決める"
        view.addSubview(text_view2)
    }
    
    @objc func done(){
        text_view1.resignFirstResponder()
        text_view2.resignFirstResponder()
    }
    
}


//pickerviewの基本設定
extension ChangeReserveViewController : UIPickerViewDelegate, UIPickerViewDataSource {
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
