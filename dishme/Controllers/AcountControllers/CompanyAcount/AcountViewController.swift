//
//  Search3ViewController.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/09/13.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import UIKit
import Expression
import AMScrollingNavbar
import MessageUI

class AcountViewController: UIViewController,ScrollingNavigationControllerDelegate{
    
    //=========================================下から=====================================================
    
    var alert = Alert()
    // Constant
    let commentViewHeight: CGFloat = 50.0
    let animatorDuration: TimeInterval = 1
    
    // UI
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var blurEffectView: UIVisualEffectView!
    //    @IBOutlet weak var closeButton: UIButton!
    //    @IBOutlet weak var backButton: UIButton!
    
    var customcolor = CustomColor()
    
    
    var commentView = UIView()
    var commentTitleLabel = UILabel()
    var commentDummyView = UIImageView()
    
    // Tracks all running aninmators
    var progressWhenInterrupted: CGFloat = 0
    var runningAnimators = [UIViewPropertyAnimator]()
    var state: State = .collapsed
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    //=========================================下から=====================================================
    
    
    var tablesettings = TableSettings()
    
    
    //スクロールview
    let scrollView = UIScrollView()
    let backview = UIView()
    
    
    //メニューのページ
    var pageMenu: PageMenuViewinit!
    
    //メニューのcollectionview
    var collectionView1: UICollectionView!
    var collectionView2: UICollectionView!
    var collectionView3: UICollectionView!
    
    //下から出てくるview
    let tableView2:UITableView = UITableView()
    
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
                            ]
    
    //料理
    var sidemenus:[UIImage] = [UIImage(named: "sidemenu1")!,
                               UIImage(named: "sidemenu2")!,
                               UIImage(named: "sidemenu3")!,
                               UIImage(named: "sidemenu4")!,
                               UIImage(named: "sidemenu5")!,
                               UIImage(named: "sidemenu6")!,
                               UIImage(named: "sidemenu7")!,
                               UIImage(named: "sidemenu8")!,
                               UIImage(named: "sidemenu9")!,
                               UIImage(named: "sidemenu10")!,
                               ]
    
    //料理
    var softdrink:[UIImage] = [UIImage(named: "softdrink1")!,
                               UIImage(named: "softdrink2")!,
                               UIImage(named: "softdrink3")!,
                               UIImage(named: "softdrink4")!,
                               UIImage(named: "softdrink5")!,
                               UIImage(named: "softdrink6")!,
                               UIImage(named: "softdrink7")!,
                               UIImage(named: "softdrink8")!,
                               UIImage(named: "softdrink9")!,
                               UIImage(named: "softdrink10")!,
                               ]
    
    var appearance:[UIImage] = [UIImage(named: "appearance1")!,
                                UIImage(named: "appearance2")!,
                                UIImage(named: "appearance3")!,
                                UIImage(named: "appearance4")!,
                                UIImage(named: "appearance5")!,
                                UIImage(named: "appearance6")!,
                                UIImage(named: "appearance7")!,
                                UIImage(named: "appearance8")!,
                                UIImage(named: "appearance9")!,
                                UIImage(named: "appearance10")!,
                                ]
    
    var setting:[String] = ["ログアウト","振込口座の変更","お知らせ","写真を非公開にする","問題を管理者に報告","利用規約","会員規約"," プライバシーポリシー"]
    
    //レストラン情報
    var tableView1: UITableView  =   UITableView()
    var opentitle = "営業中"
    var opentime = "12:00〜13:00"
    var position = "御殿場市大阪１８１−２"
    var acountname = "Ribe Face"
    var acountimage = UIImage(named: "acount1")
    var congestion = "混雑時間"
    var maxnumber = "10"
    var phonenumber = 08069539797
    var congestiontime = "AM 13:00〜AM 14:00"
    var yummynumber = 237
    var yuckynumber = 325

    var comment = "春の旬のふきのとうや新鮮なリブステーキを兼ね揃えております。今ご来場していただいた方には次回からお使いいただけるクーポンも配布中です。"
    var avaragemoney = "¥6,280〜¥10,000"
    var holiday = "毎週水曜日"
    var temporaryClosed = "2019/8/24"
    var category = "和食"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //スクロールviewの基本設定
        scrollbackview()
        
        //インスタンス化
        backgroundcontroller()
        
        //メニューの設定
        pagesettings()
        
        //navigationの基本設定
        setupNavigation()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //各種設定の基本設定
        variousSettings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        scrollDownsettings()
    }
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        scrollStopsettings()
    }
    
}
//スクロールまわり
extension AcountViewController{
    //スクロールした時tabbarを引っ込める
    func scrollDownsettings(){
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            if let tabBarController = tabBarController {
                navigationController.followScrollView(scrollView, delay: 0, scrollSpeedFactor: 2, followers: [NavigationBarFollower(view: tabBarController.tabBar, direction: .scrollDown)])
            } else {
                navigationController.followScrollView(scrollView, delay: 0.0, scrollSpeedFactor: 2)
            }
            navigationController.scrollingNavbarDelegate = self
            navigationController.expandOnActive = false
        }
    }
    //
    func scrollStopsettings(){
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            navigationController.stopFollowingScrollView()
        }
    }
    open func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            navigationController.showNavbar(animated: true)
        }
        return true
    }
}

