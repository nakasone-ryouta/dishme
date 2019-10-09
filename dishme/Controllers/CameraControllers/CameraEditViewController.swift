

//
//  CameraEditViewController.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/09/17.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import UIKit
import Photos
import SnapLikeCollectionView

class CameraEditViewController: UIViewController,SnapLikeDataDelegate{
    
    //[ユーザのメニュー追加],[企業のメニュー追加],[口コミの追加]
    var cameratarget = ""
    
    //フィルタ
    let filter = Filtering()
    
    var filterimages:[UIImage] = []//フィルタの個数、なので同じ画像がフィルタ分ある
    var nowimage:UIImage? = nil //編集中の写真
    var originalimages:[UIImage] = []//渡されてきたオリジナル写真配列
    var copyimages:[UIImage] = []//オリジナル写真配列を残すコピーの配列
    
    var filterImage:UIImage? = nil//フィルタをかける写真
    var filterindex = 0//フィルタをかける写真が何番目か
    
    //検索バー
    var searchBar: UISearchBar!
    var searchstore = "なし"
    
    var selectBtn: UIBarButtonItem!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionView2: UICollectionView!
    
    // Cell
    private var dataSource: SnapLikeDataSource<CameraEditCollectionViewCell>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //最初にエラーが出ないように
        nowimage = originalimages[0]
        copyimages = originalimages
        filterImage = originalimages[0]
        
        
        //collection上の写真
        colletion1settings()
        
        //filtercollectionの設定
        collection2setting()
        
        
        //保存ボタン
        setupNavigation()
        
        //検索バー
        setupSearchBar()
        
    }
    func getAssetThumbnail(asset: [PHAsset]) -> [UIImage] {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        option.deliveryMode = .highQualityFormat
        var thumbnail:[UIImage] = []
        option.isSynchronous = true
        
        for i in 0..<asset.count{
            manager.requestImage(for: asset[i], targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
                thumbnail.append(result!)
            })
        }
        return thumbnail
    }
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
    
    func setupNavigation(){
        selectBtn = UIBarButtonItem(title: "保存", style: .done, target: self, action: #selector(dicidesegue))
        self.navigationItem.rightBarButtonItems = [selectBtn]
    }
    @objc func dicidesegue(){
        if cameratarget == "企業のメニューの追加"{
            performSegue(withIdentifier: "toCameraLast", sender: nil)
        }
        else if cameratarget == "ユーザのメニュー追加"{
            _ = SweetAlert().showAlert("写真を保存しました", subTitle: "店名:\(searchstore)", style: AlertStyle.success)
        }
        else if cameratarget == "口コミの追加"{
            _ = SweetAlert().showAlert("写真を保存しました", subTitle: "店名:\(searchstore)", style: AlertStyle.success)
        }
    }

    
    func colletion1settings(){
        // 真ん中にいる時と通常時のcellの大きさを入れる
        let cellSize = SnapLikeCellSize(normalWidth: 390, centerWidth: 400)
        // cellSizeとcollectionViewを渡してdataSouceをinit
        dataSource = SnapLikeDataSource<CameraEditCollectionViewCell>(collectionView: collectionView, cellSize: cellSize)
        dataSource?.delegate = self
        
        // flowLayoutにもcellSizeを渡す
        let layout = SnapLikeCollectionViewFlowLayout(cellSize: cellSize)
        collectionView.collectionViewLayout = layout
        
        // ここはお決まりな感じ。decelerationRateとか以外と大事です。
        collectionView.register(UINib(nibName: "CameraEditCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "CameraEditCollectionViewCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast
        collectionView.backgroundColor = .clear
        collectionView.delegate = dataSource
        collectionView.dataSource = dataSource
        
        // 先ほどCellのItemに入れた型のarrayをitemsに入れていきます。
        dataSource?.items = originalimages
    }
    
    func collectionreload(){
        // 真ん中にいる時と通常時のcellの大きさを入れる
        let cellSize = SnapLikeCellSize(normalWidth: 390, centerWidth: 400)
        // cellSizeとcollectionViewを渡してdataSouceをinit
        dataSource = SnapLikeDataSource<CameraEditCollectionViewCell>(collectionView: collectionView, cellSize: cellSize)
        dataSource?.delegate = self
        
        
        // ここはお決まりな感じ。decelerationRateとか以外と大事です。
        collectionView.register(UINib(nibName: "CameraEditCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "CameraEditCollectionViewCell")
        collectionView.delegate = dataSource
        collectionView.dataSource = dataSource
    }
    
}

// cellが選択されたらcellSelectedが呼ばれます
extension CameraEditViewController {
    func cellSelected(_ index: Int) {
        DispatchQueue.main.async { [weak self] in
            
            
            self!.filterImage = self!.copyimages[index]
            self!.filterindex = index
            self!.nowimage = self!.originalimages[index]
            
            self!.filterimages = []
            self!.collection2setting()
            self!.collectionView2.reloadData()
        }
            
    }
}


//検索ボタン
extension CameraEditViewController:UISearchBarDelegate{
    func setupSearchBar() {
        if let navigationBarFrame = navigationController?.navigationBar.bounds {
            let searchBar: UISearchBar = UISearchBar(frame: navigationBarFrame)
            searchBar.delegate = self
            searchBar.frame = CGRect(x: 0, y: 0, width: 375, height: 30)
            searchBar.placeholder = "店名を検索"
            searchBar.tintColor = UIColor.gray
            searchBar.keyboardType = UIKeyboardType.default
            navigationItem.titleView = searchBar
            navigationItem.titleView?.frame = searchBar.frame
            self.searchBar = searchBar
        }
    }
    
    // 検索ボタンが押された時に呼ばれる
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchstore = searchBar.text!
        cancel()
    }
    
    // 編集が開始されたら、キャンセルボタンを有効にする
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
//        searchBar.showsCancelButton = true
        selectBtn = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancel))
        self.navigationItem.rightBarButtonItems = [selectBtn]
        return true
    }
    @objc func cancel(){
        //保存ボタンに戻す
        selectBtn = UIBarButtonItem(title: "保存", style: .done, target: self, action: #selector(dicidesegue))
        self.navigationItem.rightBarButtonItems = [selectBtn]
        //テキストを閉じる
        searchBar.resignFirstResponder()
    }
}


extension CameraEditViewController: UICollectionViewDataSource,UICollectionViewDelegate{
    func collection2setting(){
        collectionView2.delegate = self
        collectionView2.dataSource = self
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return filter.filtercount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell2",for: indexPath as IndexPath) as! CameraFilterCollectionViewCell
        
        //フィルタリングして配列に入れる
        filterimages.append(filter.getfilter(index: indexPath.row, nowimage: nowimage!))
        //フィルタ全体を表示
        cell.imageView.image = filterimages[indexPath.row]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        collectionreload()
        
        dataSource?.items = []//配列の初期化
        //フィルタリング
        copyimages[filterindex] = filter.getfilter(index: indexPath.row, nowimage: originalimages[filterindex])
        //フィルタをかけて配列に戻す
        
        dataSource?.items = copyimages
        
        collectionView2.reloadData()
        collectionView.reloadData()
        
    }
}


extension CameraEditViewController{
    
    @objc func segue(){
//        performSegue(withIdentifier: "toCameraLast", sender: nil)
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "TabbarController") as! UITabBarController
            self.present(secondViewController, animated: true, completion: nil)
    }
    //画面に渡す値
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCameraLast" {
            let nextView = segue.destination as! CameraLastViewController
            nextView.searchstore = searchstore
            nextView.cameratarget = cameratarget
        }
    }
}
