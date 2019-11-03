
//
//  EditRegularHolidayViewController.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/10/06.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import UIKit

class EditRegularHolidayViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    var customcolor = CustomColor()
    
    var days = ["毎日曜日",
                "毎月曜日",
                "毎火曜日",
                "毎水曜日",
                "毎木曜日",
                "毎金曜日",
                "毎土曜日",
                ]
    
    var time = ["13:00〜19:00","13:00〜19:00","13:00〜19:00","13:00〜19:00","13:00〜19:00","13:00〜19:00","休業"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //テーブルの基本設定
        tablesettings()
        
        setupNavigation()
        
    }
}
//navigation周り
extension EditRegularHolidayViewController{
    func setupNavigation(){
        // タイトルをセット
        self.navigationItem.title = "営業時間"
    }
    @objc func save(){
        _ = SweetAlert().showAlert("変更保存しました", subTitle: "臨時休業になりました", style: AlertStyle.success)
        self.navigationController?.popViewController(animated: true)
    }
}

//tableviewの表示部分
extension EditRegularHolidayViewController: UITableViewDataSource,UITableViewDelegate{
    func tablesettings(){
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Home")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: .value1, reuseIdentifier: "Home")
        cell.textLabel?.text = days[indexPath.row]
        cell.detailTextLabel?.text = time[indexPath.row]
        cell.textLabel?.textAlignment = NSTextAlignment.right
        cell.textLabel?.font = UIFont.init(name: "HelveticaNeue-Medium", size: 13)
        cell.detailTextLabel?.font = UIFont.init(name: "HelveticaNeue-Medium", size: 13)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        
        cell.tintColor = customcolor.selectColor()
        cell.backgroundColor = .white
    }
    
    
}
