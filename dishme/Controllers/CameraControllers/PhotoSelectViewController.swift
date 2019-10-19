
//
//  PhotoSelectViewController.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/09/20.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import UIKit
import SnapLikeCollectionView
import Accounts
import FMPhotoPicker


class PhotoSelectViewController: UIViewController{
    
    //サインイン(企業orユーザ)
    var acountResister = "企業"
    var cameratarget = ""

    @IBOutlet weak var collectionView2: UICollectionView!
    
    
    var firstindex:IndexPath? = nil
    
    var shareImage:UIImage? = nil
    
    var originalimages:[UIImage] = [UIImage(named: "meat1")!,
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
                                    UIImage(named: "meat11")!,]
    
    var dishname:[String] = ["イベリコ豚","牛肉の切り身","牛肉の切り身","牛肉の切り身","牛肉の切り身","牛肉の切り身","牛肉の切り身","牛肉の切り身","牛肉の切り身","牛肉の切り身","牛肉の切り身","牛肉の切り身","牛肉の切り身","牛肉の切り身","牛肉の切り身","牛肉の切り身"]
    
    var comment = "めちゃめちゃ美味しかったです。リブステーキが特に美味しくてほっぺた落ちちゃいました。"
    
    var value:[Int] = [4000,1234,5000,3000,5120,3000,12000,2000,4000,9888,1000,3000,2000,1000]
    
    var alerttitle = ""
    
    //========================================検索に必要なもの(追加)======================================
    var searchController = UISearchController()//検索バー
    var tableView: UITableView!//検索テーブル

    //検索候補
    let suggestions:[String] = ["和食レストランとんでん","パティスリーラパージュ","トンカツ坊","スーリール","道頓堀習志野台店","ガスト習志野台店","トントン拍子","ジョナサン習志野台","サンマルクパフェ習志野台"]
    
    var searchResults:[String] = []//検索結果
    var searchstore = ""
    var category = ["おすすめ","メニュー","雰囲気"]
    //========================================検索に必要なもの===========================================
    
    //右上のボタン
    var selectBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //レイアウト
        tabbarcontroller()
        
        //collectionviewの基本設定
        collection2setting()
        
        //navigationの設定
        setupNavigation()
        
        //検索バー(追加)
        if acountResister == "ユーザ"{
            setupSearchcontroller()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        topcell()
        kutikomimoji()
        commentButton()
    }
}

//検索テーブルのsearchcontrolelr(追加)
extension PhotoSelectViewController:UISearchResultsUpdating,UISearchBarDelegate{
    
    //検索テーブル
    func setupSearchcontroller(){
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = "店名を入力"
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.keyboardAppearance = .default
        searchController.searchBar.delegate = self
        searchController.searchBar.showsCancelButton = false
        searchController.searchBar.setValue("", forKey: "_cancelButtonText")
        navigationItem.titleView = searchController.searchBar
    }
    
    // 検索ボタンが押された時に呼ばれる
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        searchBar.showsCancelButton = true
        self.searchResults = suggestions.filter{
            // 大文字と小文字を区別せずに検索
            $0.lowercased().contains(searchBar.text!.lowercased())
        }
        self.tableView.reloadData()
    }
    
    // キャンセルボタンが押された時に呼ばれる
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        self.view.endEditing(true)
        searchBar.text = ""
        self.tableView.reloadData()
    }
    
    // 文字が入力される度に呼ばれる
    func updateSearchResults(for searchController: UISearchController) {
        self.searchResults = suggestions.filter{
            // 大文字と小文字を区別せずに検索
            $0.lowercased().contains(searchController.searchBar.text!.lowercased())
        }
        self.tableView.reloadData()
    }
    // 編集が開始されたら、キャンセルボタンを有効にする
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        tablesettings()
        selectBtn = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(cancel))
        self.navigationItem.rightBarButtonItems = [selectBtn]
        self.tableView.reloadData()
        return true
        
    }
    
    @objc func cancel(){
        //編集ボタンに戻す
        setupNavigation()
        //テキストを閉じる
        searchController.searchBar.resignFirstResponder()
        searchstore = searchController.searchBar.text!
        tableView.removeFromSuperview()
    }
    
}

//検索テーブル(追加)
extension PhotoSelectViewController: UITableViewDelegate,UITableViewDataSource {
    
