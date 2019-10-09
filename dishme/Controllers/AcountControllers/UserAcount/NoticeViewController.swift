


//
//  NoticeViewController.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/10/08.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import UIKit

class NoticeViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let textList:[String] = [
        "新しいdishmeのアプリが公開されました。ぜひ使ってみてください",
        "通知機能をONにすると常時お店の情報が記載されます。設定＞通知でONにできます",
        "株式会社forme運営担当中曽根です。この度新しい機能がdishmeに追加されました。",
        "新機能の追加や疑問点などは公式twitterをフォローして一定数のコメントを追加すると見れるようになります。",
        "企業登録登録ありがとうございます。dishmeがあなたの会社を全力でお客様を呼び込みたいと思います。",
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        
        setNavigation()
    }
    
    func setNavigation(){
        navigationItem.title = "お知らせ"
    }
}

extension NoticeViewController: UITableViewDataSource, UITableViewDelegate{
    //UITableViewDataSourceプロトコルの必須メソッド
    //テーブルの行数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textList.count
    }
    
    //UITableViewDataSourceプロトコルの必須メソッド
    //指定行のセルデータを返す
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoticeTableViewCell", for: indexPath) as? NoticeTableViewCell else {
            return UITableViewCell()
        }
        
        cell.label.text = textList[indexPath.row]
        cell.label.textAlignment = NSTextAlignment.left
        return cell
    }
    
    //UITableViewDelegateプロトコルの必須メソッド
    //行をタップされたときに呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath:IndexPath)
    {
        print(textList[indexPath.row])
    }
}
