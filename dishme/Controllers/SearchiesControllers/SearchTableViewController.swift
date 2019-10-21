



//
//  SearchTableViewController.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/10/15.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import UIKit

class SearchTableViewController: UIViewController {
    
    //========================================検索に必要なもの(追加)======================================
    var searchController = UISearchController()//検索バー
    var tableView: UITableView!//検索テーブル
    //オススメの検索候補
    var favorite:[String] = ["肉料理","海鮮料理","イタリアン","中華料理","インド料理","居酒屋","バル","TVで人気","パフェ"]
    //検索候補
    let suggestions:[String] = ["肉料理", "肉のバル", "肉の居酒屋","肉十八番","東京肉センター秋葉原店", "肉チーズ", "肉人気"]
    
    var spot:[String] = ["300m以内","500m以内","1km以内","2km以内","3km以内"]
    var favoritejudge = "おすすめ"//おすすめをタッチするか検索されたものをタッチするか
    var searchResults:[String] = []//検索結果
    //========================================検索に必要なもの===========================================

    var settings = ""
    var variable = ""
    var distance = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        switch settings{
        case "検索":
            setupSearchcontroller()
            tablesettings()
        default:
            tablesettings()
        }
        
        setupNavagation()
        
    }

}

extension SearchTableViewController{
    func setupNavagation(){

        let backButtonItem = UIBarButtonItem(image: UIImage(named: "backsegue")?.withRenderingMode(.alwaysOriginal),
                                         style: .plain,
                                         target: self,
                                         action: #selector(backaction));
        
        self.navigationItem.setLeftBarButtonItems([backButtonItem], animated: true)
    }
    
    @objc func backaction(){
        self.navigationController?.popViewController(animated: true)
    }
}

//検索テーブルのsearchcontrolelr(追加)
extension SearchTableViewController:UISearchResultsUpdating,UISearchBarDelegate{
    
    //検索テーブル
    func setupSearchcontroller(){
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.showsCancelButton = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = settings
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
        searchController.searchBar.showsCancelButton = true
        searchController.searchBar.keyboardAppearance = .default
        self.tableView.reloadData()
        return true
    }
    
    // キャンセルボタンが押されたらキャンセルボタンを無効にしてフォーカスを外す
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationController?.popViewController(animated: true)
        searchController.searchBar.showsCancelButton = false
    }
    
}

//検索テーブル(追加)
extension SearchTableViewController: UITableViewDelegate,UITableViewDataSource {
    func tablesettings(){
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        tableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: self.view.frame.width, height: self.view.frame.height))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //距離
        if settings == "距離"{
            return spot.count
        }
        //検索
        if searchController.searchBar.text != ""{
            return searchResults.count
        }
        //検索結果
        else {
            return suggestions.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        
        cell.textLabel!.font = UIFont.init(name: "HelveticaNeue-Medium", size: 16)
        
        //距離
        if settings == "距離"{
            tableView.tableFooterView = UIView(frame: .zero)
            cell.textLabel!.text = "\(spot[indexPath.row])"
        }
        //検索
        else if searchController.searchBar.text != ""{
            cell.textLabel!.text = "\(searchResults[indexPath.row])"
        }
        //検索結果
        else {
            cell.textLabel!.text = "\(suggestions[indexPath.row])"
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        setupSearchcontroller()
//        searchController.searchBar.resignFirstResponder
        
        //距離
        if settings == "距離"{
            distance = spot[indexPath.row]
        }
        //検索
        else{
            searchController.searchBar.text = suggestions[indexPath.row]
            variable = suggestions[indexPath.row]
        }
        
        
        //Navigation Controllerを取得
        let nav = self.navigationController!
        let InfoVc = nav.viewControllers[nav.viewControllers.count-2] as! SearchViewController
        InfoVc.variable = variable
        InfoVc.distance = distance
        
        //閉じる
        self.navigationController?.popViewController(animated: true)
    }
}