//右上のボタンの設定
extension AcountViewController{
    func setupNavigation(){
        self.navigationItem.hidesBackButton = true
        
        
        let button = UIBarButtonItem(image: UIImage(named: "settingitem")?.withRenderingMode(.alwaysOriginal),
                                     style: .plain,
                                     target: self,
                                     action: #selector(settingaction));
        self.navigationItem.rightBarButtonItem = button
    }
    @objc func settingaction(){
        //したから設定のviewを出す
        self.animateOrReverseRunningTransition(state: self.nextState(), duration: animatorDuration)
    }
}

//スクロールviewの基本設定
extension AcountViewController{
    func scrollbackview(){
        
        let cellheight = CellsHeight()
        //一番大きい要素数を入れる
        let celltotal:[Int] = [dishes.count]
        let height = cellheight.totalHeight(cellsum: celltotal, view: view)
        let width = Int(view.frame.size.width)
        scrollView.frame = self.view.frame
        scrollView.contentSize = CGSize(width:width, height:680 + height + 85)
        self.view.addSubview(scrollView)
        
        
        backview.frame = CGRect(x: 0,
                                y:690,
                                width: scrollView.frame.size.width,
                                height: scrollView.frame.size.height)
        self.scrollView.addSubview(backview)
        
        
    }
}

//基本レイアウト周り
extension AcountViewController{
    func backgroundcontroller(){
        restaurantInfo()
        acontlabel()
        acountimageview()
        comentview()
        messageButton()
        
        //yummyボタン
        goodButton()
        //yuckyボタン
        badButton()
        
    }
    func messageButton(){
        
        let navBarHeight = self.navigationController?.navigationBar.frame.size.height
        let width = view.frame.size.width
        // UIButtonのインスタンスを作成する
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(editsegue), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: width / 2.286,
                              y: navBarHeight! + 72,
                              width: width / 1.923,
                              height: width / 12.93);
        button.setImage(UIImage(named: "editbar"), for: UIControl.State())
        scrollView.addSubview(button)
    }
    
