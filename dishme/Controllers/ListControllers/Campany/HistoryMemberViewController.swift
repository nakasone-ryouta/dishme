
//
//  HistoryMemberViewController.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/10/04.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import UIKit

class HistoryMemberViewController: UIViewController {
    
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
    
    let listtime:[String] = ["13:00〜",
                             "13:00〜",
                             "13:00〜",
                             "13:00〜",
                             "13:00〜",]
    let phonenumber:[String] = ["09067892138",
                                "08021947289",
                                "09081283429",
                                "09012345678",
                                "09023859201",]
    
    let date:[String] = ["１０月７日(火曜日)",
                         "１０月６日(木曜日)",
                         "１０月５日(水曜日)",
                         "１０月４日(金曜日)",
                         "１０月３日(火曜日)",]

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tablesettings()
        
        //テーブルのレイアウト
        let tablelayout = Layouting()
        tablelayout.tableLayouting(tableview: tableView, view: view)
    }


}

extension HistoryMemberViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tablesettings(){

        tableView.delegate = self
        tableView.dataSource = self
        
        let maxheight = view.frame.size.height
        let maxwidth = view.frame.size.width
        
        let BarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
        let tableheight = maxheight - tableView.frame.origin.y * 2 - BarHeight
        print(tableheight)
        
        
        tableView.frame = CGRect(x: 0, y: 0, width: Int(maxwidth), height: Int(tableheight))
    }
    
    // Section数
    func numberOfSections(in tableView: UITableView) -> Int {
        return date.count
    }
    
    // Sectioのタイトル
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        return date[section]
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dates = getDates(section: section)
        return dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryMemberCell", for: indexPath) as! HistoryMemberCell
        cell.acountname.text = acountname[indexPath.row]
        cell.acountImage.image = acountimage[indexPath.row]
        cell.acountImage.circle()
        cell.time.text = listtime[indexPath.row]
        cell.phonenumber.text = phonenumber[indexPath.row]
        
        //選択不可
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func getDates(section: Int) -> [String] {
        
        switch section {
        case 0:
            return date
        case 1:
            return date
        case 2:
            return date
        case 3:
            return date
        case 4:
            return date
        case 5:
            return date
        default:
            return []
        }
    }
    
}
