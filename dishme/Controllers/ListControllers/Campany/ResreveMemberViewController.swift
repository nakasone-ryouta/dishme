


//
//  ResreveMemberViewController.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/10/04.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import UIKit

class ResreveMemberViewController: UIViewController {
    
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
    let phone:[Int] = [09069539797,
                       09069539797,
                       09069539797,
                       09069539797,
                       09069539797,]
    var call = ""
    
    let date:[String] = ["１０月７日(火曜日)",
                         "１０月６日(木曜日)",
                         "１０月５日(水曜日)",
                         "１０月４日(金曜日)",
                         "１０月３日(火曜日)",]

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tablesettings()
        
    }

}

extension ResreveMemberViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tablesettings(){
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let maxheight = view.frame.size.height
        let maxwidth = view.frame.size.width
        
        let BarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
        let tableheight = maxheight - tableView.frame.origin.y * 2 - BarHeight * 10
        print("bbbbbb",BarHeight)
        print("aaaaaaa",tableheight)
        
        
        tableView.frame = CGRect(x: 0, y: 0, width: Int(maxwidth), height: 360)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResreveMemberTableViewCell", for: indexPath) as! ResreveMemberTableViewCell
        
        cell.acountname.text = acountname[indexPath.row]
        cell.acountname.frame.origin.x = cell.acountImage.frame.origin.x
        cell.acountname.sizeToFit()
        
        
        cell.acountImage.image = acountimage[indexPath.row]
        cell.acountImage.circle()
        cell.time.text = listtime[indexPath.row]
        cell.phonenumber.text = phonenumber[indexPath.row]
        cell.callbutton.addTarget(self, action: #selector(callbutton), for: .touchUpInside)
        //選択不可
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    //ボタンから取得する
    @objc func callbutton(sender: UIButton){
        
        if let indexPath = tableView.indexPath(for: sender.superview!.superview as! UITableViewCell) {
            call = phonenumber[indexPath.row]
        } else {
            //ここには来ないはず
            print("not found...")
        }
        
        //電話をかける
        let url = NSURL(string: "tel://\(call)")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url as URL)
        } else {
            UIApplication.shared.openURL(url as URL)
        }
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
