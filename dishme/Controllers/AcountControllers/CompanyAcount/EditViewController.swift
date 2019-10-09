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

class EditViewController: UIViewController,ScrollingNavigationControllerDelegate{
    
    //[ユーザのメニュー追加],[企業のメニュー追加],[口コミの追加]
    var cameratarget = "企業のメニューの追加"
    
    //EditSetting画面に渡す値
    var setting = ""
    //Photoselect画面に渡す値
    var firstindex:IndexPath? = nil
    
    //pagecollection
    var myCollectionView : UICollectionView!
    var sectionTitle:[String] = ["メインメニュー","サイドメニュー","ドリンク","Narasino"]
    let backview = UIView()
    
    //アカウントアイコンの写真
    let acountimageView = UIImageView()
    
    //tabbar
    let tabBar : UITabBar = UITabBar(frame: CGRect(x: 0, y: 360, width: 375, height: 200))
    
    //スクロールview
    let scrollView = UIScrollView()
    let menuview = UIView()
    let acountview = UIView()
    
    //メニューのcollectionview
    var collectionView: UICollectionView!
    
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
    
    //レストラン情報
    var tableView: UITableView  =   UITableView()
    var opentitle = "営業中"
    var opentime = "12:00〜13:00"
    var position = "Certificate of Excellence"
    var acountname = "Ribe Face"
    var phonenumber = 08069539797
    var acountimage = UIImage(named: "acount1")
    var congestion = "混雑時間"
    var maxnumber = "10"
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
        
        //下写真
        backView()
        //写真の設定
        collectionSettings()
        
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

//スクロールviewの基本設定
extension EditViewController{
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
                                y: 600,
                                width: scrollView.frame.size.width,
                                height: scrollView.frame.size.height)
        self.scrollView.addSubview(menuview)
        
        
    }
}

//基本レイアウト周り
extension EditViewController{
    func backgroundcontroller(){
        restaurantInfo()
        acountimageview()
        acountImageChange()
        
        //テキスト
        textview()
        nameLabel()
        nameEditLabel()
    }
    func textview(){
        let myTextView = UITextView()
        myTextView.frame = CGRect(x: 17, y: 185, width: 337, height: 59)
        myTextView.text = comment
        myTextView.textAlignment = NSTextAlignment.left
        acountview.addSubview(myTextView)
    }
    
    func acountimageview(){
        acountimageView.image = acountimage
        acountimageView.frame = CGRect(x: 17, y: 98, width: 85, height: 85)
        acountimageView.contentMode = .scaleAspectFill
        acountimageView.circle()
        self.acountview.addSubview(acountimageView)
    }
    
    func acountImageChange (){
        let button = UIButton()
        button.addTarget(self, action: #selector(showAlbum), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 33,
                              y: 50,
                              width: 0,
                              height: 0);
        button.setTitle("写真を変更", for: .normal) // ボタンのタイトル
        button.titleLabel?.font = UIFont.init(name: "HelveticaNeue-Bold", size: 11)
        button.sizeToFit()
        button.setTitleColor(UIColor.white, for: .normal)
        scrollView.addSubview(button)
    }
    @objc func savephoto(){
        print("呼び出されました")
    }
    
    func nameLabel(){
        //時間帯
        let text_view1 = UITextField()
        text_view1.frame = CGRect(x: 149, y: 115, width: 211, height: 50)
        text_view1.textAlignment = .right
        text_view1.font = UIFont.systemFont(ofSize: 17)
        text_view1.placeholder = "焼肉大地"
        text_view1.addBorderBottom(height: 1.0, color: UIColor.lightGray)
        acountview.addSubview(text_view1)
    }
    
    func nameEditLabel(){
        let label = UILabel()
        label.frame =  CGRect(x: 149, y: 134, width: 0, height: 0)
        label.text = "名前"
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 16)
        label.textAlignment = .center
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        acountview.addSubview(label)
    }
}

//レストラン情報のtableview
extension EditViewController:UITableViewDataSource,UITableViewDelegate{
    
    func restaurantInfo(){
        //下から出てくるtableview
        tableView.frame = CGRect(
            x: 0.0,
            y: 250,
            width: self.view.frame.width,
            height: 420
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
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: .subtitle, reuseIdentifier: "Home")
        
        tableView.estimatedRowHeight = 66
        tableView.rowHeight = UITableView.automaticDimension
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
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
        }
        //電話
        if indexPath.row == 3{
            cell.textLabel?.text = String(phonenumber)
            cell.textLabel?.textAlignment = NSTextAlignment.right
            cell.textLabel?.font = UIFont.init(name: "HelveticaNeue-Bold", size: 13)
        }
        //中休み
        if indexPath.row == 4{
            cell.textLabel?.text = "中休み"
            cell.textLabel?.textAlignment = NSTextAlignment.right
            cell.textLabel?.font = UIFont.init(name: "HelveticaNeue-Bold", size: 13)
            //営業時間
            cell.detailTextLabel?.text = opentime
            cell.detailTextLabel?.textAlignment = NSTextAlignment.left
        }
        //最大定員数
        if indexPath.row == 5{
            cell.textLabel?.text = "１時間予約上限人数"
            cell.textLabel?.textAlignment = NSTextAlignment.right
            cell.textLabel?.font = UIFont.init(name: "HelveticaNeue-Bold", size: 13)
            //営業時間
            cell.detailTextLabel?.text = maxnumber + "名"
            cell.detailTextLabel?.textAlignment = NSTextAlignment.left
        }
        if indexPath.row == 6{
            cell.textLabel?.text = "定休日"
            cell.textLabel?.textAlignment = NSTextAlignment.right
            cell.textLabel?.font = UIFont.init(name: "HelveticaNeue-Bold", size: 13)
            //営業時間
            cell.detailTextLabel?.text = holiday
            cell.detailTextLabel?.textAlignment = NSTextAlignment.left
        }
        //臨時休業
        if indexPath.row == 7{
            cell.textLabel?.text = "臨時休業"
            cell.textLabel?.textAlignment = NSTextAlignment.right
            cell.textLabel?.font = UIFont.init(name: "HelveticaNeue-Bold", size: 13)
            //営業時間
            cell.detailTextLabel?.text = temporaryClosed
            cell.detailTextLabel?.textAlignment = NSTextAlignment.left
        }
        
