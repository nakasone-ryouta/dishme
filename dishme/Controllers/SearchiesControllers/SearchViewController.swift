//
//  SearchViewController.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/09/11.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import UIKit
import collection_view_layouts
import AMScrollingNavbar

class SearchViewController: UIViewController ,LayoutDelegate{
    
    private var cellSizes = [[CGSize]]()
    
    //インジケータ
    private let refreshControl = UIRefreshControl()
    
    
    //dammydata
    var menuies:[String] = ["肉料理","海鮮料理","居酒屋","中華","イタリアン"]
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
    
    var settings = ""
    var variable = ""
    var distance = ""

    @IBOutlet weak var menubarcollectionView: UICollectionView!
    @IBOutlet weak var dishcollectionView: UICollectionView!
    

    
    //次の画面にスタート位置を渡す
    var firstindex:IndexPath? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //インジケータの基本設定
        refreshControllSettings()
        
        //collectionの基本設定
        collectionsettings()
        
        // navigationitemの設定周り
        setupNavigation()
        
        //インスタ
        instalayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        scrollUpsettings()
        setupNavigation()
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        scrollStopsettings()
    }
    

}
//スクロール周り
extension SearchViewController{
    //スクロールのアップ
    func scrollUpsettings(){
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            navigationController.followScrollView(dishcollectionView, delay: 10.0, followers: [NavigationBarFollower(view: menubarcollectionView, direction: .scrollUp),
                                                                                               NavigationBarFollower(view: dishcollectionView, direction: .scrollUp),])
        }
    }
    
    //スクロールのストップ
    func scrollStopsettings(){
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            navigationController.stopFollowingScrollView()
        }
    }
    //移動するスクロールviewの設定
    open func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            navigationController.showNavbar(animated: true)
        }
        return true
    }
}

//navigation周り
extension SearchViewController{
    
    //navigationのタイトル
    func setupNavigation(){
        self.navigationItem.title = variable + "  \(distance)"
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.setRightBarButtonItems([spotitem() ,searchitem()], animated: true)
    }
    //kmを指定するitem
    func spotitem() ->UIBarButtonItem{
        let spotitem = UIBarButtonItem(image: UIImage(named: "spotitem")?.withRenderingMode(.alwaysOriginal),
                                       style: .plain,
                                       target: self,
                                       action: #selector(spotaction));
        return spotitem
    }
    //検索ボタンitem
    func searchitem() ->UIBarButtonItem{
        let searchitem = UIBarButtonItem(image: UIImage(named: "searchitem")?.withRenderingMode(.alwaysOriginal),
                                         style: .plain,
                                         target: self,
                                         action: #selector(searchaction));
        return searchitem
    }
    
    @objc func spotaction(){
        settings = "距離"
        performSegue(withIdentifier: "toSearchTable", sender: nil)
    }
    @objc func searchaction(){
        settings = "検索"
        performSegue(withIdentifier: "toSearchTable", sender: nil)
    }
}

//refreshcontroll周り
extension SearchViewController{
    //インジケータの基本設定
    func refreshControllSettings(){
        dishcollectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(SearchViewController.refresh(sender:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1)
    }
    //インジケータ
    @objc func refresh(sender: UIRefreshControl) {
        self.refreshControl.endRefreshing()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            //ここに更新時の処理
        }
        self.dishcollectionView.contentOffset = CGPoint.zero
        
    }
}

//collectionview周り
extension SearchViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    //collectionの基本設定
    func collectionsettings(){
        //インスタのレイアウト
        instalayout()
        
        menubarcollectionView.delegate = self
        menubarcollectionView.dataSource = self
        
        dishcollectionView.delegate = self
        dishcollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //料理のカテゴリ
        if collectionView == menubarcollectionView{
            return menuies.count
        }
        //料理の写真
        else{
            return dishes.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //料理のカテゴリ
        if collectionView == menubarcollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menubarCell", for: indexPath) as! menubarCell
            cell.label.text = menuies[indexPath.row]
            menucellsettings(cell: cell)
            
            return cell
        }
        //料理の写真
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dishCell", for: indexPath) as! dishCell
            cell.imageView.image = dishes[indexPath.row]
            
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //料理のカテゴリ
        if collectionView == menubarcollectionView{
            let cell = collectionView.cellForItem(at: indexPath) as! menubarCell
            cell.backgroundColor = UIColor.init(red: 75/255, green: 149/255, blue: 233/255, alpha: 1)
            cell.label.textColor = .white
            cell.layer.borderColor = UIColor.init(red: 75/255, green: 149/255, blue: 233/255, alpha: 1).cgColor
        }
        //料理の写真
        else{
            firstindex = indexPath
            performSegue(withIdentifier: "toSearch2", sender: nil)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == menubarcollectionView{
            //料理のカテゴリ
            let cell = collectionView.cellForItem(at: indexPath) as! menubarCell
            cell.backgroundColor = .white
            cell.label.textColor = .black
            cell.layer.borderColor = UIColor.black.cgColor
        }
        else{
        }
    }
    
    //menubarの設定周り
    func menucellsettings(cell:menubarCell){
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.cornerRadius = 5
        cell.layer.masksToBounds = true
        menubarcollectionView.backgroundColor = UIColor.init(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
    }
    //インスタの表示
    func cellSize(indexPath: IndexPath) -> CGSize {
        return cellSizes[indexPath.section][indexPath.row]
    }
    
    //インスタのレイアウト周り
    func instalayout(){
        let layout: BaseLayout = InstagramLayout()
        layout.delegate = self
        layout.cellsPadding = ItemsPadding(horizontal: 1, vertical: 1)
        
        dishcollectionView.collectionViewLayout = layout
        dishcollectionView.reloadData()
    }
    
    //画面に渡す値
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSearch2" {
            let nextView = segue.destination as! Search2ViewController
            nextView.firstindex = firstindex
        }
        if segue.identifier == "toSearchTable" {
            let nextView = segue.destination as! SearchTableViewController
            nextView.settings = settings
            nextView.variable = variable
        }
    }
}
