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
    
    var canScrollToTop: Bool = false
    
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
                            UIImage(named: "meat15")!,]

    @IBOutlet weak var menubarcollectionView: UICollectionView!
    @IBOutlet weak var dishcollectionView: UICollectionView!
    
//========================================検索に必要なもの(追加)======================================
    var searchController = UISearchController()//検索バー
    var tableView: UITableView!//検索テーブル
    //オススメの検索候補
    var favorite:[String] = ["肉料理","海鮮料理","イタリアン","中華料理","インド料理","居酒屋","バル","TVで人気","パフェ"]
    //検索候補
    let suggestions:[String] = ["肉料理", "肉のバル", "肉の居酒屋","肉十八番","東京肉センター秋葉原店", "肉チーズ", "肉人気"]
    var favoritejudge = "おすすめ"//おすすめをタッチするか検索されたものをタッチするか
    var searchResults:[String] = []//検索結果
//========================================検索に必要なもの===========================================
    //次の画面にスタート位置を渡す
    var firstindex:IndexPath? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //インジケータ
        dishcollectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(SearchViewController.refresh(sender:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1)

        
        menubarcollectionView.delegate = self
        menubarcollectionView.dataSource = self
        
        dishcollectionView.delegate = self
        dishcollectionView.dataSource = self
        
        // navigationitemの設定周り
        setupNavigation()
        
        //インスタ
        instalayout()
        
        //検索バー(追加)
        setupSearchcontroller()
        
        
    }
    
    //インジケータ
    @objc func refresh(sender: UIRefreshControl) {
        self.refreshControl.endRefreshing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        }
        self.dishcollectionView.contentOffset = CGPoint.zero
        
    }
    
    // Enable the navbar scrolling
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            navigationController.followScrollView(dishcollectionView, delay: 10.0, followers: [NavigationBarFollower(view: menubarcollectionView, direction: .scrollUp),
                NavigationBarFollower(view: dishcollectionView, direction: .scrollUp),])
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        tabbarsettings()
        canScrollToTop = true
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        canScrollToTop = false
        
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            navigationController.stopFollowingScrollView()
        }
    }
    
    func setupNavigation(){
       self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    open func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            navigationController.showNavbar(animated: true)
        }
        return true
    }

}

//menubar
extension SearchViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == menubarcollectionView{
            return menuies.count
        }else{
            return dishes.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //メニューbar周り
        if collectionView == menubarcollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menubarCell", for: indexPath) as! menubarCell
            
            cell.label.text = menuies[indexPath.row]
            menucellsettings(cell: cell)
            return cell
        }
        //写真を表示周り
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dishCell", for: indexPath) as! dishCell
            cell.imageView.image = dishes[indexPath.row]
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == menubarcollectionView{
            let cell = collectionView.cellForItem(at: indexPath) as! menubarCell
            cell.backgroundColor = UIColor.init(red: 75/255, green: 149/255, blue: 233/255, alpha: 1)
            cell.label.textColor = .white
            cell.layer.borderColor = UIColor.init(red: 75/255, green: 149/255, blue: 233/255, alpha: 1).cgColor
        }else{
            firstindex = indexPath
           performSegue(withIdentifier: "toSearch2", sender: nil)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == menubarcollectionView{
            let cell = collectionView.cellForItem(at: indexPath) as! menubarCell
            cell.backgroundColor = .white
            cell.label.textColor = .black
            cell.layer.borderColor = UIColor.black.cgColor
            
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
    }
}


//検索テーブルのsearchcontrolelr(追加)
extension SearchViewController:UISearchResultsUpdating,UISearchBarDelegate{
    
    //検索テーブル
    func setupSearchcontroller(){
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.showsCancelButton = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = "肉料理・魚料理"
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.keyboardAppearance = .default
        searchController.searchBar.delegate = self
        
        navigationItem.titleView = searchController.searchBar
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
        searchController.searchBar.showsCancelButton = true
        searchController.searchBar.keyboardAppearance = .default
        return true
    }
    
//    func searchBarSearchButtonClicked( _ searchBar: UISearchBar){
//
//    }
    
    // キャンセルボタンが押されたらキャンセルボタンを無効にしてフォーカスを外す
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tableView.removeFromSuperview()
        searchController.searchBar.showsCancelButton = false
    }
    
}

//検索テーブル(追加)
extension SearchViewController: UITableViewDelegate,UITableViewDataSource {
    func tablesettings(){
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        tableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: self.view.frame.width, height: self.view.frame.height))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.searchBar.text == ""{
            return favorite.count
        }
        else if searchController.isActive{
            return searchResults.count
        } else {
            return suggestions.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        
        cell.textLabel!.font = UIFont.init(name: "HelveticaNeue-Bold", size: 16)
        
        if searchController.searchBar.text == ""{
            cell.textLabel!.text = favorite[indexPath.row]
            favoritejudge = "おすすめ"
        }
        else if searchController.isActive {
            cell.textLabel!.text = "\(searchResults[indexPath.row])"
            favoritejudge = "検索"
        } else {
            cell.textLabel!.text = "\(suggestions[indexPath.row])"
            favoritejudge = "検索"
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        setupSearchcontroller()
        searchController.searchBar.resignFirstResponder
        
        //検索されたものかおすすめに出てきているものをタッチしたのかの判別
        if favoritejudge == "検索"{
            searchController.searchBar.text = suggestions[indexPath.row]
        }else{
            searchController.searchBar.text = favorite[indexPath.row]
        }
        searchController.searchBar.showsCancelButton = false
        tableView.removeFromSuperview()
    }
    
}

extension SearchViewController: UITabBarControllerDelegate{
    func tabbarsettings(){
        self.tabBarController?.delegate = self
        canScrollToTop = true
    }
    // TabBarItemが押下された時に呼ばれる
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        // 呼ばれたTabBarItemの番号(0, 1,..)
        let tabBarIndex = tabBarController.selectedIndex
        // 一応確認する
        print(tabBarIndex)
        
        if tabBarIndex == 0 && canScrollToTop {
            
            // 一番上に移動
            self.dishcollectionView.setContentOffset(CGPoint.zero, animated: true)
        }
    }
}

