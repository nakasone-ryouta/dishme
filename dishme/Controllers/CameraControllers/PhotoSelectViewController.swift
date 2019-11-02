
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
    var pageindex: Int = 0
    
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
    
    var acounts:[UIImage] = [UIImage(named: "meat1")!,
                                    UIImage(named: "meat2")!,
                                    UIImage(named: "meat3")!,
                                    UIImage(named: "meat4")!,
                                    UIImage(named: "meat5")!,
                                    UIImage(named: "meat6")!,
                                    UIImage(named: "meat7")!,
                                    UIImage(named: "meat8")!,
                                    UIImage(named: "meat9")!,
                                    UIImage(named: "meat10")!,]
    
    var dishname:[String] = ["イベリコ豚","牛肉の切り身","牛肉の切り身","牛肉の切り身","牛肉の切り身","牛肉の切り身","牛肉の切り身","牛肉の切り身","牛肉の切り身","牛肉の切り身","牛肉の切り身","牛肉の切り身","牛肉の切り身","牛肉の切り身","牛肉の切り身","牛肉の切り身"]
    
    var comment = "めちゃめちゃ美味しかったです。リブステーキが特に美味しくてほっぺた落ちちゃいました。"
    
    var value:[Int] = [4000,1234,5000,3000,5120,3000,12000,2000,4000,9888,1000,3000,2000,1000]
    
    var alerttitle = ""
    
    var customcolor = CustomColor()
    //========================================検索に必要なもの(追加)======================================
    var searchController = UISearchController()//検索バー
    var tableView: UITableView!//検索テーブル

    //検索候補
    let suggestions:[String] = ["和食レストランとんでん","パティスリーラパージュ","トンカツ坊","スーリール","道頓堀習志野台店","ガスト習志野台店","トントン拍子","ジョナサン習志野台","サンマルクパフェ習志野台"]
    
    var searchResults:[String] = []//検索結果
    var searchstore = ""
    var category = ["おすすめ","メニュー","雰囲気"]
    //========================================検索に必要なもの===========================================
    
    //tabのbackview
    let backview = UIView()
    
    //右上のボタン
    var selectBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //レイアウト
        tabbarcontroller()
        
        //collectionviewの基本設定
        collection2setting()
        topcell()
        
        //navigationの設定
//        setupNavigation()
        deleteBuckTitle()
        
        //検索バー(追加)
        if acountResister == "ユーザ"{
            setupSearchcontroller()
            kutikomimoji()
            commentButton()
        }
    }
}

//検索テーブルのsearchcontrolelr(追加)
extension PhotoSelectViewController:UISearchResultsUpdating,UISearchBarDelegate{
    
    //検索テーブル
    func setupSearchcontroller(){
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "店名を入力"
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.keyboardAppearance = .default
        searchController.searchBar.delegate = self
        searchController.searchBar.setValue("完了", forKey: "_cancelButtonText")
        searchController.searchBar.setShowsCancelButton(false, animated: true)
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
        tableView.removeFromSuperview()
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
//        performSegue(withIdentifier: "toSearchTable", sender: nil)
        searchController.searchBar.showsCancelButton = true
        tablesettings()
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
//        pageindex = (firstindex?.row)!
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
        searchstore = searchController.searchBar.text!
        
        searchController.searchBar.resignFirstResponder()
        searchController.searchBar.showsCancelButton = false
        tableView.removeFromSuperview()
        self.tableView.reloadData()

    }
    
}


//collection周り
extension PhotoSelectViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collection2setting(){
        // レイアウト設定
        let photoselectLayouting = PhotoSelectLayouting()
        photoselectLayouting.photoselectCell(collectionView: collectionView2, view: view)
        
        collectionView2.delegate = self
        collectionView2.dataSource = self
        
