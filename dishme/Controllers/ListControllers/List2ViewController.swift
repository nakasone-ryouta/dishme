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
    let time:[String] = ["13:00",
                         "12:00",
                         "12:00",
                         "13:00",
                         "15:00",
                         "15:00",
                         "19:00"]
    let acountname:[String] = ["焼肉大地",
                               "Ribface",
                               "Faceligh",
                               "Faceligh",
                               "timemeat",
                               "timemeat",
                               "grilmow",]
    let date:[String] = ["５月１日(火曜日)",
                         "５月１０日(木曜日)",
                         "５月２０日(水曜日)",
                         "５月２１日(金曜日)",
                         "５月２２日(金曜日)",
                         "５月２３日(金曜日)",
                         "５月２４日(火曜日)",]
    let position:[String] = ["basywater Sydny",
                             "三島みなみ店",
                             "八千代台緑ヶ丘",
                             "america gassyu",
                             "八千代台緑ヶ丘",
                             "america gassyu",
                             "america misisipi",]
    
    let km:[Int] = [13,53,1,5,21,5,12,76,88,10]
    
    var callnumber = "09012320280"
    
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
        
        //navigationの基本設定
        setupNavigation()
    }

}
extension List2ViewController{
    func setupNavigation(){
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.title = "チェックリスト"
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

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 69
    }
}

//tableview周り
extension List2ViewController: UITableViewDataSource,UITableViewDelegate{
    
    //保存
    func tableviewsettings(controller: UIViewController){
        tableView.register (UINib(nibName: "List2TableViewCell", bundle: nil),forCellReuseIdentifier:"List2TableViewCell")
        //テーブルのレイアウト
        let tablelayout = Layouting()
        tablelayout.tableLayouting(tableview: tableView, view: view)
        tableView.separatorStyle = .none
        controller.view.addSubview(tableView)
    }
    //予約
    func tableview2settings(controller: UIViewController){
        reserve_tableView.delegate      =   self
        reserve_tableView.dataSource    =   self
        reserve_tableView.separatorStyle = .none
        
        let tablelayout = Layouting()
        tablelayout.tableLayouting(tableview: reserve_tableView, view: view)
        
        reserve_tableView.register (UINib(nibName: "List2TableViewCell", bundle: nil),forCellReuseIdentifier:"List2TableViewCell")
        controller.view.addSubview(reserve_tableView)
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "List2TableViewCell", for: indexPath) as! List2TableViewCell
            cell.acountName.text = acountname[indexPath.row]
            cell.acountImage.image = acountimage[indexPath.row]
            cell.position.text = "\(km[indexPath.row])Km"
            cell.acountImage.circle()
            
            cell.reserveButton.addTarget(self, action: #selector(self.reserve), for: .touchUpInside)
            cell.reserveButton.tag = indexPath.row
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }
        //保存
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "List2TableViewCell", for: indexPath) as! List2TableViewCell
            cell.acountName.text = acountname[indexPath.row]
            cell.acountImage.image = acountimage[indexPath.row]
            cell.position.text = "\(km[indexPath.row])Km"
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
    
    //画面に渡す値
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toYouserAcount"{
            let nextView = segue.destination as! YouserAcountViewController
            nextView.spectator = "観覧ユーザ"
        }
    }
    
}

//tableviewのボタンアクション
extension List2ViewController{
    
    @objc func reserve(sender: UIButton){
        //電話をかける
        let url = NSURL(string: "tel://\(callnumber)")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url as URL)
        } else {
            UIApplication.shared.openURL(url as URL)
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
        
        let viewcontroller1 = UIViewController()
        viewcontroller1.view.backgroundColor = .white
        viewcontroller1.title = "保存"
        
        let viewcontroller2 = UIViewController()
        viewcontroller2.view.backgroundColor = .white
        viewcontroller2.title = "いいね"

        let viewControllers = [viewcontroller1 ,viewcontroller2]

        //tableview1の追加
        tableviewsettings(controller: viewcontroller1)
        tableview2settings(controller: viewcontroller2)
        //tableview2の追加
        


        // Init Page Menu with view controllers and UI option
        pageMenu = PageMenuViewinit(viewControllers: viewControllers, option: optionview())
        pageMenu.delegate = self
        backview.addSubview(pageMenu)

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
        let customcolor = CustomColor()
        option.menuIndicatorColor = customcolor.selectColor()

        return option
    }

    func addSubviewSettings(controller: UIViewController){

        tableView.delegate = self
        tableView.dataSource = self

        self.tableView.register(UINib(nibName: "ReserveTableViewCell", bundle: nil), forCellReuseIdentifier: "ReserveTableViewCell")


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