    func acountimageview(){
        let image = UIImageView()
        image.image = acountimage
        image.frame = CGRect(x: 17, y: 20, width: 85, height: 85)
        image.circle()
        self.scrollView.addSubview(image)
        
    }
    func comentview(){
        let maxwidth = view.frame.size.width
        let maxheight = view.frame.size.height
        let label = UILabel()
        label.frame =  CGRect(x: 17, y: 154, width: maxwidth / 1.1, height: maxheight / 12.5)
        label.text = comment
        label.textColor = UIColor.darkGray
        label.font = UIFont.init(name: "HelveticaNeue-Thin", size: 13)
        label.textAlignment = NSTextAlignment.left
        label.numberOfLines = 4
        label.sizeToFit()
        scrollView.addSubview(label)
    }
    func acontlabel(){
        let label = UILabel()
        label.frame =  CGRect(x: 23, y: 116, width: 0, height: 0)
        label.text = acountname
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "HelveticaNeue-Medium", size: 16)
        label.textAlignment = NSTextAlignment.right
        label.sizeToFit()
        scrollView.addSubview(label)
    }
    
    func goodButton(){
        // ナビゲーションバーの高さを取得
        let navBarHeight = self.navigationController?.navigationBar.frame.size.height
        let maxwidth = view.frame.size.width
        
        // UIButtonのインスタンスを作成する
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(good), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: maxwidth / 1.74,
                              y: navBarHeight! + 22,
                              width: 22,
                              height: 20);
        button.setImage(UIImage(named: "good"), for: UIControl.State())
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.scrollView.addSubview(button)
        
        //継承する
        Yummynumber(button: button)
        
    }
    
    func Yummynumber(button: UIButton){
        
        let label = UILabel()
        label.frame =  CGRect(x: 0, y: 0, width: 50, height: 30)
        label.frame.origin.x = button.frame.origin.x - 60
        label.frame.origin.y = button.frame.origin.y - 5
        label.text = "\(yummynumber)"
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "HelveticaNeue-Medium", size: 18)
        label.textAlignment = NSTextAlignment.center
        scrollView.addSubview(label)
        
        //継承する
        Yummylabel(button: button, label: label)
    }
    
    func Yummylabel(button :UIButton ,label: UILabel){
        // ナビゲーションバーの高さを取得
        let navBarHeight = self.navigationController?.navigationBar.frame.size.height
        
        let label = UILabel()
        label.frame =  CGRect(x: 0, y: 0, width: 50, height: 30)
        label.frame.origin.x = button.frame.origin.x - 60
        label.frame.origin.y = button.frame.origin.y + 20
        label.text = "YUMMY"
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "HelveticaNeue-Medium", size: 13)
        label.textAlignment = NSTextAlignment.center
        scrollView.addSubview(label)
    }
    
    @objc func good(){
        
    }
    //yuckyボタン周り
    func badButton(){
        
        // ナビゲーションバーの高さを取得
        let navBarHeight = self.navigationController?.navigationBar.frame.size.height
        let maxwidth = view.frame.size.width
        
        // UIButtonのインスタンスを作成する
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(good), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: maxwidth / 1.17,
                              y: navBarHeight! + 22,
                              width: 22,
                              height: 20);
        button.setImage(UIImage(named: "bad"), for: UIControl.State())
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        scrollView.addSubview(button)
        
        
        Yuckynumber(button: button)
        Yuckylabel(button: button)
        
    }
    
    func Yuckynumber(button : UIButton){
        // ナビゲーションバーの高さを取得
        let navBarHeight = self.navigationController?.navigationBar.frame.size.height
        
        let label = UILabel()
        label.frame =  CGRect(x: 0, y: navBarHeight! + 100, width: 50, height: 30)
        label.frame.origin.x = button.frame.origin.x - 50
        label.frame.origin.y = button.frame.origin.y
        label.text = "\(yuckynumber)"
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "HelveticaNeue-Medium", size: 18)
        label.textAlignment = NSTextAlignment.center
        label.sizeToFit()
        scrollView.addSubview(label)
        
        Yuckylabel(button: button)
    }
    
    func Yuckylabel(button :UIButton){
        
        // ナビゲーションバーの高さを取得
        let navBarHeight = self.navigationController?.navigationBar.frame.size.height
        
        let label = UILabel()
        label.frame =  CGRect(x: 0, y: navBarHeight! + 120, width: 50, height: 30)
        label.frame.origin.x = button.frame.origin.x - 55
        label.frame.origin.y = button.frame.origin.y + 28
        label.text = "YUCKY"
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "HelveticaNeue-Medium", size: 13)
        label.textAlignment = NSTextAlignment.center
        label.sizeToFit()
        scrollView.addSubview(label)
        
    }
    
    @objc func bad(){
        
    }
    @objc func editsegue(){
        performSegue(withIdentifier: "toEdit", sender: nil)
    }
}

//tableviewの設定
extension AcountViewController{
    