    //topcell
    func topcell(){
        let noindex = IndexPath(item: 0, section: 0)
        collectionView2.scrollToItem(at: firstindex ?? noindex, at: .right, animated: false)
    }
    //tableの基本設定
    func tablesettings(){
        let width = view.frame.size.width
        let height = view.frame.size.height
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.searchBar.text != "" {
            return searchResults.count
        } else {
            return suggestions.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        cell.textLabel!.font = UIFont.init(name: "HelveticaNeue-Bold", size: 16)
        
        //検索
        if searchController.searchBar.text != "" {
            cell.textLabel!.text = "\(searchResults[indexPath.row])"
        }
        //検索結果
        else{
            cell.textLabel!.text = "\(suggestions[indexPath.row])"
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        //検索されたものかおすすめに出てきているものをタッチしたのかの判別
        searchController.searchBar.text = suggestions[indexPath.row]
        tableView.removeFromSuperview()
        searchstore = searchController.searchBar.text!
        
        searchController.searchBar.resignFirstResponder
    }
    
}

extension PhotoSelectViewController{
    func kutikomimoji(){
        let label = UILabel()
        label.frame =  CGRect(x: 23, y: 500, width: 0, height: 0)
        label.text = "口コミ"
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 16)
        label.textAlignment = NSTextAlignment.right
        label.sizeToFit()
        view.addSubview(label)
    }
    
    func commentButton(){
        
        // UIButtonのインスタンスを作成する
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(commentaction), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 16,
                              y: 370,
                              width: 355,
                              height: 365);
        button.setTitle(comment, for: UIControl.State.normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.sizeToFit()
        
        view.addSubview(button)
        
    }
    @objc func commentaction(){
        performSegue(withIdentifier: "toPhotoComment", sender: nil)
    }
}

//collection周り
extension PhotoSelectViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collection2setting(){
        // レイアウト設定
        let layout = CustomFlowLayout()
        layout.itemSize = CGSize(width: 375, height: 650)
        collectionView2.collectionViewLayout = layout
        
        collectionView2.delegate = self
        collectionView2.dataSource = self
    }
    
