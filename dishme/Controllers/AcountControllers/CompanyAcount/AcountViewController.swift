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
    let commentViewHeight: CGFloat = 64.0
    let animatorDuration: TimeInterval = 1
    
    // UI
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var blurEffectView: UIVisualEffectView!
    //    @IBOutlet weak var closeButton: UIButton!
    //    @IBOutlet weak var backButton: UIButton!
    
    
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
    
    
    var tableJudges = TableSettings()
    
    
    //tabbar
    let tabBar : UITabBar = UITabBar(frame: CGRect(x: 0, y: 360, width: 375, height: 200))
    
    //スクロールview
    let scrollView = UIScrollView()
    let menuview = UIView()
    let acountview = UIView()
    
    
    //メニューのページ
    var pageMenu: PageMenuViewinit!
    
    //メニューのcollectionview
    var collectionView: UICollectionView!
    
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
                            UIImage(named: "meat11")!,
                            UIImage(named: "meat12")!,
                            UIImage(named: "meat13")!,
                            UIImage(named: "meat14")!,
                            UIImage(named: "meat15")!,
                            UIImage(named: "meat1")!,
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
                            UIImage(named: "meat15")!,]
    
    var setting:[String] = ["ログアウト","アカウント切り替え","お知らせ","振込口座の変更","写真を非公開にする","問題を管理者に報告"]
    
    //レストラン情報
    var tableView1: UITableView  =   UITableView()
    var opentitle = "営業中"
    var opentime = "12:00〜13:00"
    var position = "Certificate of Excellence"
    var acountname = "Ribe Face"
    var acountimage = UIImage(named: "acount1")
    var congestion = "混雑時間"
    var maxnumber = "10"
    var phonenumber = 08069539797
    var congestiontime = "AM 13:00〜AM 14:00"
    var yummynumber = 237
    var yuckynumber = 37

    var comment = "春の旬のふきのとうや新鮮なリブステーキを兼ね揃えてお\nります。今ご来場していただいた方には次回からお使いい\nただけるクーポンも配布中です。"
    var avaragemoney = "¥6,280〜¥10,000"
    var holiday = "毎週水曜日"
    var temporaryClosed = "2019/8/24"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //スクロールviewの基本設定
        scrollbackview()
        
        //インスタンス化
        backgroundcontroller()
        
        //メニューの設定
        pagesettings()
        
        setupNavifation()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //=========================================下から=====================================================
        view.bringSubviewToFront(blurEffectView)
        self.initSubViews()
        self.addGestures()
        table2settings()
        //=========================================下から=====================================================
    }
    
    
    // Enable the navbar scrolling
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
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
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
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
    func setupNavifation(){
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
        scrollView.frame = self.view.frame
        scrollView.contentSize = CGSize(width:375, height:1150)
        self.view.addSubview(scrollView)
        
        acountview.frame = CGRect(x: 0,
                                  y: -80,
                                  width: scrollView.frame.size.width,
                                  height: scrollView.frame.size.height)
        self.scrollView.addSubview(acountview)
        
        menuview.frame = CGRect(x: 0,
                                y:600,
                                width: scrollView.frame.size.width,
                                height: scrollView.frame.size.height)
        self.scrollView.addSubview(menuview)
        
        
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
        Yummylabel()
        Yummynumber()
        
        //yuckyボタン
        badButton()
        Yuckylabel()
        Yuckynumber()
        
    }
    func acountimageview(){
        let image = UIImageView()
        image.image = acountimage
        image.frame = CGRect(x: 17, y: 98, width: 85, height: 85)
        image.circle()
        self.acountview.addSubview(image)
        
    }
    func comentview(){
        let label = UILabel()
        label.frame =  CGRect(x: 17, y: 232, width: 0, height: 0)
        label.text = comment
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "HelveticaNeue-Thin", size: 13)
        label.textAlignment = NSTextAlignment.left
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 3
        label.sizeToFit()
        acountview.addSubview(label)
    }
    func acontlabel(){
        let label = UILabel()
        label.frame =  CGRect(x: 23, y: 194, width: 0, height: 0)
        label.text = acountname
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 16)
        label.textAlignment = NSTextAlignment.right
        label.sizeToFit()
        acountview.addSubview(label)
    }
    
    func goodButton(){
        // UIButtonのインスタンスを作成する
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(good), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 212,
                              y: 124,
                              width: 22,
                              height: 20);
        button.setImage(UIImage(named: "good"), for: UIControl.State())
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.acountview.addSubview(button)
        
    }
    func messageButton(){
        // UIButtonのインスタンスを作成する
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(editsegue), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 164,
                              y: 188,
                              width: 195,
                              height: 29);
        button.setImage(UIImage(named: "editbar"), for: UIControl.State())
        acountview.addSubview(button)
    }
    //yummyボタン周り
    func Yummylabel(){
        let label = UILabel()
        label.frame =  CGRect(x: 169, y: 151, width: 0, height: 0)
        label.text = "Yummy!"
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 10)
        label.textAlignment = NSTextAlignment.center
        label.sizeToFit()
        acountview.addSubview(label)
    }
    func Yummynumber(){
        let label = UILabel()
        label.frame =  CGRect(x: 176, y: 130, width: 0, height: 0)
        label.text = "\(yummynumber)"
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 16)
        label.textAlignment = NSTextAlignment.center
        label.sizeToFit()
        acountview.addSubview(label)
    }
    
    @objc func good(){
        
    }
    @objc func editsegue(){
        performSegue(withIdentifier: "toEdit", sender: nil)
    }
    //yuckyボタン周り
    func badButton(){
        // UIButtonのインスタンスを作成する
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(good), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 327,
                              y: 131,
                              width: 22,
                              height: 20);
        button.setImage(UIImage(named: "bad"), for: UIControl.State())
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        acountview.addSubview(button)
    }
    func Yuckylabel(){
        let label = UILabel()
        label.frame =  CGRect(x: 285, y: 151, width: 0, height: 0)
        label.text = "Yucky"
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 10)
        label.textAlignment = NSTextAlignment.center
        label.sizeToFit()
        acountview.addSubview(label)
        
    }
    func Yuckynumber(){
        let label = UILabel()
        label.frame =  CGRect(x: 293, y: 130, width: 0, height: 0)
        label.text = "\(yuckynumber)"
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 16)
        label.textAlignment = NSTextAlignment.center
        label.sizeToFit()
        acountview.addSubview(label)
    }
    @objc func bad(){
        
    }
}

