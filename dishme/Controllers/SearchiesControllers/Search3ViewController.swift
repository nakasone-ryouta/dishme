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
import SnapKit

class Search3ViewController: UIViewController,ScrollingNavigationControllerDelegate{
    
    //サインイン(企業orユーザ)
    var acountResister = "企業a"
    
    //[おすすめ][メニュー][雰囲気]を判断する
    var controllerjudge = "おすすめ"
    
    //次の画面で選択されたcellを最初に渡すための引数
    var firstindex: IndexPath? = nil
    
    var alert = SweetAlert()

    @IBOutlet weak var avarageMoneyLabel: UILabel!
    
    //スクロールview
    let scrollView = UIScrollView()
    let menuview = UIView()
    let acountview = UIView()
    @IBOutlet weak var blackView: UIView!
    
    //メニューのページ
    var pageMenu: PageMenuViewinit!
    
    //メニューのcollectionview
    var collectionView1: UICollectionView!
    var collectionView2: UICollectionView!
    var collectionView3: UICollectionView!

    
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
    
    //オススメの写真
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
    
    //softdrinkじゃなくてメニューの写真
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
    //雰囲気
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
    
    
    //レストラン情報
    var tableView: UITableView  =   UITableView()
    var opentitle = "営業中"
    var opentime = "12:00〜13:00"
    var position = "Certificate of Excellence"
    var acountname = "Ribe Face"
    var acountimage = "acount1"
    var congestion = "混雑時間"
    var congestiontime = "AM 13:00〜AM 14:00"
    var yummynumber = 2374
    var yuckynumber = 237
    var comment = "春の旬のふきのとうや新鮮なリブステーキを兼ね揃えております。今ご来場していただいた方には次回からお使いいただけるクーポンも配布中です。"
    var avaragemoney = "¥6,280〜¥10,000"
    
    //電話番号
    var callnumber = "09038572079"

    override func viewDidLoad() {
        super.viewDidLoad()
        //スクロールviewの基本設定
        scrollbackview()

        //インスタンス化
        backgroundcontroller()
        
        //メニューの設定
        pagesettings()
        
        self.view.bringSubviewToFront(blackView)
    }
    
    // Enable the navbar scrolling
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollUpsettings()
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        scrollStopsettings()
    }
    
    @IBAction func ReservaionButton(_ sender: Any) {
        switch acountResister {
        case "企業":
            //電話をかける
            let url = NSURL(string: "tel://\(callnumber)")!
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url as URL)
            } else {
                UIApplication.shared.openURL(url as URL)
            }
        default:
            performSegue(withIdentifier: "toReservation", sender: nil)
        }
    }
}
//スクロールまわり
extension Search3ViewController{
    func scrollUpsettings(){
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            navigationController.followScrollView(scrollView, delay: 10.0, followers: [NavigationBarFollower(view: blackView, direction: .scrollDown)])
        }

    }
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

//スクロールviewの基本設定
extension Search3ViewController{
    func scrollbackview(){
        let maxwidth = view.frame.size.width
        let maxheight = view.frame.size.height
        scrollView.contentSize = CGSize(width:maxwidth, height:maxheight * 2)
        scrollView.frame = self.view.frame
        self.view.addSubview(scrollView)
        
        acountview.frame = CGRect(x: 0,
                                  y: -80,
                                  width: scrollView.frame.size.width,
                                  height: scrollView.frame.size.height)
        self.scrollView.addSubview(acountview)
        
        menuview.frame = CGRect(x: 0,
                                y: 420,
                                width: scrollView.frame.size.width,
                                height: scrollView.frame.size.height)
        self.scrollView.addSubview(menuview)
        

    }
}
extension Search3ViewController{
    @objc func good(){
        
    }
    @objc func bad(){
        
    }
}