    //セクションの数
    internal func numberOfSections(in collectionView: UICollectionView) -> Int {
        if cameratarget == "新規企業" || cameratarget == "新規ユーザ"{
            return 1
        }
        else{
            return 3
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //ユーザで追加した場合
        if cameratarget == "新規企業" || cameratarget == "新規ユーザ"{
            print("aaaaa",originalimages.count)
            return originalimages.count
        }
        else{
            switch(section){
            case 0:
                return 5
                
            case 1:
                return 8
                
            case 2:
                return 10
                
            default:
                print("error")
                return 0
            }
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView2.dequeueReusableCell(withReuseIdentifier: "Cell2",for: indexPath as IndexPath) as! PhotosBigViewCell
            
            if acountResister == "企業"{
                
                //写真
                cell.imageView.image = originalimages[indexPath.row]
                cell.valuemoji.text = "価格"
                
                //カテゴリの表示ボタン
                if cameratarget == "新規企業"{
                    cell.categoryBtn.setTitle("カテゴリを入力", for: UIControl.State.normal)
                }else{
                    cell.categoryBtn.setTitle("おすすめ", for: UIControl.State.normal)
                }
                
                //[商品名]の表示ボタン
                if cameratarget == "新規企業"{
                    cell.productBtn.setTitle("品名を入力", for: UIControl.State.normal)
                }else{
                    cell.productBtn.setTitle("\(dishname[indexPath.row])", for: UIControl.State.normal)
                }
                
                
                //[4000円]の表示ボタン
                if cameratarget == "新規企業"{
                   cell.moneyBtn.setTitle("価格を入力", for: UIControl.State.normal)
                }else{
                    cell.moneyBtn.setTitle("\(value[indexPath.row])円", for: UIControl.State.normal)
                }
                
               //ボタンの背景色
               cell.moneyBtn.backgroundColor = UIColor.init(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
               cell.productBtn.backgroundColor = UIColor.init(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
                cell.categoryBtn.backgroundColor = UIColor.init(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
                //アカウント選択
                cell.categoryBtn.addTarget(self, action: #selector(tocategory(sender:)), for: .touchUpInside)
                cell.productBtn.addTarget(self, action: #selector(tomoney(sender:)), for: .touchUpInside)
                cell.moneyBtn.addTarget(self, action: #selector(todish(sender:)), for: .touchUpInside)
            }
            else{
                
                //ユーザの場合
                cell.valuemoji.text = ""
                cell.dishmoji.text = ""
                cell.categorymoji.text = ""
                cell.productBtn.removeFromSuperview()
                cell.moneyBtn.removeFromSuperview()
                cell.categoryBtn.removeFromSuperview()
                
                // Section毎にCellのプロパティを変える.
                switch(indexPath.section){
                case 0:
                    cell.imageView.image = originalimages[indexPath.row]

                case 1:
                    cell.imageView.image = originalimages[indexPath.row]

                case 2:
                    cell.imageView.image = originalimages[indexPath.row]

                default:
                    cell.imageView.image = originalimages[indexPath.row]
                }
            }
            return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            switch acountResister {
            case "企業":
                break;
            default:
                break;
            }
    }
    
}

extension PhotoSelectViewController{
    //ボタンから取得する
    @objc func tomoney(sender: UIButton){
        
        if let indexPath = collectionView2.indexPath(for: sender.superview!.superview as! UICollectionViewCell) {
            alerttitle = "品名を決める"
            performSegue(withIdentifier: "toCameraLast", sender: nil)

        }
    }
    //ボタンから取得する
    @objc func todish(sender: UIButton){
        
        if let indexPath = collectionView2.indexPath(for: sender.superview!.superview as! UICollectionViewCell) {
            alerttitle = "価格を決める"
            performSegue(withIdentifier: "toCameraLast", sender: nil)
        }
    }
    
    //ボタンから取得する
    @objc func tocategory(sender: UIButton){
        
        if let indexPath = collectionView2.indexPath(for: sender.superview!.superview as! UICollectionViewCell) {
            alerttitle = "カテゴリを決める"
            performSegue(withIdentifier: "toCameraLast", sender: nil)
        }
    }
    
    //画面に渡す値
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCameraLast" {
            let nextView = segue.destination as! CameraLastViewController
            nextView.alerttitle = alerttitle
        }
    }
}


class CustomFlowLayout: UICollectionViewFlowLayout {
    
    private let largeFlickVelocityThreshold: CGFloat = 2.0
    private let minimumFlickVelocityThreshold: CGFloat = 0.2
    private let pageWidth: CGFloat = 320.0
    
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        itemSize = CGSize(width: 375, height: 600)
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        sectionInset = UIEdgeInsets(top: 0.0, left: 0, bottom: 0.0, right: 0)
        scrollDirection = .horizontal
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else {
            return proposedContentOffset
        }
        
        let pageWidth = itemSize.width + minimumLineSpacing
        let currentPage = collectionView.contentOffset.x / pageWidth
        
        if abs(velocity.x) > largeFlickVelocityThreshold {
            // velocityが大きいときは2つ動かす
            let nextPage = (velocity.x > 0.0) ? ceil(currentPage) + 1 : floor(currentPage) - 1
            return CGPoint(x: nextPage * pageWidth, y: proposedContentOffset.y)
        } else if abs(velocity.x) > minimumFlickVelocityThreshold {
            // 1つ動かす
            let nextPage = (velocity.x > 0.0) ? ceil(currentPage) : floor(currentPage)
            return CGPoint(x: nextPage * pageWidth, y: proposedContentOffset.y)
        } else {
            // velocityが小さすぎるときは近いほうへ
            return CGPoint(x: round(currentPage) * pageWidth, y: proposedContentOffset.y)
        }
    }
    
}

//navigation周り
extension PhotoSelectViewController{
    
    func setupNavigation(){
        let edititem = UIBarButtonItem(image: UIImage(named: "edititem")?.withRenderingMode(.alwaysOriginal),
                                       style: .plain,
                                       target: self,
                                       action: #selector(filteraciton));
        self.navigationItem.rightBarButtonItems = [edititem]
    }
    @objc func filteraciton(){
        let config = FMPhotoPickerConfig()
        let vc = FMImageEditorViewController(config: config, sourceImage: originalimages[0])
        vc.delegate = self
        
        self.present(vc, animated: true)
    }
}

//レイアウト
extension PhotoSelectViewController{
    func tabbarcontroller(){
        backview()
        deleteBtn()
        
        if cameratarget == "新規企業" || cameratarget == "新規ユーザ"{
          alertButton()
        }
        else{
          savephotoBtn()
        }
        
    }
    func backview(){
        let backview = UIView()
        backview.frame = CGRect(x: 0, y: 733, width: 375, height: 79)
        backview.backgroundColor = UIColor.init(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        view.addSubview(backview)
    }
    
    func deleteBtn(){
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(deletephoto), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 333,
                              y: 754,
                              width: 20,
                              height: 26);
        button.setImage(UIImage(named: "delete"), for: UIControl.State())
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.view.addSubview(button)
    }
    
    func savephotoBtn(){
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 28,
                              y: 754,
                              width: 20,
                              height: 26);
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
            button.setImage(UIImage(named: "savephoto"), for: UIControl.State())
            button.addTarget(self, action: #selector(savephoto), for: UIControl.Event.touchUpInside)
       
        
        self.view.addSubview(button)
    }
    
    func alertButton(){
        let button = UIButton()
        button.frame = CGRect(x: 26,
                              y: 754,
                              width: 50,
                              height: 26);
        button.setTitle("保存", for:UIControl.State.normal)
        button.titleLabel?.sizeToFit()
        button.setTitleColor(UIColor.init(red: 55/255, green: 151/255, blue: 240/255, alpha: 1), for: .normal)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 15)
        button.titleLabel?.font = UIFont.init(name: "HelveticaNeue-Bold", size: 17)!
        button.titleLabel?.textAlignment = .left
        button.addTarget(self, action: #selector(dicidesegue), for: UIControl.Event.touchUpInside)
        
        self.view.addSubview(button)
    }
    
        @objc func dicidesegue(){
            
            //店名が入力されていない
            if searchstore == ""{
                let alert = Alert()
                alert.infoAlert(Title: "保存しますか？", subTitle: "お店が指定されていないと掲載はできません", yes: "はい", no: "いいえ", yesTitle: "保存しました", yessubTitle: "")
            }else{
               _ = SweetAlert().showAlert("写真を保存しました", subTitle: "店名:\(searchstore)", style: AlertStyle.success)
            }
        }
    
    //写真を編集
    @objc func editphotoAction(){
        let config = FMPhotoPickerConfig()
        let vc = FMImageEditorViewController(config: config, sourceImage: originalimages[0])
        vc.delegate = self
        
        self.present(vc, animated: true)
    }
    
    //端末に保存する
    @objc func savephoto(){
        
        let activityItems = [shareImage as Any] as [Any]
        
        // 初期化処理
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        // 使用しないアクティビティタイプ
        let excludedActivityTypes = [
            UIActivity.ActivityType.postToFacebook,
            UIActivity.ActivityType.postToTwitter,
            UIActivity.ActivityType.message,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.print
        ]
        
        activityVC.excludedActivityTypes = excludedActivityTypes
        
        // UIActivityViewControllerを表示
        self.present(activityVC, animated: true, completion: nil)
    }
}


//写真削除するアラート
extension PhotoSelectViewController{
    @objc func deletephoto(){
        //UIAlertControllerを用意する
        let actionAlert = UIAlertController(title: "この写真は完全にdishmeのアプリ内から削除されます。", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        
        
        //QRcodeをカメラから読み取る
        let deleteAction = UIAlertAction(title: "写真を削除", style: UIAlertAction.Style.destructive, handler: {
            (action: UIAlertAction!) in
            //ここに写真を削除する文を書く
        })
        actionAlert.addAction(deleteAction)
        
        //UIAlertControllerにキャンセルのアクションを追加する
        let cancelAction = UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel, handler: {
            (action: UIAlertAction!) in
        })
        actionAlert.addAction(cancelAction)
        
        //アクションを表示する
        let screenSize = UIScreen.main.bounds
        actionAlert.popoverPresentationController?.sourceView = self.view
        actionAlert.popoverPresentationController?.sourceRect = CGRect(x: screenSize.size.width/2, y: screenSize.size.height, width: 0, height: 0)
        self.present(actionAlert, animated: true, completion: nil)
    }
}

extension PhotoSelectViewController:FMImageEditorViewControllerDelegate{
    func fmImageEditorViewController(_ editor: FMImageEditorViewController, didFinishEdittingPhotoWith photo: UIImage) {
        self.dismiss(animated: true, completion: nil)
        originalimages[0] = photo
        collectionView2.reloadData()
        print("編集おわた")
        self.dismiss(animated: true, completion: nil)
    }
    func fmPhotoPickerController(_ picker: FMPhotoPickerViewController, didFinishPickingPhotoWith photos: [UIImage]) {
        self.dismiss(animated: true, completion: nil)
    }
}
