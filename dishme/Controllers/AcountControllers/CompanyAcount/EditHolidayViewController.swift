//
//  EditHolidayViewController.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/10/05.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import UIKit
import FSCalendar
import CalculateCalendarLogic

class EditHolidayViewController: UIViewController {
    
    //渡されてきた値
    var setting = ""
    
    //カレンダー
    @IBOutlet weak var calendar: FSCalendar!
    
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
    //無理な日
    var notday:[String] = ["2019-09-15",
                           "2019-09-16",
                           "2019-09-17",
                           "2019-09-21",
                           "2019-09-01",
                           "2019-09-08",]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupNavigation()
    }
    override func viewWillAppear(_ animated: Bool) {
        //カレンダーの設定
        calendersettings()
        calenderdayColor()
    }

}
//navigation周り
extension EditHolidayViewController{
    func setupNavigation(){
        let selectBtn = UIBarButtonItem(title: "保存", style: .done, target: self, action: #selector(save))
        self.navigationItem.rightBarButtonItems = [selectBtn]
        
        self.navigationItem.title = "臨時休業日を選択"
    }
    @objc func save(){
         _ = SweetAlert().showAlert("変更保存しました", subTitle: "臨時休業になりました", style: AlertStyle.success)
        self.navigationController?.popViewController(animated: true)
    }
}

//カレンダー周り
extension EditHolidayViewController:FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance{
    
    func calendersettings(){
        // カレンダーの設定
        self.calendar.dataSource = self
        self.calendar.delegate = self
        calendar.allowsMultipleSelection = true //複数の日付を同時に選択する
        calendar.appearance.todayColor = .white
        calendar.appearance.selectionColor = customcolor.selectColor()
        calendar.appearance.headerTitleColor = customcolor.selectColor()
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0 ;
//        calendar.scrollDirection = .vertical
//        calendar.scope = .week
//        calendar.scrollEnabled = false
        
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
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("change page to \(self.formatter.string(from: calendar.currentPage))")
        PagecalenderDate = self.formatter.string(from: calendar.currentPage)
    }

    //過ぎた日はスクロールできない
    func minimumDate(for calendar: FSCalendar) -> Date {
        return self.formatter.date(from: mincalender)!
    }
}
extension EditHolidayViewController{
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