//基本レイアウト周り
extension Search3ViewController{
    func backgroundcontroller(){
        restaurantInfo()
        acontlabel()
        acountimageview()
        comentview()
        
        //保存ボタン
        if acountResister == "企業"{
        }else{
          setupNavigation()
        }
        
        //yummyボタン
        goodButton()
        
        //yuckyボタン
        badButton()
        
        //平均使用額
        avarageMoneyLabel.text = avaragemoney
        avarageMoneyLabel.adjustsFontSizeToFitWidth = true
        
    }
    func setupNavigation(){
        let selectBtn = UIBarButtonItem(title: "保存", style: .done, target: self, action: #selector(savephoto))
        self.navigationItem.rightBarButtonItems = [selectBtn]
    }
    @objc func savephoto(){
        _ = SweetAlert().showAlert("保存しました", subTitle: "保存リストを見るには「予約」から見れます。", style: AlertStyle.success)
    }
    func acountimageview(){
        let image = UIImageView(image: UIImage(named: "acount1"))
        image.frame = CGRect(x: 17, y: 98, width: 85, height: 85)
        image.circle()
        self.acountview.addSubview(image)
        
    }
    func comentview(){
        let maxwidth = view.frame.size.width
        let maxheight = view.frame.size.height
        let label = UILabel()
        label.frame =  CGRect(x: 17, y: 232, width: maxwidth / 1.1, height: maxheight / 12.5)
        label.text = comment
        label.textColor = UIColor.darkGray
        label.font = UIFont.init(name: "HelveticaNeue-Thin", size: 13)
        label.textAlignment = NSTextAlignment.left
//        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 4
        label.sizeToFit()
        acountview.addSubview(label)
    }
    func acontlabel(){
        let label = UILabel()
        label.frame =  CGRect(x: 23, y: 194, width: 0, height: 0)
        label.text = acountname
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 18)
        label.textAlignment = NSTextAlignment.right
        label.sizeToFit()
        acountview.addSubview(label)
    }
    
    func goodButton(){
        // ナビゲーションバーの高さを取得
        let navBarHeight = self.navigationController?.navigationBar.frame.size.height
        let maxwidth = view.frame.size.width
        
        // UIButtonのインスタンスを作成する
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(good), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: maxwidth / 1.74,
                              y: navBarHeight! + 100,
                              width: 22,
                              height: 20);
        button.setImage(UIImage(named: "good"), for: UIControl.State())
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.acountview.addSubview(button)
        
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
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 18)
        label.textAlignment = NSTextAlignment.center
        acountview.addSubview(label)
        
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
        label.text = "Yummy!"
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "HelveticaNeue-Light", size: 13)
        label.textAlignment = NSTextAlignment.center
        acountview.addSubview(label)
    }
//yuckyボタン周り
    func badButton(){
        
        // ナビゲーションバーの高さを取得
        let navBarHeight = self.navigationController?.navigationBar.frame.size.height
        let maxwidth = view.frame.size.width
        
        // UIButtonのインスタンスを作成する
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(good), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: maxwidth / 1.14,
                              y: navBarHeight! + 100,
                              width: 22,
                              height: 20);
        button.setImage(UIImage(named: "bad"), for: UIControl.State())
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        acountview.addSubview(button)
        
        
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
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 18)
        label.textAlignment = NSTextAlignment.center
        label.sizeToFit()
        acountview.addSubview(label)
        
        Yuckylabel(button: button)
    }
    
    func Yuckylabel(button :UIButton){
        
        // ナビゲーションバーの高さを取得
        let navBarHeight = self.navigationController?.navigationBar.frame.size.height
        
        let label = UILabel()
        label.frame =  CGRect(x: 0, y: navBarHeight! + 120, width: 50, height: 30)
        label.frame.origin.x = button.frame.origin.x - 50
        label.frame.origin.y = button.frame.origin.y + 28
        label.text = "Yucky"
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "HelveticaNeue-Light", size: 13)
        label.textAlignment = NSTextAlignment.center
        label.sizeToFit()
        acountview.addSubview(label)
        
    }
}

//tableview周り
extension Search3ViewController:UITableViewDataSource,UITableViewDelegate{
    
    //レストラン情報の基本設定
    func restaurantInfo(){
        //下から出てくるtableview
        tableView.frame = CGRect(
            x: 0.0,
            y: 312,
            width: self.view.frame.width,
            height: 183
        )
        
        tableView.delegate      =   self
        tableView.dataSource    =   self
//        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.init(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Home")
        tableView.contentMode = .scaleAspectFit
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor(red: 208/255, green: 208/255, blue:208/255, alpha: 1).cgColor
        acountview.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: .subtitle, reuseIdentifier: "Home")
        
        tableView.estimatedRowHeight = 66
        tableView.rowHeight = UITableView.automaticDimension
        