//tableviewの設定
extension AcountViewController{
    
    //レストラン情報のテーブル
    func restaurantInfo(){
        //下から出てくるtableview
        tableView1.frame = CGRect(
            x: 0.0,
            y: 290,
            width: self.view.frame.width,
            height: 440
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
        acountview.addSubview(tableView1)
    }
    
    //各種設定のテーブル
    func table2settings(){
        tableView2.delegate = self
        tableView2.dataSource = self
        tableView2.frame = CGRect(x: 0, y: 70, width: 375, height: 500)
        tableView2.register(UITableViewCell.self, forCellReuseIdentifier: "Info")
        tableView2.contentMode = .scaleAspectFit
        tableView2.tableFooterView = UIView(frame: .zero)
        commentView.addSubview(tableView2)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView {
        case tableView1: //レストラン情報のテーブル
            return 8
        default:        //各種設定のテーブル
            return setting.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //レストラン情報のテーブル
        if tableView == tableView1{
        let cell:UITableViewCell = UITableViewCell(style: .subtitle, reuseIdentifier: "Home")
            
        tableJudges.cellForRowAt(cell: cell, indexPath: indexPath, opentitle: opentitle, opentime: opentime, congestion: congestion, congestiontime: congestiontime, position: position, phonenumber: phonenumber, maxnumber: maxnumber, holiday: holiday, temporaryClosed: temporaryClosed)
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
            tableJudges.didSelectRowAt(indexPath: indexPath)
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
            return 55
        }
    }
    //[レストラン情報]と表示するヘッダー
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        
        
        switch tableView {
        case tableView1:  //レストラン情報のテーブル
            let header = tableJudges.hederInSection()
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
        return dishes.count
    }
    
    
    // セルの設定
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",for: indexPath as IndexPath) as! AcountCollectionViewCell
        let cellImage = dishes[indexPath.row]
        cell.setUpContents(image: cellImage)
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
    
    
    func collectionsettings(viewcontroller: UIViewController){
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 750), collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = UIColor.white
        collectionView.register(AcountCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // レイアウト設定
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        collectionView.collectionViewLayout = layout
        
        viewcontroller.view.addSubview(collectionView)
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
        collectionsettings(viewcontroller: viewController1)
        collectionsettings(viewcontroller: viewController2)
        collectionsettings(viewcontroller: viewController3)
        
        
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




//===================================ここから下から出てくる各種設定=================================================
extension AcountViewController :UITableViewDelegate,UITableViewDataSource{
    
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
            height: self.view.frame.height - commentViewHeight - self.headerView.frame.height
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
    
    // MARK: Gesture
    //    @objc private func handleTapGesture(_ recognizer: UITapGestureRecognizer) {
    //        self.animateOrReverseRunningTransition(state: self.nextState(), duration: animatorDuration)
    //    }
    
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
    
    func setUpContents(image: UIImage) {
        cellImageView.image = image
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
