



//
//  WatchViewController.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/09/19.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import UIKit

class Search2ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
     var acountRegister = "企業a"
     var firstindex:IndexPath? = nil //初期位置
    
    @IBOutlet weak var tableView: UITableView!
    
    var cellTexts = ["中曽根良太",
                     "井村彩乃",
                     "細井勇気",
                     "大塚愛",
                     "高村知英",
                     "匿名係",
                     "中曽根良太",
                     "井村彩乃",
                     "細井勇気",
                     "大塚愛",
                     "高村知英",
                     "匿名係",
                     ]

    
    var image:[[String]]? = [["meat1","meat2","meat4","meat5","meat6","meat7","meat8","meat9","meat10"],
                             ["meat2","meat3"],
                             ["meat3","meat4"],
                             ["meat4"],
                             ["meat5"],
                             ["meat6"],
                             ["meat7"],
                             ["meat8"],
                             ["meat9"],
                             ["meat10"]]
    
    //[企業の名前・保存の色を変えるための変数]
    var namerange:[Int] = []
    var attrText:[NSMutableAttributedString] = []
    
    var acountimage = UIImage(named: "acount1")
    var openHeights: [CGFloat] = [650,600,600,600,600,600,600,600,600,600,600,600,600,600,600]
    var comment = "めちゃめちゃ美味しかったです。\nリブステーキが特に美味しくてほっぺた落ちちゃいました。\nめちゃめちゃ美味しかったです。\nリブステーキが特に美味しくてほっぺた落ちちゃいました。"
    var goods:[Int] = [120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,]
    var bads:[Int] = [10,10,10,10,10,10,10,10,10,10,10,10,10,10,10]
    var isOpens = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,]
    var alreadygoods:[Bool] = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,]
    var alreadybads:[Bool] = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableviewの基本設定
        tablesettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //最初のcellの表示
        topcell()
        //navigation
        setupNavigation()
    }
}

//navigation周り
extension Search2ViewController{
    func setupNavigation(){
        self.navigationController?.navigationBar.tintColor = .black
    }
}

//tableview周り
extension Search2ViewController{
    
    //前の画面で選択されたセルがtopに来る
    func topcell(){
        DispatchQueue.main.async {
            self.tableView.scrollToRow(at: self.firstindex!, at: UITableView.ScrollPosition.top, animated: false)
        }
    }
    
    func tablesettings(){
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CustomTableViewCell")
    }
    