    //レストラン情報のテーブル
    func restaurantInfo(){
        
        //下から出てくるtableview
        tableView1.frame = CGRect(
            x: 0.0,
            y: 217,
            width: self.view.frame.width,
            height: 500
        )
        
        tableView1.delegate      =   self
        tableView1.dataSource    =   self
        //        tableView.separatorStyle = .none
        tableView1.backgroundColor = UIColor.init(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        tableView1.register(UITableViewCell.self, forCellReuseIdentifier: "Home")
        tableView1.contentMode = .scaleAspectFit
        tableView1.layer.borderWidth = 1
        tableView1.layer.borderColor = UIColor(red: 208/255, green: 208/255, blue:208/255, alpha: 1).cgColor
        tableView1.estimatedRowHeight = 66
        tableView1.sectionHeaderHeight = 57
        tableView1.rowHeight = UITableView.automaticDimension
        scrollView.addSubview(tableView1)
    }
    
    //各種設定のテーブル
    func table2settings(){
        let width = view.frame.size.width
        let height = view.frame.size.height
        tableView2.delegate = self
        tableView2.dataSource = self
        
        tableView2.frame = CGRect(x: 0, y: 70, width: width, height: height/1.624)
        tableView2.register(UITableViewCell.self, forCellReuseIdentifier: "Info")
        tableView2.contentMode = .scaleAspectFit
        tableView2.tableFooterView = UIView(frame: .zero)
        tableView2.isScrollEnabled = false
        commentView.addSubview(tableView2)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView {
        case tableView1: //レストラン情報のテーブル
            return 10
        default:        //各種設定のテーブル
            return setting.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //レストラン情報のテーブル
        if tableView == tableView1{
        let cell:UITableViewCell = UITableViewCell(style: .subtitle, reuseIdentifier: "Home")
            
            tablesettings.AcountTableCellForRowAt(cell: cell, indexPath: indexPath, opentitle: opentitle, opentime: opentime, congestion: congestion, congestiontime: congestiontime, position: position, phonenumber: phonenumber, maxnumber: maxnumber, holiday: holiday, temporaryClosed: temporaryClosed, avaragemoney: avaragemoney, category: category)
        return cell
        }
            
        //各種設定のテーブル
        else{
            let cell:UITableViewCell = UITableViewCell(style: .value1, reuseIdentifier: "Info")
            cell.textLabel?.text = setting[indexPath.row]
            cell.textLabel?.font = UIFont.init(name: "HelveticaNeue-Thin", size: 15)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //各種設定のテーブル
        switch tableView {
        case tableView2:
            tablesettings.AcountTableDidSelectRowAt(indexPath: indexPath)
            if indexPath.row == 2{
                performSegue(withIdentifier: "toNotice", sender: nil)
            }
            else if indexPath.row == 5{
                emailbutton()
            }
        default:
            break;
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        //レストラン情報のテーブル
        if tableView == tableView1{
            return 44
        }
        //各種設定のテーブル
        else{
            let layout = Layouting()
            return CGFloat(layout.acountTableCellHeighting(view: view))
        }
    }
    //[レストラン情報]と表示するヘッダー
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        
        
        switch tableView {
        case tableView1:  //レストラン情報のテーブル
            let header = tablesettings.hederInSection()
            return header
        default:          //各種設定のテーブル
            let header = UIView()
            return header
        }
    }
}

//[メインメニュ][サイドメニュ][ドリンク]写真を表示するcollection
extension AcountViewController: UICollectionViewDataSource ,UICollectionViewDelegate{
    // セルの数を返す
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case collectionView1:
            return dishes.count
        case collectionView2:
            return softdrink.count
        case collectionView3:
            return appearance.count
        default:
            return sidemenus.count
        }
    }
    
    
    // セルの設定
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",for: indexPath as IndexPath) as! AcountCollectionViewCell
        
        let size = Int(view.frame.size.width / 3)
        
        switch  collectionView{
        case collectionView1:
            let cellImage = dishes[indexPath.row]
            cell.setUpContents(image: cellImage, size: size)
        case collectionView2://メニュー
            let cellImage = sidemenus[indexPath.row]
            cell.setUpContents(image: cellImage, size: size)
        case collectionView3://雰囲気
            let cellImage = appearance[indexPath.row]
            cell.setUpContents(image: cellImage, size: size)
        default:
            break;
        }
        return cell
    }
    //レイアウト周り
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout:UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let horizontalSpace:CGFloat = 1
        let cellSize:CGFloat = self.view.bounds.width/3 - horizontalSpace
        
        return CGSize(width: cellSize, height: cellSize)
    }
    
}

