import UIKit
import AVFoundation
import Photos

//ジャスチャー
struct CommonStructure {
    //タップ
    static var tapGesture = UITapGestureRecognizer()
    //スワイプ
    static var swipeGestureUP = UISwipeGestureRecognizer()
}


class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    
    //[ユーザ][企業]
    var acountResister = "企業a"
    //[新規ユーザ][企業]
    var cameratarget = "新規ユーザ"
    
    //アルバムカメラロール
    @IBOutlet weak var albumimageView: UIImageView!
    @IBOutlet weak var camerarollcolletionView: UICollectionView!
    
    //カメラ
    let aVC = AVCinSideOutSideObject()
    var cameraView = UIImageView()
    
    //ページのスクロール
    var pageMenu: PageMenuView!
    var pagebackview = UIView() //pageの下に引くview
    
    //メニューのcollectionview
    var collectionView: UICollectionView!
    var originalimages:[UIImage] = []
    
    
    var photoAssets = [PHAsset]()
    var selectedlocalIdentifiers = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //カメラの基本設定
        aVC.initscreen()
        
        
        cameraPosition() //カメラの位置調整
        zoomcamera()    //カメラのズーム設定
        
        
        //撮り溜めてくcollectionview
        collectionsettings()
        
        //カメラのメソッドをUIImageViewに付与
        cameraView = aVC.inSideOutSideCameraSet(cameraView: cameraView)
        
        //ページのbackviewのセット
        pagesettings()
        
        //navigationの基本設定
        navigation()
        
        //カメラロール
        setup()
        libraryRequestAuthorization()
    }
    
}
extension CameraViewController{
    func cameraPosition(){
        // ナビゲーションバーの高さを取得
        let navBarHeight = self.navigationController?.navigationBar.frame.size.height
        let width = view.frame.size.width
        
        cameraView.frame = view.frame
        cameraView.frame = CGRect(x: 0, y: navBarHeight!, width: width, height: width)
    }
}

//レイアウト周り
extension CameraViewController{
    func cameraButton() ->UIButton{
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(takepicture), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 0,
                              y: 0,
                              width: 81,
                              height: 81);
        button.layer.position = CGPoint(x: 187.5,
                                        y: 680)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 10
        button.layer.borderColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1).cgColor
        button.layer.cornerRadius = 40
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        return button
    }
    
    func changecameraButton() ->UIButton{
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(changecamera), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 23,
                              y: 422,
                              width: 20,
                              height: 22);
        button.setImage(UIImage(named: "camerachange"), for: UIControl.State())
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        return button
    }
    
    func underview() ->UIView{
        let backview = UIView()
        backview.frame = CGRect(x: 0, y: 462, width: 375, height: 367)
        backview.backgroundColor = .white
        return backview
    }
    
    //写真を撮影する
    @objc func takepicture(){
        aVC.cameraAction(captureDelegate: self)
    }
    //前カメラ後カメラ
    @objc func changecamera(){
        cameraView = aVC.inSideOutSideCameraSet(cameraView: cameraView)
    }
    //次へ
    @objc func nextsegue(){
        if originalimages == []{
             _ = SweetAlert().showAlert("写真がないため編集できません", subTitle: "写真をカメラで撮影するかライブラリから選択してください", style: AlertStyle.error)
        }else{
            self.performSegue(withIdentifier: "toPhotoSelect", sender: nil)
        }
    }
    //closeボタン
    @objc func closebutton(){
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "TabbarController") as! UITabBarController
        self.present(secondViewController, animated: true, completion: nil)
    }
    func zoomcamera(){
        aVC.setupPinchGestureRecognizer(addview: view)
    }
    //画面に渡す値
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPhotoSelect"{
            let nextView = segue.destination as! PhotoSelectViewController
            nextView.originalimages = originalimages
            nextView.acountResister = acountResister
            nextView.cameratarget = cameratarget
        }
    }
}