    //テーブルの行数を返却するメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return image!.count
    }
    
    //テーブルの行ごとのセルを返却するメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for:indexPath) as! TableViewCell
        
        //cellの表示
        cell.selectionStyle = .none
        cell.isOpen = isOpens[indexPath.row]
        cell.acountButton.setBackgroundImage(UIImage(named: "acount3"), for: UIControl.State())
        cell.acountButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        cell.goodlabel.text = "\(goods[indexPath.row])"
        cell.badlabel.text = "\(bads[indexPath.row])"
        
        
        //写真の表示
        let tablenumber = indexPath.row
        let photonumber = image?[indexPath.row].count
        cell.setImage(image: image!, tablenumber: tablenumber, photonumber: photonumber!, view: view)
        
        //コメントを書く
        cell.commentLabel.text = comment
        cell.commentLabel.numberOfLines = 4
        
        //企業の場合は保存ボタンはいらない
        if acountRegister == "企業"{
            cell.resevebButton.titleLabel?.text = ""
            cell.resevebButton.isHidden = true
        }
        
        
        //acountの名前の設定
        cell.resevebButton.setTitle(cellTexts[indexPath.row] + "・お店を保存", for: UIControl.State.normal)
        cell.resevebButton.setTitleColor(UIColor.black, for: .normal)
        cell.resevebButton.titleLabel!.font = UIFont.init(name: "HelveticaNeue-Medium", size: 15)
        namerange.append(cellTexts[indexPath.row].count)
        attrText.append(NSMutableAttributedString(string: cell.resevebButton.titleLabel!.text!))
        attrText[indexPath.row].addAttribute(.foregroundColor,
                              value: UIColor.init(red: 55/255, green: 151/255, blue: 240/255, alpha: 1), range: NSMakeRange(namerange.last!, 6))
        cell.resevebButton.setAttributedTitle(attrText[indexPath.row], for: .normal)
        
        //何番目のボタンが押されているか
        cell.detailButton.tag = indexPath.row
        cell.acountButton.tag = indexPath.row
        
        //アカウント選択
        cell.detailButton.addTarget(self, action: #selector(self.detailaction), for: .touchUpInside)
        cell.acountButton.addTarget(self, action: #selector(self.toYouserAcount), for: .touchUpInside)
        cell.resevebButton.addTarget(self, action: #selector(self.saveacount), for: .touchUpInside)
        cell.goodButton.addTarget(self, action: #selector(self.goodbutton), for: .touchUpInside)
        cell.badButton.addTarget(self, action: #selector(self.badButton), for: .touchUpInside)

        return cell
    }
    
    //セルを選択した時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
        
        self.tableView.beginUpdates()
        if cell.isOpen{
            self.isOpens[indexPath.row] = true
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
}

//cell内のボタン選択時
extension Search2ViewController{
    
    //画面遷移
    @objc func toYouserAcount(sender: UIButton){
        print(sender.tag)
        self.performSegue(withIdentifier: "toYouserAcount", sender: nil)
    }
    
    @objc func detailaction(){
        
        performSegue(withIdentifier: "toSearch3", sender: nil)
    }
    
    //保存ボタン
    @objc func saveacount(sender: UIButton){
        let indexPath = tableView.indexPath(for: sender.superview!.superview as! UITableViewCell)
        print("\(indexPath!.row)番目のみせを保存しました")
        _ = SweetAlert().showAlert("店を保存しました", subTitle: "", style: AlertStyle.success)
    }
    
    //GOODボタンから取得する
    @objc func goodbutton(sender: UIButton){
        
        let indexPath = tableView.indexPath(for: sender.superview!.superview as! UITableViewCell)
        let cell = tableView.cellForRow(at: indexPath!) as! TableViewCell
            
            //押されていなかった時の処理
        if alreadygoods[indexPath!.row] == false{
            alreadygoods[indexPath!.row] = true
            goods[indexPath!.row] =  goods[indexPath!.row] + 1
            cell.goodlabel.text! = "\(goods[indexPath!.row])"
                
                let backImage = UIImage(named: "good")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                cell.goodButton.setImage(backImage, for: UIControl.State.normal)
                cell.goodButton.tintColor = UIColor.init(red: 55/255, green: 151/255, blue: 240/255, alpha: 1)
            //押されていた時の処理
            }else{
            alreadygoods[indexPath!.row] = false
            goods[indexPath!.row] =  goods[indexPath!.row] - 1
            cell.goodlabel.text! = "\(goods[indexPath!.row])"
                
                let backImage = UIImage(named: "good")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                cell.goodButton.setImage(backImage, for: UIControl.State.normal)
                cell.goodButton.tintColor = .black
            }
    }
    
    //BADボタンから取得する
    @objc func badButton(sender: UIButton){


        let indexPath = tableView.indexPath(for: sender.superview!.superview as! UITableViewCell)
        let cell = tableView.cellForRow(at: indexPath!) as! TableViewCell
            
            //押されていなかった時の処理
        if alreadybads[(indexPath?.row)!] == false{
            alreadybads[(indexPath?.row)!] = true
                bads[indexPath!.row] =  bads[indexPath!.row] + 1
                cell.badlabel.text! = "\(bads[indexPath!.row])"
                
                let backImage = UIImage(named: "bad")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                cell.badButton.setImage(backImage, for: UIControl.State.normal)
                cell.badButton.tintColor = UIColor.init(red: 55/255, green: 151/255, blue: 240/255, alpha: 1)
                
            //押されていた時の処理
            }else{
            alreadybads[(indexPath?.row)!] = false
                bads[indexPath!.row] =  bads[indexPath!.row] - 1
                cell.badlabel.text! = "\(bads[indexPath!.row])"
                
                let backImage = UIImage(named: "bad")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                cell.badButton.setImage(backImage, for: UIControl.State.normal)
                cell.badButton.tintColor = .black
            }
    }
}
