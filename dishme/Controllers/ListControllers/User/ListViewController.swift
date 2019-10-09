

//
//  ListViewController.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/09/20.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    let acountimage:[UIImage] = [UIImage(named: "acount1")!,
                                 UIImage(named: "acount2")!,
                                 UIImage(named: "acount3")!,
                                 UIImage(named: "acount4")!,
                                 UIImage(named: "acount5")!,]
    let time:[String] = ["13:00〜",
                         "12:00〜",
                         "13:00〜",
                         "15:00〜",
                         "19:00〜"]
    let acountname:[String] = ["焼肉大地",
                               "Ribface",
                               "Faceligh",
                               "timemeat",
                               "grilmow",]
    let date:[String] = ["５月３０日(火曜日)",
                         "５月１０日(木曜日)",
                         "５月２０日(水曜日)",
                         "５月３１日(金曜日)",
                         "５月２４日(火曜日)",]
    let position:[String] = ["basywater Sydny",
                             "三島みなみ店",
                             "八千代台緑ヶ丘",
                             "america gassyu",
                             "america misisipi",]

    @IBOutlet weak var tableView: UITableView!
    var tableView2: UITableView  =   UITableView()
    
    var alert = SweetAlert()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.frame = CGRect(x: 0, y: 0, width: 375, height: 812)
        view.addSubview(tableView)
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath as IndexPath) as! ListTableViewCell
        
        cell.acountImage.image = acountimage[indexPath.row]
        cell.acountImage.circle()
        cell.acountLabel.text = acountname[indexPath.row]
        cell.TimeLabel.text = time[indexPath.row]
        cell.Position.text = position[indexPath.row]
        
        cell.changeBtn.addTarget(self, action: #selector(self.change), for: .touchUpInside)
        cell.cancelBtn.addTarget(self, action: #selector(self.cancelbutton), for: .touchUpInside)
        
        //選択不可
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    @objc func change(){
        self.performSegue(withIdentifier: "toChangeReserve", sender: nil)
    }
    @objc func cancelbutton(){
        _ = SweetAlert().showAlert("予約をキャンセルしますか？", subTitle: "当日のキャンセルは店舗に直接電話しないとキャンセルができません。", style: AlertStyle.warning, buttonTitle:"いいえ", buttonColor:UIColor.colorFromRGB(0xD0D0D0) , otherButtonTitle:  "はい", otherButtonColor: UIColor.colorFromRGB(0xDD6B55)) { (isOtherButton) -> Void in
            if isOtherButton == true {
                
                _ = SweetAlert().showAlert("キャンセルしませんでした", subTitle: "Your imaginary file is safe", style: AlertStyle.error)
            }
            else {
                _ = SweetAlert().showAlert("予約がキャンセルされました", subTitle: "", style: AlertStyle.success)
            }
        }
    }
    
}