        //選択不可
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            print("営業時間に飛ぶ")
            setting = "営業時間"
            performSegue(withIdentifier: "toEditSetting", sender: nil)
        }
        else if indexPath.row == 1{
            print("営業場所に飛ぶ")
            setting = "混雑時間"
            performSegue(withIdentifier: "toEditSetting", sender: nil)
        }
        else if indexPath.row == 2{
            setting = "地図"
            performSegue(withIdentifier: "toEditMap", sender: nil)
        }
        else if indexPath.row == 3{
            setting = "電話番号"
            performSegue(withIdentifier: "toEditSetting", sender: nil)
        }
        else if indexPath.row == 4{
            setting = "中休み"
            performSegue(withIdentifier: "toEditSetting", sender: nil)
        }
        else if indexPath.row == 5{
            setting = "定員人数"
            performSegue(withIdentifier: "toEditSetting", sender: nil)
        }
        else if indexPath.row == 6{
            //定休日
            performSegue(withIdentifier: "toEditRegularHoliday", sender: nil)
        }
        else if indexPath.row == 7{
            //臨時休業の設定
            performSegue(withIdentifier: "toEditHoliday", sender: nil)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditSetting" {
            let nextVC = segue.destination as! EditSettingViewController
            nextVC.setting = setting
        }
        if segue.identifier == "toCamera" {
            let nextVC = segue.destination as! CameraViewController
            nextVC.cameratarget = cameratarget
        }
        if segue.identifier == "toPhotoSelect"{
            let nextVC = segue.destination as! PhotoSelectViewController
            nextVC.firstindex = firstindex
        }
    }
}

extension EditViewController: UICollectionViewDelegate , UICollectionViewDataSource{
    
    func backView(){
        backview.frame = CGRect(x: 0, y: 580, width: 375, height: 1000)
        scrollView.addSubview(backview)
    }
    func collectionSettings(){
        // CollectionViewのレイアウトを生成.
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:124, height:124)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.headerReferenceSize = CGSize(width:100,height:60)
        
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.sectionInset = UIEdgeInsets.zero
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        // Cellに使われるクラスを登録.
        myCollectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        myCollectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Section")
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        myCollectionView.backgroundColor = .white
        
        self.backview.addSubview(myCollectionView)
    }
    
    //セクションの数
    internal func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionTitle[section]
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : PhotosCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath as IndexPath) as! PhotosCollectionViewCell
        
        // Section毎にCellのプロパティを変える.
        switch(indexPath.section){
        case 0:
            cell.backgroundColor = UIColor.red
            cell.textLabel?.text = "0"
            cell.imageView?.image = dishes[indexPath.row]
            
        case 1:
            cell.backgroundColor = UIColor.green
            cell.textLabel?.text = "1"
            cell.imageView?.image = dishes[indexPath.row]
            
        case 2:
            cell.backgroundColor = UIColor.blue
            cell.textLabel?.text = "2"
            cell.imageView?.image = dishes[indexPath.row]
            
        default:
            print("section error")
            cell.backgroundColor = UIColor.white
        }
        
        return cell
    }
    //セクションの高さ
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: self.view.frame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("Num: \(indexPath.row)")
        print("SectionNum:\(indexPath.section)")
        
        firstindex = indexPath
        performSegue(withIdentifier: "toPhotoSelect", sender: nil)
        
    }
    
    
    /*
     Sectionに値を設定する
     */
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        var view:SectionHeader?
        view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Section", for: indexPath) as? SectionHeader
        
        if kind == UICollectionView.elementKindSectionHeader {
            view?.setTitle(title: sectionTitle[indexPath.section])
            
            view?.button.addTarget(self, action: #selector(menuadd), for: UIControl.Event.touchUpInside)
            return view!
        }
        return UICollectionReusableView()
    }
    
    @objc func menuadd(){
        print("押されたよーーー")
        performSegue(withIdentifier: "toCamera", sender: nil)
    }
}

//カメラ機能
extension EditViewController:UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
    
    // アルバムを表示
    @objc func showAlbum() {
        
        let sourceType:UIImagePickerController.SourceType =
            UIImagePickerController.SourceType.photoLibrary
        
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.photoLibrary){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
            print("Tap the [Start] to save a picture")
            
        }
        else{
            print("error")
            
        }
    }
    
    //　撮影が完了時した時に呼ばれる
    func imagePickerController(_ imagePicker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        if let pickedImage = info[.originalImage]
            as? UIImage {
            acountimage = pickedImage
            acountimageView.removeFromSuperview()
            acountimageView.circle()
            acountimageview()
            
        }
        //閉じる処理
        imagePicker.dismiss(animated: true, completion: nil)
        print("Tap the [Save] to save a picture")
        
        
    }
    
    // 撮影がキャンセルされた時に呼ばれる
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        print("Canceled")
    }
    
    // 書き込み完了結果の受け取り
    @objc func image(_ image: UIImage,
                     didFinishSavingWithError error: NSError!,
                     contextInfo: UnsafeMutableRawPointer) {
        
        if error != nil {
            print(error.code)
            print("Save Failed !")
        }
        else{
            print("Save Succeeded")
        }
    }
}