//navigation周り
extension CameraViewController{
    func navigation(){
        
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = .white
        
        //背面カメラ前面カメラ切り替え
        let change = UIBarButtonItem(title: "編集へ", style: .done, target: self, action: #selector(nextsegue))
        self.navigationItem.rightBarButtonItems = [change]
        
        //closeボタン
        let close = UIBarButtonItem(image: UIImage(named: "closebutton")?.withRenderingMode(.alwaysOriginal),
                                    style: .plain,
                                    target: self,
                                    action: #selector(closebutton));
        self.navigationItem.setLeftBarButtonItems([close], animated: true)
    }
}

//photoライブラリ周り
extension CameraViewController: UICollectionViewDataSource ,UICollectionViewDelegate{
    
    
    // フォトライブラリへの保存メソッド
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        let photoData = photo.fileDataRepresentation()
        guard photoData != nil else { return }
        // フォトライブラリに保存
        let image = UIImage(data: photoData!)!.cropping2square() //正方形に加工
        //        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        
        //collecitonviewに表示
        originalimages.append(image!)
        collectionView.reloadData()
    }
    
    //collectionの基本設定
    func collectionsettings(){
        collectionView = UICollectionView(frame: CGRect(x: 10, y: 493, width: self.view.frame.size.width, height: 135), collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = UIColor.white
        collectionView.register(CameraCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //横スライド
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        
    }
    
    // セルの数を返す
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == camerarollcolletionView{
            return photoAssets.count
        }
        else{
           return originalimages.count
        }
    }
    
    
    // セルの設定
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == camerarollcolletionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell2", for: indexPath) as! CameraRollCollectionViewCell
            
            let manager = PHImageManager.default()
            let option = PHImageRequestOptions()
            var thumbnail = UIImage()
            option.isSynchronous = true
            manager.requestImage(for: photoAssets[photoAssets.count - indexPath.row - 1], targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
                thumbnail = result!
            })
            
            cell.photoImageView.image = thumbnail
            cell.checkbox.image = nil
            cell.photoImageView.contentMode = UIView.ContentMode.scaleAspectFill
            //checkboxの設定
            cell.checkbox.image = nil
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",for: indexPath as IndexPath) as! CameraCollectionViewCell
            let cellImage = originalimages[indexPath.row]
            
            cell.setUpContents(image: cellImage)
            
            cell.deleteButton.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
            return cell
        }
    }
    
    //ボタンから取得する
    @objc func deleteAction(sender: UIButton){
        let indexPath = collectionView.indexPath(for: sender.superview!.superview as! UICollectionViewCell)
        originalimages.remove(value: originalimages[(indexPath?.row)!])
        collectionView.reloadData()
            print(indexPath!)
        
    }
    
    //セルを触った時
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == camerarollcolletionView{
            let cell = collectionView.cellForItem(at: indexPath) as! CameraRollCollectionViewCell
            
            
            let photoAsset = photoAssets[indexPath.row]
            let selectedIdentifier = photoAsset.localIdentifier
            
            //同じ写真があったら
            if selectedlocalIdentifiers.contains(selectedIdentifier){
                cell.checkbox.image = nil
                
                selectedlocalIdentifiers.remove(value: selectedIdentifier)
                originalimages.remove(value: cell.photoImageView.image!)
            }else{
                cell.checkbox.image = UIImage(named: "checkimage")
                selectedlocalIdentifiers.append(selectedIdentifier)
                originalimages.append(cell.photoImageView.image!)
            }
            
            //でかいviewに表示
            albumimageView.image = cell.photoImageView.image
        }
    }

    //collectionviewレイアウト
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout:UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == camerarollcolletionView{
            let horizontalSpace:CGFloat = 3
            let cellSize:CGFloat = self.view.bounds.width/3 - horizontalSpace
            return CGSize(width: cellSize, height: cellSize)
        }
        else{
            let horizontalSpace:CGFloat = 80
            let cellSize:CGFloat = self.view.bounds.width/2 - horizontalSpace
            
            return CGSize(width: cellSize, height: cellSize)
        }
    }
    
}



//ライブラリor写真を選ぶpage
extension CameraViewController: PageMenuViewDelegate{
    
    func willMoveToPage(_ pageMenu: PageMenuView, from viewController: UIViewController, index currentViewControllerIndex: Int) {
        print("---------")
        print(viewController.title!)
    }
    