extension AcountViewController:  UICollectionViewDelegateFlowLayout {
    
    
    func collection1settings(viewcontroller: UIViewController){
        collectionView1 = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 750), collectionViewLayout: UICollectionViewFlowLayout())
        collectionView1.backgroundColor = UIColor.white
        collectionView1.register(AcountCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        collectionView1.delegate = self
        collectionView1.dataSource = self
        
        // レイアウト設定
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        collectionView1.collectionViewLayout = layout
        
        viewcontroller.view.addSubview(collectionView1)
    }
    
    func collection2settings(viewcontroller: UIViewController){
        collectionView2 = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 750), collectionViewLayout: UICollectionViewFlowLayout())
        collectionView2.backgroundColor = UIColor.white
        collectionView2.register(AcountCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        collectionView2.delegate = self
        collectionView2.dataSource = self
        
        // レイアウト設定
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        collectionView2.collectionViewLayout = layout
        
        viewcontroller.view.addSubview(collectionView2)
    }
    
    func collection3settings(viewcontroller: UIViewController){
        collectionView3 = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 750), collectionViewLayout: UICollectionViewFlowLayout())
        collectionView3.backgroundColor = UIColor.white
        collectionView3.register(AcountCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        collectionView3.delegate = self
        collectionView3.dataSource = self
        
        // レイアウト設定
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        collectionView3.collectionViewLayout = layout
        
        viewcontroller.view.addSubview(collectionView3)
    }
    
}


//メニューのレイアウト
extension AcountViewController:PageMenuViewDelegateinit{
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
        viewController1.title = "おすすめ"
        
        let viewController2 = UIViewController()
        viewController2.view.backgroundColor = .green
        viewController2.title = "メニュー"
        
        let viewController3 = UIViewController()
        viewController3.view.backgroundColor = .yellow
        viewController3.title = "雰囲気"
        
        // Add to array
        let viewControllers = [viewController1, viewController2, viewController3]
        