        collectionView2.decelerationRate = .fast
    }
    
    //セクションの数
    internal func numberOfSections(in collectionView: UICollectionView) -> Int {
        if cameratarget == "新規"{
            return 1
        }
        else{
            return 3
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //ユーザで追加した場合
        if cameratarget == "新規"{
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
        
        let collectionsettings = CollectionSettings()
        let cell = collectionsettings.photoSelectCellForRowAt(originalimages: originalimages[indexPath.row],
                                                              acountResister: acountResister,
                                                              cameratarget: cameratarget,
                                                              categoryname: "おすすめ",
                                                              productname: dishname[indexPath.row],
                                                              moneyname: value[indexPath.row],
                                                              collectionvew: collectionView2,
                                                              indexPath: indexPath)
        
        
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
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let contensts = collectionView2.contentOffset.x
        let width = view.frame.size.width
        pageindex = Int(contensts/width)
    }
}

//ボタンが押された時の画面遷移
extension PhotoSelectViewController{
    //ボタンから取得する
    @objc func tomoney(sender: UIButton){
        
        if let indexPath = collectionView2.indexPath(for: sender.superview!.superview as! UICollectionViewCell) {
            print("\(indexPath.row)番目の品名を取得しました")
            alerttitle = "品名を決める"
            performSegue(withIdentifier: "toCameraLast", sender: nil)

        }
    }
    //ボタンから取得する
    @objc func todish(sender: UIButton){
        
        if let indexPath = collectionView2.indexPath(for: sender.superview!.superview as! UICollectionViewCell) {
            print("\(indexPath.row)番目の料理を取得しました")
            alerttitle = "価格を決める"
            performSegue(withIdentifier: "toCameraLast", sender: nil)
        }
    }
    
    //ボタンから取得する
    @objc func tocategory(sender: UIButton){
        
        if let indexPath = collectionView2.indexPath(for: sender.superview!.superview as! UICollectionViewCell) {
            print("\(indexPath.row)番目のカテゴリを取得しました")
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
        if segue.identifier == "toSearchTable" {
            let nextView = segue.destination as! SearchTableViewController
            nextView.settings = "お店検索"
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
        self.navigationItem.rightBarButtonItem = edititem
        
    }
    func deleteBuckTitle(){
        let backButtonItem = UIBarButtonItem(image: UIImage(named: "backsegue")?.withRenderingMode(.alwaysOriginal),
                                             style: .plain,
                                             target: self,
                                             action: #selector(backaction));
        
        self.navigationItem.setLeftBarButton(backButtonItem, animated: true)
    }
    @objc func backaction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func filteraciton(){
        let config = FMPhotoPickerConfig()
        let vc = FMImageEditorViewController(config: config, sourceImage: originalimages[pageindex])
        vc.delegate = self
        
        self.present(vc, animated: true)
    }
}


//cellの下にある[口コミ]とその書き込みを表示するレイアウト
extension PhotoSelectViewController{
    func kutikomimoji(){
        let label = UILabel()
        let width = view.frame.size.width
        let photoselectLayouting = PhotoSelectLayouting()
        
        photoselectLayouting.kutikomiLayout(label: label, view: view)
        label.text = "口コミ"
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: width / 23.4)
        label.textAlignment = NSTextAlignment.right
        label.sizeToFit()
        view.addSubview(label)
    }
    
    func commentButton(){
        
        // UIButtonのインスタンスを作成する
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(commentaction), for: UIControl.Event.touchUpInside)
        let photoselectLayouting = PhotoSelectLayouting()
        photoselectLayouting.comment(comment: button)

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




//tabbar周りのレイアウト
extension PhotoSelectViewController{
    func tabbarcontroller(){
        backviewground()
        deleteBtn()
        filterBtn()
        
        if cameratarget == "新規"{
            alertButton()
        }
        else{
            savephotoBtn()
        }
        
    }
    func backviewground(){
        let width = view.frame.size.width
        let height = view.frame.size.height
        //        画面合わせ
        //        backview.frame = CGRect(x: 0, y: 733, width: 375, height: 79)
        backview.frame = CGRect(x: 0, y: height / 1.11, width: width, height: height / 10.27)
        backview.backgroundColor = UIColor.init(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        view.addSubview(backview)
    }
    
    func deleteBtn(){
        let button = UIButton(type: .custom)
        let width = view.frame.size.width
        button.addTarget(self, action: #selector(deletephoto), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 0,
                              y: 0,
                              width: width / 18.75,
                              height: width / 14.4);
        button.layer.position = CGPoint(x: view.frame.size.width - 30, y: backview.frame.size.height / 2)
        button.setImage(UIImage(named: "delete"), for: UIControl.State())
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.backview.addSubview(button)
    }
    
    func savephotoBtn(){
        let button = UIButton(type: .custom)
        let width = view.frame.size.width
        button.frame = CGRect(x: 0,
                              y: 0,
                              width: width / 18.75,
                              height: width / 14.4);
        button.layer.position = CGPoint(x: 30, y: backview.frame.size.height / 2)
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.setImage(UIImage(named: "savephoto"), for: UIControl.State())
        button.addTarget(self, action: #selector(savephoto), for: UIControl.Event.touchUpInside)
        
        
        self.backview.addSubview(button)
    }
    
    func alertButton(){
        
        let button = UIButton(type: .custom)
        let width = view.frame.size.width
        let height = view.frame.size.height
        button.frame = CGRect(x: width / 14.4,
                              y: height / 1.07,
                              width: width / 12,
                              height: width / 14.4);
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.setTitle("投稿", for: .normal)
        button.titleLabel?.font = UIFont.init(name: "HelveticaNeue-Medium", size: 15)
        button.setTitleColor(customcolor.selectColor(), for: .normal)
        button.titleLabel?.sizeToFit()
        button.addTarget(self, action: #selector(dicidesegue), for: UIControl.Event.touchUpInside)
        
        
        self.view.addSubview(button)
    }
    func filterBtn(){
        let button = UIButton(type: .custom)
        let width = view.frame.size.width
        button.frame = CGRect(x: 0,
                              y: 0,
                              width: width/14.4,
                              height: width/14.4);
        button.layer.position = CGPoint(x: view.frame.size.width / 2, y: backview.frame.size.height / 2)
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.setImage(UIImage(named: "edititem"), for: UIControl.State())
        button.addTarget(self, action: #selector(filteraciton), for: UIControl.Event.touchUpInside)
        
        
        backview.addSubview(button)
    }
    
    @objc func dicidesegue(){
        
        //店名が入力されていない
        if searchstore == ""{

            _ = SweetAlert().showAlert("保存しますか？",
                                       subTitle: "お店が指定されていないと掲載はできません",
                                       style: AlertStyle.warning,
                                       buttonTitle:"いいえ",
                                       buttonColor:UIColor.colorFromRGB(0xD0D0D0) ,
                                       otherButtonTitle:"はい",
                                       otherButtonColor: UIColor.colorFromRGB(0xDD6B55))
            { (isOtherButton) -> Void in
                if isOtherButton == true {
                }
                else {
                    _ = SweetAlert().showAlert("保存しました", subTitle: "", style: AlertStyle.success)
                    self.dismiss(animated: true, completion: nil)
                }
            }
            
            
        }else{
            _ = SweetAlert().showAlert("写真を保存しました", subTitle: "店名:\(searchstore)", style: AlertStyle.success)
            dismiss(animated: true, completion: nil)
        }
    }
    
    //写真を編集
    @objc func editphotoAction(){
        let config = FMPhotoPickerConfig()
        let vc = FMImageEditorViewController(config: config, sourceImage: originalimages[pageindex])
        vc.delegate = self
        
        self.present(vc, animated: true)
    }
    
    //端末に保存する
    @objc func savephoto(){
        
        let activityItems = [originalimages[pageindex] as Any] as [Any]
        
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
        originalimages[pageindex] = photo
        collectionView2.reloadData()
        print("編集おわた")
        self.dismiss(animated: true, completion: nil)
    }
    func fmPhotoPickerController(_ picker: FMPhotoPickerViewController, didFinishPickingPhotoWith photos: [UIImage]) {
        self.dismiss(animated: true, completion: nil)
    }
}
