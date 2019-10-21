//予約リスト

import UIKit
import SnapKit

class List2ViewController: UIViewController {
    
    //サインイン(企業orユーザ)
    var acountResister = "企業a"
    
    let acountimage:[UIImage] = [UIImage(named: "acount1")!,
                                 UIImage(named: "acount2")!,
                                 UIImage(named: "acount2")!,
                                 UIImage(named: "acount3")!,
                                 UIImage(named: "acount4")!,
                                 UIImage(named: "acount4")!,
                                 UIImage(named: "acount5")!,]
    let time:[String] = ["13:00〜",
                         "12:00〜",
                         "12:00〜",
                         "13:00〜",
                         "15:00〜",
                         "15:00〜",
                         "19:00〜"]
    let acountname:[String] = ["焼肉大地",
                               "Ribface",
                               "Faceligh",
                               "Faceligh",
                               "timemeat",
                               "timemeat",
                               "grilmow",]
    let date:[String] = ["５月３０日(火曜日)",
                         "５月１０日(木曜日)",
                         "５月２０日(水曜日)",
                         "５月３１日(金曜日)",
                         "５月３１日(金曜日)",
                         "５月３１日(金曜日)",
                         "５月２４日(火曜日)",]
    let position:[String] = ["basywater Sydny",
                             "三島みなみ店",
                             "八千代台緑ヶ丘",
                             "america gassyu",
                             "八千代台緑ヶ丘",
                             "america gassyu",
                             "america misisipi",]
    
    //メニューのページ
    var pageMenu: PageMenuViewinit!
    
    let backview  = UIView()

    @IBOutlet weak var tableView: UITableView!
    var reserve_tableView: UITableView  =   UITableView()
    
    //テーブルに表示するセル配列
    var items: [String] = ["Swift-Salaryman", "Manga-Salaryman", "Design-Salaryman"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backView()
        
        pagesettings()
        
        tablesettings()
        
        //navigationの基本設定
        setupNavigation()
    }

}
extension List2ViewController{
    func setupNavigation(){
        self.navigationController?.navigationBar.tintColor = .black
    }
}
extension List2ViewController{
    func backView(){
        
        let layout = Layouting()
        layout.list2backview(view: view, backview: backview)
        view.addSubview(backview)
    }
}
extension List2ViewController{
    //予約
    func tableview2settings(controller: UIViewController){
        reserve_tableView.frame         = CGRect(x: 0, y: 0, width: 375, height: 812)
        reserve_tableView.delegate      =   self
        reserve_tableView.dataSource    =   self
        reserve_tableView.separatorStyle = .none
    
        let tablelayout = Layouting()
        tablelayout.tableLayouting(tableview: reserve_tableView, view: view)
        
        reserve_tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        controller.view.addSubview(reserve_tableView)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 69
    }
}

//tableview周り
extension List2ViewController: UITableViewDataSource,UITableViewDelegate{
    
    // Section数
    func numberOfSections(in tableView: UITableView) -> Int {
        return date.count
    }
    
    //保存
    func tablesettings(){
        tableView.register (UINib(nibName: "List2TableViewCell", bundle: nil),forCellReuseIdentifier:"List2TableViewCell")
        //テーブルのレイアウト
        let tablelayout = Layouting()
        tablelayout.tableLayouting(tableview: tableView, view: view)
        
        tableView.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        //予約
        case reserve_tableView:
            return acountimage.count
        //保存
        default:
            return acountimage.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //予約
        if tableView == reserve_tableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
            cell.nameLabel.text = acountname[indexPath.row]
            cell.acountImage.image = acountimage[indexPath.row]
            cell.title1Label.text = "時間　\(time[indexPath.row])"
            cell.title2Label.text = "場所　\(position[indexPath.row])"
            
            cell.title1Label.sizeToFit()
            cell.title2Label.sizeToFit()
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            
            cell.leftButton.addTarget(self, action: #selector(self.cancelbutton), for: .touchUpInside)
            cell.rightButton.addTarget(self, action: #selector(self.change), for: .touchUpInside)
            
            cell.setPositions(view: view)
            return cell
        }
        //保存
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "List2TableViewCell", for: indexPath) as! List2TableViewCell
            cell.acountName.text = acountname[indexPath.row]
            cell.acountImage.image = acountimage[indexPath.row]
            cell.position.text = position[indexPath.row]
            cell.acountImage.circle()
            
            cell.reserveButton.addTarget(self, action: #selector(self.reserve), for: .touchUpInside)
            cell.reserveButton.tag = indexPath.row
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toSaveList", sender: nil)
    }
    
    
}

//tableviewのボタンアクション
extension List2ViewController{
    
    @objc func reserve(sender: UIButton){
        print("Index",sender.tag)
        performSegue(withIdentifier: "toReservation", sender: nil)
    }
    
    @objc func change(sender: UIButton){
        performSegue(withIdentifier: "toReservation", sender: nil)
    }
    @objc func cancelbutton(){
        _ = SweetAlert().showAlert("予約をキャンセルしますか？", subTitle: "当日のキャンセルは店舗に直接電話しないとキャンセルができません。", style: AlertStyle.warning, buttonTitle:"いいえ", buttonColor:UIColor.colorFromRGB(0xD0D0D0) , otherButtonTitle:  "はい", otherButtonColor: UIColor.colorFromRGB(0xDD6B55)) { (isOtherButton) -> Void in
            if isOtherButton == true {
            }
            else {
                _ = SweetAlert().showAlert("予約がキャンセルされました", subTitle: "", style: AlertStyle.success)
            }
        }
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
            let viewcontroller:HistoryViewController = self.storyboard?.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
            viewcontroller.title = "履歴"
            return viewcontroller
            
        default:
            
            let viewcontroller = UIViewController()
            viewcontroller.view.backgroundColor = .white
            viewcontroller.title = "保存"
            addSubviewSettings(controller: viewcontroller)
            return viewcontroller
        }
    }
    
    //企業側、ユーザ側を選ぶ
    func view2Controller(resister: String) ->UIViewController{
        switch acountResister {
        case "企業":
            let viewcontroller:MemberViewController = self.storyboard?.instantiateViewController(withIdentifier: "MemberViewController") as! MemberViewController
            viewcontroller.title = "予約者リスト"
            return viewcontroller
            
        default:
            let viewcontroller = UIViewController()
            viewcontroller.view.backgroundColor = .white
            viewcontroller.title = "予約"
            tableview2settings(controller: viewcontroller)
            return viewcontroller
        }
    }
    
    func optionview() ->PageMenuOption{
        // Page menu UI option
        //navigationの高さ
        let navBarHeight = self.navigationController?.navigationBar.frame.size.height
        
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
        option.menuItemHeight = navBarHeight!
        option.menuItemBackgroundColorNormal = .white
        option.menuItemBackgroundColorSelected = .white
        option.menuTitleMargin = 0
        option.menuTitleColorNormal = .black
        option.menuTitleFont = UIFont.init(name: "HelveticaNeue-Medium", size: 15)!
        option.menuTitleColorSelected = .black
        option.menuIndicatorHeight = 3
        option.menuIndicatorColor = UIColor.init(red: 55/255, green: 151/255, blue: 240/255, alpha: 1)
        
        return option
    }
    
    func addSubviewSettings(controller: UIViewController){
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "List2TableViewCell", bundle: nil), forCellReuseIdentifier: "List2TableViewCell")
        
        
        tableView.frame = CGRect(x: 0, y: 0, width: 375, height: 0)
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