        //メニュー写真の追加
        collection1settings(viewcontroller: viewController1)
        collection2settings(viewcontroller: viewController2)
        collection3settings(viewcontroller: viewController3)
        
        
        // Init Page Menu with view controllers and UI option
        pageMenu = PageMenuViewinit(viewControllers: viewControllers, option: optionview())
        pageMenu.delegate = self
        backview.addSubview(pageMenu)
    }
    
    func optionview() ->PageMenuOption{
        // Page menu UI option
        var option = PageMenuOption(frame: CGRect(
            x: 0, y: 20, width: view.frame.size.width, height: view.frame.size.height - 20))
        
        // Page menu UI option
        option = PageMenuOption(
            frame: CGRect(x: 0, y: 20, width: view.frame.size.width, height: view.frame.size.height - 100))
        option.menuItemWidth = view.frame.size.width / 3
        option.menuTitleMargin = 0
        
        // Page menu UI option
        option = PageMenuOption(frame: CGRect(
            x: 0, y: 20, width: view.frame.size.width, height: view.frame.size.height - 20))
        option.menuItemWidth = view.frame.size.width / 3
        //ここ
        option.menuItemBackgroundColorNormal = .white
        option.menuItemBackgroundColorSelected = .white
        option.menuTitleMargin = 0
        option.menuTitleColorNormal = .black
        option.menuTitleFont = UIFont.init(name: "HelveticaNeue-Bold", size: 15)!
        option.menuTitleColorSelected = .black
        option.menuIndicatorHeight = 3
        option.menuIndicatorColor = customcolor.selectColor()
        
        return option
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




//===================================ここから下から出てくる各種設定=================================================
extension AcountViewController :UITableViewDelegate,UITableViewDataSource{
    
    func variousSettings(){
        view.bringSubviewToFront(blurEffectView)
        self.initSubViews()
        self.addGestures()
        table2settings()
    }
    
    private func initSubViews() {
        self.blurEffectView.effect = nil
        
        // Collapsed comment view
        commentView.frame = self.collapsedFrame()
        commentView.backgroundColor = .white
        self.view.addSubview(commentView)
        
        // Title label
        commentTitleLabel.text = "各種設定"
        commentTitleLabel.sizeToFit()
        commentTitleLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
        commentTitleLabel.center = CGPoint(x: self.view.frame.width / 2, y: commentViewHeight / 2)
        commentView.addSubview(commentTitleLabel)
        
        // Dummy view
        commentDummyView.frame = CGRect(
            x: 0.0,
            y: commentViewHeight,
            width: self.view.frame.width,
            height: self.view.frame.height - self.headerView.frame.height
        )
        commentDummyView.image = UIImage(named: "comments")
        commentDummyView.contentMode = .scaleAspectFit
        commentView.addSubview(commentDummyView)
    }
    
    private func addGestures() {
        // Tap gesture
        //        commentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture(_:))))
        
        // Pan gesutre
        commentView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(_:))))
    }
    
    // MARK: Util
    private func expandedFrame() -> CGRect {
        return CGRect(
            x: 0,
            y: self.headerView.frame.height,
            width: self.view.frame.width,
            height: self.view.frame.height - self.headerView.frame.height
        )
    }
    
    private func collapsedFrame() -> CGRect {
        return CGRect(
            x: 0,
            y: self.view.frame.height - commentViewHeight,
            width: self.view.frame.width,
            height: commentViewHeight)
    }
    
    private func fractionComplete(state: State, translation: CGPoint) -> CGFloat {
        let translationY = state == .expanded ? -translation.y : translation.y
        return translationY / (self.view.frame.height - commentViewHeight - self.headerView.frame.height) + progressWhenInterrupted
    }
    
    private func nextState() -> State {
        switch self.state {
        case .collapsed:
            return .expanded
        case .expanded:
            return .collapsed
        }
    }

    
    @objc private func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: commentView)
        
        switch recognizer.state {
        case .began:
            self.startInteractiveTransition(state: self.nextState(), duration: animatorDuration)
        case .changed:
            self.updateInteractiveTransition(fractionComplete: self.fractionComplete(state: self.nextState(), translation: translation))
        case .ended:
            self.continueInteractiveTransition(fractionComplete: self.fractionComplete(state: self.nextState(), translation: translation))
        default:
            break
        }
    }
    
    @IBAction func didTapCloseButton(_ sender: UIButton) {
        if self.state == .expanded {
            self.animateOrReverseRunningTransition(state: self.nextState(), duration: animatorDuration)
        }
    }
    // MARK: Animation
    // Frame Animation
    private func addFrameAnimator(state: State, duration: TimeInterval) {
        // Frame Animation
        let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
            switch state {
            case .expanded:
                self.commentView.frame = self.expandedFrame()
            case .collapsed:
                self.commentView.frame = self.collapsedFrame()
            }
        }
        frameAnimator.addCompletion({ (position) in
            switch position {
            case .start:
                // Fix blur animator bug don't know why
                switch self.state {
                case .expanded:
                    self.blurEffectView.effect = UIBlurEffect(style: .dark)
                case .collapsed:
                    self.blurEffectView.effect = nil
                }
            case .end:
                self.state = self.nextState()
            default:
                break
            }
            self.runningAnimators.removeAll()
        })
        runningAnimators.append(frameAnimator)
    }
    
    // Blur Animation
    private func addBlurAnimator(state: State, duration: TimeInterval) {
        var timing: UITimingCurveProvider
        switch state {
        case .expanded:
            timing = UICubicTimingParameters(controlPoint1: CGPoint(x: 0.75, y: 0.1), controlPoint2: CGPoint(x: 0.9, y: 0.25))
        case .collapsed:
            timing = UICubicTimingParameters(controlPoint1: CGPoint(x: 0.1, y: 0.75), controlPoint2: CGPoint(x: 0.25, y: 0.9))
        }
        let blurAnimator = UIViewPropertyAnimator(duration: duration, timingParameters: timing)
        if #available(iOS 11, *) {
            blurAnimator.scrubsLinearly = false
        }
        blurAnimator.addAnimations {
            switch state {
            case .expanded:
                self.blurEffectView.effect = UIBlurEffect(style: .dark)
            case .collapsed:
                self.blurEffectView.effect = nil
            }
        }
        runningAnimators.append(blurAnimator)
    }
    
    // Label Scale Animation
    private func addLabelScaleAnimator(state: State, duration: TimeInterval) {
        let scaleAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
            switch state {
            case .expanded:
                self.commentTitleLabel.transform = CGAffineTransform.identity.scaledBy(x: 1.8, y: 1.8)
            case .collapsed:
                self.commentTitleLabel.transform = CGAffineTransform.identity
            }
        }
        runningAnimators.append(scaleAnimator)
    }
    
    // CornerRadius Animation
    private func addCornerRadiusAnimator(state: State, duration: TimeInterval) {
        commentView.clipsToBounds = true
        // Corner mask
        if #available(iOS 11, *) {
            commentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
            switch state {
            case .expanded:
                self.commentView.layer.cornerRadius = 12
            case .collapsed:
                self.commentView.layer.cornerRadius = 0
            }
        }
        runningAnimators.append(cornerRadiusAnimator)
    }
    
    // KeyFrame Animation
    private func addKeyFrameAnimator(state: State, duration: TimeInterval) {
        let keyFrameAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
            UIView.animateKeyframes(withDuration: 0, delay: 0, options: [], animations: {
                switch state {
                case .expanded:
                    UIView.addKeyframe(withRelativeStartTime: duration / 2, relativeDuration: duration / 2, animations: {
                        self.blurEffectView.effect = UIBlurEffect(style: .dark)
                    })
                case .collapsed:
                    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: duration / 2, animations: {
                        self.blurEffectView.effect = nil
                    })
                }
            }, completion: nil)
        }
        runningAnimators.append(keyFrameAnimator)
    }
    
    // Perform all animations with animators if not already running
    func animateTransitionIfNeeded(state: State, duration: TimeInterval) {
        if runningAnimators.isEmpty {
            self.addFrameAnimator(state: state, duration: duration)
            self.addBlurAnimator(state: state, duration: duration)
            self.addLabelScaleAnimator(state: state, duration: duration)
            self.addCornerRadiusAnimator(state: state, duration: duration)
            self.addKeyFrameAnimator(state: state, duration: duration)
        }
    }
    
    // Starts transition if necessary or reverse it on tap
    func animateOrReverseRunningTransition(state: State, duration: TimeInterval) {
        if runningAnimators.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
            runningAnimators.forEach({ $0.startAnimation() })
        } else {
            runningAnimators.forEach({ $0.isReversed = !$0.isReversed })
        }
    }
    
    // Starts transition if necessary and pauses on pan .began
    func startInteractiveTransition(state: State, duration: TimeInterval) {
        self.animateTransitionIfNeeded(state: state, duration: duration)
        runningAnimators.forEach({ $0.pauseAnimation() })
        progressWhenInterrupted = runningAnimators.first?.fractionComplete ?? 0
    }
    
    // Scrubs transition on pan .changed
    func updateInteractiveTransition(fractionComplete: CGFloat) {
        runningAnimators.forEach({ $0.fractionComplete = fractionComplete })
    }
    
    // Continues or reverse transition on pan .ended
    func continueInteractiveTransition(fractionComplete: CGFloat) {
        let cancel: Bool = fractionComplete < 0.2
        
        if cancel {
            runningAnimators.forEach({
                $0.isReversed = !$0.isReversed
                $0.continueAnimation(withTimingParameters: nil, durationFactor: 0)
            })
            return
        }
        
        let timing = UICubicTimingParameters(animationCurve: .easeOut)
        runningAnimators.forEach({ $0.continueAnimation(withTimingParameters: timing, durationFactor: 0) })
    }
}



