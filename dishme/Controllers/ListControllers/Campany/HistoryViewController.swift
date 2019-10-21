
//
//  HistoryViewController.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/10/21.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    //企業アカウントに移行時
    let acountimage:[UIImage] = [UIImage(named: "acount1")!,
                                 UIImage(named: "acount2")!,
                                 UIImage(named: "acount3")!,
                                 UIImage(named: "acount4")!,
                                 UIImage(named: "acount5")!,]
    
    let number:[String] = ["13",
                           "12",
                           "13",
                           "5",
                           "9"]
    
    let acountname:[String] = ["中曽根亮太",
                               "井村彩乃",
                               "細井勇希",
                               "高村具栄",
                               "大塚愛",]
    
    let time:[String] = ["13:00〜",
                             "13:00〜",
                             "13:00〜",
                             "13:00〜",
                             "13:00〜",]
    let phonenumber:[String] = ["09067892138",
                                "08021947289",
                                "09081283429",
                                "09012345678",
                                "09023859201",]
    let phone:[Int] = [09069539797,
                       09069539797,
                       09069539797,
                       09069539797,
                       09069539797,]
    var call = ""
    
    let date:[String] = ["１０月５日(火曜日)",
                         "１０月６日(木曜日)",
                         "１０月７日(水曜日)",
                         "１０月８日(金曜日)",
                         "１０月９日(火曜日)",]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tablesettings()
    }
    
}

extension HistoryViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tablesettings(){
        //テーブルのレイアウト
        let tablelayout = Layouting()
        tablelayout.tableLayouting(tableview: tableView, view: view)
        
        self.tableView.register(UINib(nibName: "ReserveTableViewCell", bundle: nil), forCellReuseIdentifier: "ReserveTableViewCell")
    }
    
    // Section数
    func numberOfSections(in tableView: UITableView) -> Int {
        return date.count
    }
    
    // Sectioのタイトル
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        return date[date.count - section - 1]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return acountname.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReserveTableViewCell") as! ReserveTableViewCell
        cell.acountImage.image = acountimage[indexPath.row]
        
        cell.maintitle.text = acountname[indexPath.row]
        cell.title1.text = "人数  \(number[indexPath.row])名"
        cell.title2.text = "時間  \(time[indexPath.row])"
        
        cell.leftButton.removeFromSuperview()
        cell.rightButton.removeFromSuperview()
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
}

extension HistoryViewController{
    //ボタンから取得する
    @objc func callbutton(sender: UIButton){
        print("aaaaa",sender.tag)
        
        
        
        //電話をかける
        let url = NSURL(string: "tel://\(phone)")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url as URL)
        } else {
            UIApplication.shared.openURL(url as URL)
        }
    }
}
