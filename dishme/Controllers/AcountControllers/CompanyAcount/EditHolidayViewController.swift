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
    
    //カレンダー
    @IBOutlet weak var calendar: FSCalendar!
    
    //土曜日、日曜日、祝日の取得
    let getdates = GetDates()
    
    //選択された日付配列
    var dates:[String] = []

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

extension EditHolidayViewController:FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance{
    
    func calendersettings(){
        // カレンダーの設定
        self.calendar.dataSource = self
        self.calendar.delegate = self
        calendar.allowsMultipleSelection = true //複数の日付を同時に選択する
        calendar.appearance.todayColor = .white
        calendar.appearance.selectionColor = UIColor.init(red:55/255, green: 151/255, blue: 240/255, alpha: 1)
        calendar.appearance.headerTitleColor = UIColor.init(red:55/255, green: 151/255, blue: 240/255, alpha: 1)
//        calendar.scrollDirection = .vertical
//        calendar.scope = .week
//        calendar.scrollEnabled = false
        

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
    
    
    // 土日や祝日の日の文字色を変える
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        
                //祝日
                if getdates.judgeHoliday(date){
                    return UIColor.init(red: 255/255, green: 144/255, blue: 144/255, alpha: 1)
                }
                let weekday = getdates.getWeekIdx(date)
                //日曜日
                if weekday == 1{
                    return UIColor.init(red: 255/255, green: 144/255, blue: 144/255, alpha: 1)
                }
                //土曜日
                else if weekday == 7{
                    return UIColor.init(red: 173/255, green: 212/255, blue: 255/255, alpha: 1)
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
}