// CollectionViewのセル設定
class AcountCollectionViewCell: UICollectionViewCell {
    
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 125, height: 125)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(cellImageView)
    }
    
    func setUpContents(image: UIImage ,size: Int) {
        cellImageView.image = image
        cellImageView.frame = CGRect(x: 0, y: 0, width: size, height: size)
    }
}


//メール
extension AcountViewController:MFMailComposeViewControllerDelegate{
    func emailbutton(){
        let mailComposeViewController = configureMailComposeViewController()
        
        if MFMailComposeViewController.canSendMail(){
            
            self.present(mailComposeViewController, animated: true, completion: nil)
        }else{
            self.showSendMailErrorAlert()
        }
    }
    
    func configureMailComposeViewController() -> MFMailComposeViewController{
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["tsudoi0410@gmail.com"])
        
        mailComposerVC.setSubject("お問い合わせ")
        mailComposerVC.setMessageBody("１．①〜④よりお問い合わせ内容をお選びください。\n①アプリの不具合\n②問題のアカウントを通報する\n③追加してほしい機能\n④その他\n\n2.返信用のメールアドレスを記載してください\n\n3.②をお選びいただいた方は問題のアカウント名と問題行動を記載してください\nお客様入力内容：", isHTML: false)
        
        return mailComposerVC
        
    }
    
    func showSendMailErrorAlert(){
        _ = UIAlertView(title: "送信できませんでした", message: "your device must have an active mail account", delegate: self, cancelButtonTitle: "Ok")
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
