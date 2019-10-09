



//
//  WatchViewController.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/09/19.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import UIKit

class Search2ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var cellTexts = ["Rib Face",
                     "Thinking Rib",
                     "焼肉大地",
                     "deliciase",
                     "gooodpig",
                     "Rib Face",
                     "Thinking Rib",
                     "焼肉大地",
                     "deliciase",
                     "gooodpig",
                     "Rib Face",
                     "Thinking Rib",
                     "焼肉大地",
                     "deliciase",
                     "deliciase",
                     ]
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
    var acountimage = UIImage(named: "acount1")
    var openHeights: [CGFloat] = [650,600,600,600,600,600,600,600,600,600,600,600,600,600,600]
    var comment = "めちゃめちゃ美味しかったです。リブステーキが特に美味しくてほっぺた落ちちゃいました。めちゃめちゃ美味しかったです。リブステーキが特に美味しくてほっぺた落ちちゃいました。"
    var goods:[Int] = [120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,]
    var bads:[Int] = [10,10,10,10,10,10,10,10,10,10,10,10,10,10,10]
    var isOpens = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,]
    
    var firstindex:IndexPath? = nil //初期位置
    
    var alreadygood = false
    var alreadybad = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CustomTableViewCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        //最初のスクロール位置
        
        DispatchQueue.main.async {
            self.tableView.scrollToRow(at: self.firstindex!, at: UITableView.ScrollPosition.top, animated: false)
        }
    }
}

extension Search2ViewController{
    
    //テーブルの行数を返却するメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTexts.count
    }
    
    //テーブルの行ごとのセルを返却するメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for:indexPath) as! TableViewCell
        cell.selectionStyle = .none
        cell.label.text = cellTexts[indexPath.row]
        cell.isOpen = isOpens[indexPath.row]
        cell.acountButton.setBackgroundImage(UIImage(named: "acount3"), for: UIControl.State())
        cell.acountButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        cell.dishImage.image = dishes[indexPath.row]
        
        cell.goodlabel.text = "\(goods[indexPath.row])"
        cell.badlabel.text = "\(bads[indexPath.row])"
        
        //コメントを書く
        cell.commentLabel.text = comment
        cell.commentLabel.numberOfLines = 0
        cell.commentLabel.sizeToFit()
        cell.commentLabel.lineBreakMode = .byWordWrapping
        
        //アカウント選択
        cell.acountButton.addTarget(self, action: #selector(self.toSearch3), for: .touchUpInside)
        cell.resevebButton.addTarget(self, action: #selector(self.toSearch3), for: .touchUpInside)
        cell.goodButton.addTarget(self, action: #selector(self.goodbutton), for: .touchUpInside)
        cell.badButton.addTarget(self, action: #selector(self.badButton), for: .touchUpInside)

        cell.backgroundColor = .white
        return cell
    }
}

extension Search2ViewController{
    //セルを選択した時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
        
            self.tableView.beginUpdates()
            if cell.isOpen{
                
                self.isOpens[indexPath.row] = true
                print("ここにコメントに行く処理を書く")
            }else{
                cell.isOpen = true
                self.isOpens[indexPath.row] = true
            }
            self.tableView.endUpdates()
            cell.layoutIfNeeded()
    }
    
    // テーブルセルの高さを返します
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return isOpens[indexPath.row] ? openHeights[indexPath.row] : 559
    }
    
    //ボタンから取得する
    @objc func toSearch3(sender: UIButton){
        
        if let indexPath = tableView.indexPath(for: sender.superview!.superview as! UITableViewCell) {
            print(indexPath)
        } else {
            print("not found...")
        }
        
        self.performSegue(withIdentifier: "toSearch3", sender: nil)
    }
    //GOODボタンから取得する
    @objc func goodbutton(sender: UIButton){
        
        if let indexPath = tableView.indexPath(for: sender.superview!.superview as! UITableViewCell) {
            let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
            
            //押されていなかった時の処理
            if alreadygood == false{
                alreadygood = true
                goods[indexPath.row] =  goods[indexPath.row] + 1
                cell.goodlabel.text! = "\(goods[indexPath.row])"
                
                let backImage = UIImage(named: "good")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                cell.goodButton.setImage(backImage, for: UIControl.State.normal)
                cell.goodButton.tintColor = UIColor.init(red: 55/255, green: 151/255, blue: 240/255, alpha: 1)
            //押されていた時の処理
            }else{
                alreadygood = false
                goods[indexPath.row] =  goods[indexPath.row] - 1
                cell.goodlabel.text! = "\(goods[indexPath.row])"
                
                let backImage = UIImage(named: "good")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                cell.goodButton.setImage(backImage, for: UIControl.State.normal)
                cell.goodButton.tintColor = .black
            }
        } else {
            print("not found...")
        }
    }
    //BADボタンから取得する
    @objc func badButton(sender: UIButton){


        let indexPath = tableView.indexPath(for: sender.superview!.superview as! UITableViewCell)
        let cell = tableView.cellForRow(at: indexPath!) as! TableViewCell
            
            //押されていなかった時の処理
            if alreadybad == false{
                alreadybad = true
                bads[indexPath!.row] =  bads[indexPath!.row] + 1
                cell.badlabel.text! = "\(bads[indexPath!.row])"
                
                let backImage = UIImage(named: "bad")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                cell.badButton.setImage(backImage, for: UIControl.State.normal)
                cell.badButton.tintColor = UIColor.init(red: 55/255, green: 151/255, blue: 240/255, alpha: 1)
                
            //押されていた時の処理
            }else{
                alreadybad = false
                bads[indexPath!.row] =  bads[indexPath!.row] - 1
                cell.badlabel.text! = "\(bads[indexPath!.row])"
                
                let backImage = UIImage(named: "bad")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                cell.badButton.setImage(backImage, for: UIControl.State.normal)
                cell.badButton.tintColor = .black
            }
    }
}