    func didMoveToPage(_ pageMenu: PageMenuView, to viewController: UIViewController, index currentViewControllerIndex: Int) {
        print(viewController.title!)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if UIDevice.current.orientation == .portrait {
            pageMenu.frame = CGRect(
                x: 0, y: 20, width: view.frame.size.width, height: view.frame.size.height - 20)
        } else {
            pageMenu.frame = CGRect(
                x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        }
    }
    
    //pageの設定周り
    func pagesettings(){
        
        //view1のインスタンス化
        let viewController1 = UIViewController()
        let viewController2 = UIViewController()
        viewController1.view.backgroundColor = .white
        viewController1.title = "写真"
        
        //view2のインスタンス化
        viewController2.view.backgroundColor = .white
        viewController2.title = "ライブラリ"
        
        
        // Add to array
        let viewControllers = [viewController1, viewController2]
        
        //レイアウト周り
        positionsettings()
        pageview(controller: viewController1)
        pageview2(controller: viewController2)
        
        
        // Page menu UI option
        var option = PageMenuOption(frame: CGRect(
            x: 0, y: 20, width: view.frame.size.width, height: view.frame.size.height - 20))
        
        // Page menu UI option
        option = PageMenuOption(
            frame: CGRect(x: 0, y: 20, width: view.frame.size.width, height: view.frame.size.height - 20))
        option.menuItemWidth = view.frame.size.width / 2
        option.menuTitleMargin = 0
        
        // Page menu UI option
        option = PageMenuOption(frame: CGRect(
            x: 0, y: 20, width: view.frame.size.width, height: view.frame.size.height - 20))
        option.menuItemWidth = view.frame.size.width / 2
        //ここ
        option.menuItemBackgroundColorNormal = .white
        option.menuItemBackgroundColorSelected = .white
        option.menuTitleMargin = 0
        option.menuTitleColorNormal = .gray
        option.menuTitleColorSelected = .black
        option.menuIndicatorHeight = 6
        option.menuIndicatorColor = .white
        option.menuTitleFont = UIFont(name: "HelveticaNeue-Bold", size: 15)!
        option.menuItemHeight = 50

        
        
        pageMenu = PageMenuView(viewControllers: viewControllers, option: option)
        pageMenu.delegate = self
        view.addSubview(pageMenu)
    }
    
    //view1とview2の画面のレイアウトのposition
    func positionsettings(){
    }

    //カメラから追加
    func pageview(controller: UIViewController){
        controller.view.addSubview(cameraView)
        
        controller.view.addSubview(underview())
        controller.view.addSubview(cameraButton())
        controller.view.addSubview(changecameraButton())
        controller.view.addSubview(collectionView)
        
    }
    //写真から追加
    func pageview2(controller: UIViewController){
        controller.view.addSubview(camerarollcolletionView)
        controller.view.addSubview(albumimageView)
    }
}

//カメラロール周り
extension CameraViewController{
    
    fileprivate func setup() {
        camerarollcolletionView.dataSource = self
        
        // UICollectionViewCellのマージン等の設定
        let flowLayout: UICollectionViewFlowLayout! = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 4,
                                     height: UIScreen.main.bounds.width / 3 - 4)
        flowLayout.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 6
        
        camerarollcolletionView.collectionViewLayout = flowLayout
    }
    
    // カメラロールへのアクセス許可
    fileprivate func libraryRequestAuthorization() {
        PHPhotoLibrary.requestAuthorization({ [weak self] status in
            guard let wself = self else {
                return
            }
            switch status {
            case .authorized:
                wself.getAllPhotosInfo()
            case .denied:
                wself.showDeniedAlert()
            case .notDetermined:
                print("NotDetermined")
            case .restricted:
                print("Restricted")
            }
        })
    }
    
    // カメラロールから全て取得する
    fileprivate func getAllPhotosInfo() {
        let assets: PHFetchResult = PHAsset.fetchAssets(with: .image, options: nil)
        assets.enumerateObjects({ [weak self] (asset, index, stop) -> Void in
            guard let wself = self else {
                return
            }
            wself.photoAssets.append(asset as PHAsset)
            
        })
        camerarollcolletionView.reloadData()
    }
    
    // カメラロールへのアクセスが拒否されている場合のアラート
    fileprivate func showDeniedAlert() {
        let alert: UIAlertController = UIAlertController(title: "エラー",
                                                         message: "「写真」へのアクセスが拒否されています。設定より変更してください。",
                                                         preferredStyle: .alert)
        let cancel: UIAlertAction = UIAlertAction(title: "キャンセル",
                                                  style: .cancel,
                                                  handler: nil)
        let ok: UIAlertAction = UIAlertAction(title: "設定画面へ",
                                              style: .default,
                                              handler: { [weak self] (action) -> Void in
                                                guard let wself = self else {
                                                    return
                                                }
                                                wself.transitionToSettingsApplition()
        })
        alert.addAction(cancel)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    fileprivate func transitionToSettingsApplition() {
        let url = URL(string: UIApplication.openSettingsURLString)
        if let url = url {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    //UIImageをString型に変換
    func Image2String(image:UIImage) -> String? {
        
        //画像をNSDataに変換
        let data:NSData! = image.pngData()! as NSData
        
        //NSDataへの変換が成功していたら
        if let pngData:NSData = data {
            
            //BASE64のStringに変換する
            let encodeString:String = pngData.base64EncodedString(options: [])
            return encodeString
            
        }
        
        return nil
        
    }
    
    //String型をPhotoAssets型に変換
    func getPhotoAssetsByIdentifiers(localIdentifiers: [String]) -> [PHAsset] {
        var photoAssets = [PHAsset]()
        
        let assets = PHAsset.fetchAssets(withLocalIdentifiers: localIdentifiers, options: nil)
        
        assets.enumerateObjects({ [weak self] (asset, index, stop) -> Void in
            guard self != nil else {
                return
            }
            photoAssets.append(asset as PHAsset)
        })
        
        return photoAssets
    }

}
