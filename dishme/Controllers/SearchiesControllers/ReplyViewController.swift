

import UIKit


class ReplyViewController: UIViewController {
    
    @IBOutlet var acountImage: UIImageView!
    @IBOutlet var textField: UITextField!
    @IBOutlet var postButton: UIButton!
    
    @IBOutlet var tableView: UITableView!
    
    let textList:[String] = [
        "新しいdishmeのアプリが公開されました。ぜひ使ってみてください",
        "通知機能をONにすると常時お店の情報が記載されます。設定＞通知でONにできます",
        "株式会社forme運営担当中曽根です。この度新しい機能がdishmeに追加されました。",
        "新機能の追加や疑問点などは公式twitterをフォローして一定数のコメントを追加すると見れるようになります。",
        "企業登録登録ありがとうございます。dishmeがあなたの会社を全力でお客様を呼び込みたいと思います。います。dishmeがあなたの会社を全力でお客様を呼び込みたいと思いまいます。dishmeがあなたの会社を全力でお客様を呼び込みたいと思いまいます。dishmeがあなたの会社を全力でお客様を呼び込みたいと思いまいます。dishmeがあなたの会社を全力でお客様を呼び込みたいと思いまいます。dishmeがあなたの会社を全力でお客様を呼び込みたいと思いま",
        ]
    
    var dishes:[UIImage] = [UIImage(named: "meat1")!,
                            UIImage(named: "meat2")!,
                            UIImage(named: "meat3")!,
                            UIImage(named: "meat4")!,
                            UIImage(named: "meat2")!,
                            UIImage(named: "meat3")!,
                            UIImage(named: "meat4")!,
                            UIImage(named: "meat2")!,
                            UIImage(named: "meat3")!,
                            UIImage(named: "meat4")!,
                            UIImage(named: "meat5")!,
                            UIImage(named: "meat6")!,]
    
    var myacount = UIImage(named: "acount1")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableviewの基本設定
        tableviewsettings()
        
        //navigationの基本設定
        setNavigation()
        
        
        //textfieldの基本設定
        textfieldsettings()
        
        //投稿者のアイコン
        acountImage.circle()
        acountImage.image = myacount
        
        
    }
    
    //投稿ボタンが押される
    @IBAction func postButton(_ sender: UIButton) {
        textField.text = ""
        postButton.setTitleColor(UIColor.init(red: 179/255, green: 218/255, blue: 254/255, alpha: 1), for: .normal)
        textField.resignFirstResponder()
        postButton.isEnabled = false
        print("aaaaa")
    }
}
extension ReplyViewController :UITextFieldDelegate{
    
    func textfieldsettings(){
        textField.delegate = self
        
        postButton.setTitleColor(UIColor.init(red: 179/255, green: 218/255, blue: 254/255, alpha: 1), for: .normal)
        NotificationCenter.default.addObserver(self, selector: #selector(ReplyViewController.changeNotifyTextField(sender:)), name: UITextField.textDidChangeNotification, object: nil)
        
        
    }
    @objc public func changeNotifyTextField (sender: NSNotification) {
        guard let textView = sender.object as? UITextField else {
            return
        }
        //送信する
        if textView.text != nil {
            postButton.isEnabled = textView.text != ""
            postButton.setTitleColor(UIColor.init(red: 55/255, green: 151/255, blue: 240/255, alpha: 1), for: .normal)
            postButton.isEnabled = true
        }
        //送信できない
        if textField.text == ""{
            postButton.setTitleColor(UIColor.init(red: 179/255, green: 218/255, blue: 254/255, alpha: 1), for: .normal)
            postButton.isEnabled = false
        }
    }
}

//navigationの基本設定
extension ReplyViewController{
    func setNavigation(){
        navigationItem.title = "コメント"
    }
}
//tableviewの基本設定
extension ReplyViewController: UITableViewDataSource, UITableViewDelegate{
    func tableviewsettings(){
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register (UINib(nibName: "ReplyTableViewCell", bundle: nil),forCellReuseIdentifier:"ReplyTableViewCell")
        
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
    }
    //テーブルの行数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textList.count
    }
    
    //UITableViewDataSourceプロトコルの必須メソッド
    //指定行のセルデータを返す
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReplyTableViewCell", for: indexPath) as! ReplyTableViewCell

        cell.commentLabel.text = textList[indexPath.row]
        cell.commentLabel.textAlignment = NSTextAlignment.left
        
        cell.acountImage.image = dishes[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension //変更
    }
    
    //UITableViewDelegateプロトコルの必須メソッド
    //行をタップされたときに呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath:IndexPath)
    {
        print(textList[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
