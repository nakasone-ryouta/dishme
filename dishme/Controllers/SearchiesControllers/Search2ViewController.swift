



//
//  WatchViewController.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/09/19.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import UIKit

class Search2ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

     var firstindex:IndexPath? = nil //初期位置
    
    var spectator = ""//誰がこの投稿詳細画面を見ているか
    var storename = ""
    
    var customcolor = CustomColor()
    
    @IBOutlet weak var tableView: UITableView!
    
    var cellTexts = ["焼肉大地",
                     "すき家の牛丼",
                     "ガスト習志野台店",
                     "焼肉のさかい",
                     "ぎゅうぎゅう若丸",
                     "焼肉大地",
                     "すき家の牛丼",
                     "ガスト習志野台店",
                     "焼肉のさかい",
                     "ぎゅうぎゅう若丸",
                     "牛若丸",
                     "継承園",
                     ]
    
    var acountname = ["中曽根良太",
                     "井村彩乃",
                     "米田完",
                     "大塚愛",
                     "高村知英",
                     "匿名係",
                     "中曽根良太",
                     "井村彩乃",
                     "細井ゆうき",
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
    var openHeights: [CGFloat] = [600,600,600,600,600,600,600,600,600,600,600,600,600,600,600]
    var commentnumbar = [30,21,21,2,21,21,2,33,8,7,64]
    var comment = "めちゃめちゃ美味しかったです。\nリブステーキが特に美味しくてほっぺた落ちちゃいました。"
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
        self.navigationController?.navigationBar.tintColor = customcolor.selectColor()
    }
}

//tableview周り
extension Search2ViewController{
    
    //前の画面で選択されたセルがtopに来る
    func topcell(){
        DispatchQueue.main.async {
            //sectionは常に0として処理する
            let indexPath = IndexPath(row: (self.firstindex?.row)!, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.top, animated: false)
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
        
        //写真の表示
        let tablenumber = indexPath.row
        let photonumber = image?[indexPath.row].count
        cell.setImage(image: image!, tablenumber: tablenumber, photonumber: photonumber!, view: view)
        
        //コメント
        cell.commentLabel.text = comment
        cell.commentNumber.text = "\(commentnumbar[indexPath.row])"



        //お店名の登録
        cell.resevebButton.setTitle(cellTexts[indexPath.row] + "・お店を保存", for: UIControl.State.normal)
        cell.resevebButton.setTitleColor(UIColor.black, for: .normal)
        cell.resevebButton.titleLabel!.font = UIFont.init(name: "HelveticaNeue-Medium", size: 13)
        namerange.append(cellTexts[indexPath.row].count)
        attrText.append(NSMutableAttributedString(string: cell.resevebButton.titleLabel!.text!))
        attrText[indexPath.row].addAttribute(.foregroundColor,
                                             value: customcolor.selectColor(),
                                             range: NSMakeRange(namerange.last! + 1, 5))
        cell.resevebButton.setAttributedTitle(attrText[indexPath.row], for: .normal)
        
        //何番目のボタンが押されているか
        cell.acountButton.tag = indexPath.row
        cell.goodButton.tag = indexPath.row
        cell.badButton.tag = indexPath.row
        
        //アカウント選択
        cell.youserAcountButton.addTarget(self, action: #selector(self.toYouserAcount), for: .touchUpInside)
        cell.acountButton.addTarget(self, action: #selector(self.detailaction), for: .touchUpInside)
        cell.resevebButton.addTarget(self, action: #selector(self.saveacount), for: .touchUpInside)
        cell.goodButton.addTarget(self, action: #selector(self.goodbutton), for: .touchUpInside)
        cell.badButton.addTarget(self, action: #selector(self.badButton), for: .touchUpInside)
        cell.commentButton.addTarget(self, action: #selector(self.commentaction), for: .touchUpInside)
        
        //編集ボタンの選択
        if spectator == "本人"{
            cell.editButton.addTarget(self, action: #selector(self.toPhotoSelect), for: .touchUpInside)
        }
        else{
            cell.editButton.setTitle("", for: .normal)
        }
        
        //その他UI部品の配置
        cell.selectionStyle = .none
        cell.isOpen = isOpens[indexPath.row]
        cell.acountButton.setBackgroundImage(UIImage(named: "acount3"), for: UIControl.State())
        cell.acountButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        cell.goodlabel.text = "\(goods[indexPath.row])"
        cell.badlabel.text = "\(bads[indexPath.row])"
        
        //投稿者のアカウント登録
        cell.youserAcountButton.setImage(UIImage(named: "acount5"), for: UIControl.State())
        cell.youserAcountButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        
        //ユーザアカウントの名前
        cell.youserAcountnameLabel.text = "投稿者　" + acountname[indexPath.row]
        
        return cell
    }
    
    //セルを選択した時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
        //コメント込みの高さを返す
        if self.isOpens[indexPath.row] == false{
            let commentHeight = cell.commentLabel.frame.size.height
            openHeights[indexPath.row] = openHeights[indexPath.row] + commentHeight - 55
        }
        
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
    
    @objc func commentaction(){
        
        performSegue(withIdentifier: "toReply", sender: nil)
    }
    @objc func toPhotoSelect(){
        
        performSegue(withIdentifier: "toPhotoSelect", sender: nil)
    }
    
    
    //保存ボタン
    @objc func saveacount(sender: UIButton){
        let indexPath = tableView.indexPath(for: sender.superview!.superview as! UITableViewCell)
        print("\(indexPath!.row)番目のみせを保存しました")
        _ = SweetAlert().showAlert("店を保存しました", subTitle: "", style: AlertStyle.success)
    }
    
    //GOODボタンの処理
    @objc func goodbutton(sender: DOFavoriteButton){
        let indexPath = tableView.indexPath(for: sender.superview!.superview as! UITableViewCell)
        let cell = tableView.cellForRow(at: indexPath!) as! TableViewCell
        
        //ボタンの判定
        let evalutionbutton = EvalutionButton()
        let result = evalutionbutton.goodButton(alreadygoods: alreadygoods,indexPath: indexPath!, goods: goods, button: cell.goodButton)
        
        alreadygoods[(indexPath?.row)!] = result.alreadygoods
        cell.goodlabel.text! = "\(result.goods)"
        cell.goodButton = result.button
    }
    
    //BADボタンの処理
    @objc func badButton(sender: DOFavoriteButton){


        let indexPath = tableView.indexPath(for: sender.superview!.superview as! UITableViewCell)
        let cell = tableView.cellForRow(at: indexPath!) as! TableViewCell
        
        //ボタンの判定
        let evalutionbutton = EvalutionButton()
        let result = evalutionbutton.badButton(alreadybads: alreadybads,indexPath: indexPath!, bads: bads, button: cell.badButton)
        
        alreadybads[(indexPath?.row)!] = result.alreadybads
        cell.badlabel.text! = "\(result.bads)"
        cell.badButton = result.button
    }
    
    //画面に渡す値
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toYouserAcount"{
            let nextView = segue.destination as! YouserAcountViewController
            nextView.spectator = spectator
        }
        if segue.identifier == "toPhotoSelect"{
            let nextView = segue.destination as! PhotoSelectViewController
            nextView.firstindex = firstindex
            nextView.storename = storename
        }
    }
}
