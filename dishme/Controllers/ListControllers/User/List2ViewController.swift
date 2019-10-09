



//
//  List2ViewController.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/09/20.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import UIKit

class List2ViewController: UIViewController {
    
    //サインイン(企業orユーザ)
    var acountResister = "企業"
    
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
    
    //メニューのページ
    var pageMenu: PageMenuViewinit!
    
    let backview  = UIView()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backView()
        
        pagesettings()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "List2TableViewCell", bundle: nil), forCellReuseIdentifier: "List2TableViewCell")
    }
    //画面遷移(保存controller)
    func toList(){
        performSegue(withIdentifier: "toChangeReserve", sender: nil)
    }

}
extension List2ViewController{
    func backView(){
        backview.frame = CGRect(x: 0, y: 80, width: 375, height: 812)
        view.addSubview(backview)
    }
}

extension List2ViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "List2TableViewCell", for: indexPath) as! List2TableViewCell
        cell.acountName.text = acountname[indexPath.row]
        cell.acountImage.image = acountimage[indexPath.row]
        cell.acountImage.circle()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toSaveList", sender: nil)
    }
    
    
}
//メニューのレイアウト
extension List2ViewController:PageMenuViewDelegateinit{
    
    func willMoveToPage(_ pageMenu: PageMenuViewinit, from viewController: UIViewController, index currentViewControllerIndex: Int) {
        print("---------")
        print(viewController.title!)
    }
    
    func didMoveToPage(_ pageMenu: PageMenuViewinit, to viewController: UIViewController, index currentViewControllerIndex: Int) {
        print(viewController.title!)
    }
    
    func pagesettings(){
        
        let viewController1 = view1Controller(resister: acountResister)
        let viewController2 = view2Controller(resister: acountResister)
        let viewControllers = [viewController2 ,viewController1]
        
        
        
        // Init Page Menu with view controllers and UI option
        pageMenu = PageMenuViewinit(viewControllers: viewControllers, option: optionview())
        pageMenu.delegate = self
        backview.addSubview(pageMenu)
    }
    
    //企業側、ユーザ側を選ぶ
    func view1Controller(resister: String) ->UIViewController{
        switch acountResister {
        case "企業":
            let viewcontroller:HistoryMemberViewController = self.storyboard?.instantiateViewController(withIdentifier: "HistoryMemberViewController") as! HistoryMemberViewController
            viewcontroller.title = "履歴"
            return viewcontroller
            
        default:
            let viewcontroller = UIViewController()
            viewcontroller.view.backgroundColor = .blue
            viewcontroller.title = "保存"
            addSubviewSettings(controller: viewcontroller)
            return viewcontroller
        }
    }
    
    //企業側、ユーザ側を選ぶ
    func view2Controller(resister: String) ->UIViewController{
        switch acountResister {
        case "企業":
            let viewcontroller:ResreveMemberViewController = self.storyboard?.instantiateViewController(withIdentifier: "ResreveMemberViewController") as! ResreveMemberViewController
            viewcontroller.title = "予約者リスト"
            return viewcontroller
            
        default:
            let viewcontroller:ListViewController = self.storyboard?.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
            viewcontroller.title = "予約"
            return viewcontroller
        }
    }
    
    func optionview() ->PageMenuOption{
        // Page menu UI option
        var option = PageMenuOption(frame: CGRect(
            x: 0, y: 20, width: view.frame.size.width, height: view.frame.size.height - 20))
        
        // Page menu UI option
        option = PageMenuOption(
            frame: CGRect(x: 0, y: 20, width: view.frame.size.width, height: view.frame.size.height - 100))
        option.menuItemWidth = view.frame.size.width / 2
        option.menuTitleMargin = 0
        
        // Page menu UI option
        option = PageMenuOption(frame: CGRect(
            x: 0, y: 20, width: view.frame.size.width, height: view.frame.size.height - 20))
        option.menuItemWidth = view.frame.size.width / 2
        //ここ
        option.menuItemBackgroundColorNormal = .white
        option.menuItemBackgroundColorSelected = .white
        option.menuTitleMargin = 0
        option.menuTitleColorNormal = .black
        option.menuTitleFont = UIFont.init(name: "HelveticaNeue-Bold", size: 15)!
        option.menuTitleColorSelected = .black
        option.menuIndicatorHeight = 3
        option.menuIndicatorColor = UIColor.init(red: 55/255, green: 151/255, blue: 240/255, alpha: 1)
        
        return option
    }
    
    func addSubviewSettings(controller: UIViewController){
        tableView.frame = CGRect(x: 0, y: 0, width: 375, height: 812)
        controller.view.addSubview(tableView)
        
    }
    
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if UIDevice.current.orientation == .portrait {
            pageMenu.frame = CGRect(
                x: 0, y: 20, width: view.frame.size.width, height: view.frame.size.height - 100)
        } else {
            pageMenu.frame = CGRect(
                x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        }
    }
}
