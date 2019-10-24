//
//  GetDates.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/10/05.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import Foundation
import FSCalendar
import CalculateCalendarLogic

class GetDates{
    
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
    //月をInt型で取得
    func getMonth(date: Date) ->Int{
        let tmpCalendar = Calendar(identifier: .gregorian)
        let month = tmpCalendar.component(.month, from: date)
        return month
    }
    
    //今月を取得
    func getThisMonth(date: Date) ->String{
        var calendar = Calendar.current
        
        calendar.locale = Locale(identifier: "ja_JP")
        let month = calendar.component(.month, from: date)
        print(calendar.standaloneMonthSymbols[month - 1])
        return calendar.standaloneMonthSymbols[month - 1]
    }
    
    //先月を取得
    func getLastMonth(date: Date) ->String{
        var calendar = Calendar.current
        
        calendar.locale = Locale(identifier: "ja_JP")
        let month = calendar.component(.month, from: date)
        print(calendar.standaloneMonthSymbols[month - 2])
        return calendar.standaloneMonthSymbols[month - 2]
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
}