        //営業中
        if indexPath.row == 0{
            cell.textLabel?.text = opentitle
            cell.textLabel?.textAlignment = NSTextAlignment.right
            cell.textLabel?.font = UIFont.init(name: "HelveticaNeue-Bold", size: 13)
            //営業時間
            cell.detailTextLabel?.text = opentime
            cell.detailTextLabel?.textAlignment = NSTextAlignment.left
        }
        //混雑時間
        if indexPath.row == 1{
            cell.textLabel?.text = congestion
            cell.textLabel?.textAlignment = NSTextAlignment.right
            cell.textLabel?.font = UIFont.init(name: "HelveticaNeue-Bold", size: 13)
            //時間
            cell.detailTextLabel?.text = congestiontime
            cell.detailTextLabel?.textAlignment = NSTextAlignment.left
        }
        //場所
        if indexPath.row == 2{
            cell.textLabel?.text = position
            cell.textLabel?.textAlignment = NSTextAlignment.right
            cell.textLabel?.font = UIFont.init(name: "HelveticaNeue-Thin", size: 13)
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        }
        
        //選択不可
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.row == 2{
            performSegue(withIdentifier: "toSearchMap", sender: nil)
        }
    }
    //Mark: ヘッダーの大きさを設定する
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        
        return 44
    }
    
    //Mark: ヘッダーに設定するViewを設定する
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        
        //ヘッダーにするビューを生成
        let view = UIView()
        view.frame = CGRect(x: 0, y: 313, width: self.view.frame.size.width, height: 49)
        view.backgroundColor = UIColor.white
        
        //ヘッダーに追加するラベルを生成
        let headerLabel = UILabel()
        headerLabel.frame =  CGRect(x: 13, y: 10, width: 0, height: 0)
        headerLabel.text = "レストラン情報"
        headerLabel.textColor = UIColor.black
        headerLabel.font = UIFont.init(name: "HelveticaNeue-Bold", size: 17)
        headerLabel.textAlignment = NSTextAlignment.right
        headerLabel.sizeToFit()
        view.addSubview(headerLabel)
        
        return view
    }
}

//メニューのレイアウト
extension Search3ViewController:PageMenuViewDelegateinit{
    func willMoveToPage(_ pageMenu: PageMenuViewinit, from viewController: UIViewController, index currentViewControllerIndex: Int) {
        print("---------")
        print(viewController.title!)
        controllerjudge = viewController.title!
    }
    
    func didMoveToPage(_ pageMenu: PageMenuViewinit, to viewController: UIViewController, index currentViewControllerIndex: Int) {
        print(viewController.title!)
        controllerjudge = viewController.title!
    }
    
    func pagesettings(){
        // Init View Contollers
      
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
        collectionsettings(viewcontroller: viewController1)
        collection2settings(viewcontroller: viewController2)
        collection3settings(viewcontroller: viewController3)

        
        // Init Page Menu with view controllers and UI option
        pageMenu = PageMenuViewinit(viewControllers: viewControllers, option: optionview())
        pageMenu.delegate = self
        menuview.addSubview(pageMenu)
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
        option.menuIndicatorColor = UIColor.init(red: 55/255, green: 151/255, blue: 240/255, alpha: 1)
        
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

//料理たちを表示するcollectionview
extension Search3ViewController: UICollectionViewDataSource ,UICollectionViewDelegate{
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",for: indexPath as IndexPath) as! Search3CollectionViewCell
        //セルのサイズを調節する
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
    
    // セル選択時の処理
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        firstindex = indexPath
        self.performSegue(withIdentifier: "toSearch4", sender: nil)
    }
    
    //画面に渡す値
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSearch4" {
            let nextView = segue.destination as! Search4ViewController
            nextView.firstindex = firstindex
            nextView.controllerjudge = controllerjudge
        }
    }
    
    //レイアウト周り
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout:UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let horizontalSpace:CGFloat = 1
        let cellSize:CGFloat = self.view.bounds.width/3 - horizontalSpace
        
        return CGSize(width: cellSize, height: cellSize)
    }

}

//料理たちを表示するcollectionview
extension Search3ViewController:  UICollectionViewDelegateFlowLayout {
    
    func collectionsettings(viewcontroller: UIViewController){
        collectionView1 = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 750), collectionViewLayout: UICollectionViewFlowLayout())
        collectionView1.backgroundColor = UIColor.white
        collectionView1.register(Search3CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
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
        collectionView2.register(Search3CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
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
        collectionView3.register(Search3CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
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
