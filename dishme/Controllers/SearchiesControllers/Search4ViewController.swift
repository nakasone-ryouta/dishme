import UIKit
import AMScrollingNavbar

class Search4ViewController: UIViewController {
    
    //次の画面に渡す値
    var firstindex: IndexPath? = nil
    
    //メニューのページ
    var pageMenu: PageMenuViewinit!
    
    //ページメニューのview
    let backview = UIView()
    
    //メニューのcollectionview
    var collectionView: UICollectionView!
    
    //お金
    var money:[Int] = [3200,
                       2000,
                       7655,
                       1234,
                       2344,
                       9876,
                       654,
                       112,
                       9986,
                       3200,
                       2000,
                       7655,
                       1234,
                       2344,
                       9876,
                       ]
    
    //料理
    var dishes:[UIImage] = [UIImage(named: "meat1")!,
                            UIImage(named: "meat2")!,
                            UIImage(named: "meat3")!,
                            UIImage(named: "meat4")!,
                            UIImage(named: "meat5")!,
                            UIImage(named: "meat6")!,
                            UIImage(named: "meat7")!,
                            UIImage(named: "meat8")!,
                            UIImage(named: "meat9")!,
                            UIImage(named: "meat10")!,
                            UIImage(named: "meat11")!,
                            UIImage(named: "meat12")!,
                            UIImage(named: "meat13")!,
                            UIImage(named: "meat14")!,
                            UIImage(named: "meat15")!,
                            ]
    
    //料理
    var name:[String] = ["meat1",
                         "meat2",
                         "meat3",
                         "meat4",
                         "meat5",
                         "meat6",
                         "meat7",
                         "meat8",
                         "meat9",
                         "meat10",
                         "meat11",
                         "meat12",
                         "meat13",
                         "meat14",
                         "meat15",
                         ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //pageviewの下に敷くview
        background()

        //メニューの設定
        pagesettings()
    }
    
    func background(){
        backview.frame = CGRect(x: 0,
                                y: 88,
                                width: view.frame.size.width,
                                height: view.frame.size.height)
        backview.backgroundColor = UIColor.init(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        self.view.addSubview(backview)
    }


}

//メニューのレイアウト
extension Search4ViewController:PageMenuViewDelegateinit{
    func willMoveToPage(_ pageMenu: PageMenuViewinit, from viewController: UIViewController, index currentViewControllerIndex: Int) {
        print("---------")
        print(viewController.title!)
    }
    
    func didMoveToPage(_ pageMenu: PageMenuViewinit, to viewController: UIViewController, index currentViewControllerIndex: Int) {
        print(viewController.title!)
    }
    
    func pagesettings(){
        // Init View Contollers
        let viewController1 = UIViewController()
        viewController1.view.backgroundColor = .blue
        viewController1.title = "メインメニュー"
        
        let viewController2 = UIViewController()
        viewController2.view.backgroundColor = .green
        viewController2.title = "サイドメニュー"
        
        let viewController3 = UIViewController()
        viewController3.view.backgroundColor = .yellow
        viewController3.title = "ドリンク"
        
        // Add to array
        let viewControllers = [viewController1, viewController2, viewController3]
        
        //メニュー写真の追加

        tableviewsettings(controller: viewController1)
        tableviewsettings(controller: viewController2)
        tableviewsettings(controller: viewController3)
        
        
        // Init Page Menu with view controllers and UI option
        pageMenu = PageMenuViewinit(viewControllers: viewControllers, option: optionview())
        pageMenu.delegate = self
        backview.addSubview(pageMenu)
    }
    
    func optionview() ->PageMenuOption{
        // Page menu UI option
        var option = PageMenuOption(frame: CGRect(
            x: 0, y: 20, width: view.frame.size.width, height: view.frame.size.height - 20))
        
        // ページメニュー
        option = PageMenuOption(
            frame: CGRect(x: 0, y: 20, width: view.frame.size.width, height: view.frame.size.height - 100))
        option.menuItemWidth = view.frame.size.width / 3
        option.menuTitleMargin = 0
        
        //ページメニュー
        option = PageMenuOption(frame: CGRect(
            x: 0, y: 20, width: view.frame.size.width, height: view.frame.size.height - 20))
        option.menuItemWidth = view.frame.size.width / 3
        //ここ
        option.menuItemBackgroundColorNormal = UIColor.init(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        option.menuItemBackgroundColorSelected = UIColor.init(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        option.menuTitleMargin = 0
        option.menuTitleColorNormal = .black
        option.menuTitleFont = UIFont.init(name: "HelveticaNeue-Bold", size: 15)!
        option.menuTitleColorSelected = .black
        option.menuIndicatorHeight = 3
        option.menuIndicatorColor = UIColor.init(red: 55/255, green: 151/255, blue: 240/255, alpha: 1)
        
        return option
    }
    
    
    //pageの全体位置を決めている
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if UIDevice.current.orientation == .portrait {
            pageMenu.frame = CGRect(
                x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height - 100)
        } else {
            pageMenu.frame = CGRect(
                x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        }
    }
    
}
extension Search4ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableviewsettings(controller: UIViewController){
        
        //インスタンス化
        let tableView: UITableView  =   UITableView()
        
        //下から出てくるtableview
        tableView.frame = CGRect(
            x: 0.0,
            y: 0,
            width: self.view.frame.width,
            height: 690
        )
        
        tableView.delegate      =   self
        tableView.dataSource    =   self
        tableView.separatorStyle = .none
        
        tableView.backgroundColor = UIColor.init(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        tableView.register (UINib(nibName: "Search4TableViewCell", bundle: nil),forCellReuseIdentifier:"Search4TableViewCell")
        tableView.contentMode = .scaleAspectFit
        
        DispatchQueue.main.async {
            tableView.scrollToRow(at: self.firstindex!, at: UITableView.ScrollPosition.top, animated: false)
        }
        
        controller.view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Search4TableViewCell") as! Search4TableViewCell
        
        cell.dishImage.image = dishes[indexPath.row]
        cell.dishName.text = name[indexPath.row]
        cell.money.text = "\(money[indexPath.row])/人"
        
        //選択不可
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 375
    }
}
