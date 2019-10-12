
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //レイアウト
        tabbarcontroller()
        
        
        collection2setting()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView2.scrollToItem(at: firstindex!, at: .right, animated: false)
    }
}

extension PhotoSelectViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collection2setting(){
        // レイアウト設定
        let layout = CustomFlowLayout()
        layout.itemSize = CGSize(width: 375, height: 500)
        collectionView2.collectionViewLayout = layout
        
        collectionView2.delegate = self
        collectionView2.dataSource = self
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView2.dequeueReusableCell(withReuseIdentifier: "Cell2",for: indexPath as IndexPath) as! PhotosBigViewCell
            
            if acountResister == "企業"{
                
                view.sendSubviewToBack(cell.commentView)
                
                //写真
                cell.imageView.image = originalimages[indexPath.row]
                
                //[コメント]の非表示ラベル
                cell.commentView.text = ""
                cell.commentmoji.text = ""
                cell.valuemoji.text = "価格"
                
                //[4000円]の表示ボタン
                cell.productBtn.setTitle("\(dishname[indexPath.row])", for: UIControl.State.normal)
                cell.productBtn.backgroundColor = UIColor.init(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
                
                
                //[商品名]の表示ボタン
               cell.moneyBtn.setTitle("\(value[indexPath.row])円", for: UIControl.State.normal)
               cell.moneyBtn.backgroundColor = UIColor.init(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
                
                //アカウント選択
                cell.productBtn.addTarget(self, action: #selector(tomoney(sender:)), for: .touchUpInside)
                cell.moneyBtn.addTarget(self, action: #selector(todish(sender:)), for: .touchUpInside)
    
            }
            else{
                cell.commentmoji.text = "口コミ"
                cell.dishmoji.text = ""
                cell.valuemoji.text = ""
                cell.productBtn.removeFromSuperview()
                cell.moneyBtn.removeFromSuperview()
                
                // Section毎にCellのプロパティを変える.
                switch(indexPath.section){
                case 0:
                    cell.imageView.image = originalimages[indexPath.row]
                    cell.commentView.text = comment

                    
                case 1:
                    cell.imageView.image = originalimages[indexPath.row]
                    cell.commentView.text = comment

                case 2:
                    cell.imageView.image = originalimages[indexPath.row]
                    cell.commentView.text = comment

                    
                default:
                    cell.imageView.image = originalimages[indexPath.row]
                    cell.commentView.text = comment

                }
            }
            return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            switch acountResister {
            case "企業":
                performSegue(withIdentifier: "toCameraLast", sender: nil)
            default:
                performSegue(withIdentifier: "toPhotoComment", sender: nil)
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
        itemSize = CGSize(width: 375, height: 500)
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

//レイアウト
extension PhotoSelectViewController{
    func tabbarcontroller(){
        backview()
        deleteBtn()
        savephotoBtn()
        setupNavigation()
    }
    //価格を決める
    func dicidemoney(){
        
    }
    //品名を決める
    func dicidename(){
        
    }
    
    func userAcount(){
        
    }
    func Acount(){
        
    }
    
    func setupNavigation(){
        let selectBtn = UIBarButtonItem(title: "編集", style: .done, target: self, action: #selector(editphotoAction))
        self.navigationItem.rightBarButtonItems = [selectBtn]
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
        button.addTarget(self, action: #selector(savephoto), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 28,
                              y: 754,
                              width: 20,
                              height: 26);
        button.setImage(UIImage(named: "savephoto"), for: UIControl.State())
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.view.addSubview(button)
    }
    //写真を編集
    @objc func editphotoAction(){
        var config = FMPhotoPickerConfig()
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
        let cancelAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: {
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
    }
    func fmPhotoPickerController(_ picker: FMPhotoPickerViewController, didFinishPickingPhotoWith photos: [UIImage]) {
        self.dismiss(animated: true, completion: nil)
    }
}

