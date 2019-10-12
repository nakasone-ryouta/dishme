import UIKit
import AMScrollingNavbar

class Search4ViewController: UIViewController {
    
    //次の画面に渡す値
    var firstindex: IndexPath? = nil
    
    //渡されてきた値
    var controllerjudge = ""
    
    //メニューのページ
    var pageMenu: PageMenuViewinit!
    
    //ページメニューのview
    let backview = UIView()
    
    //お金
    var money:[Int] = [3200,
                       2000,
                       7655,
                       1234,
                       2344,
                       9876,
                       654,
                       112,
                       9986,
                       3200,
                       ]
    
    //おすすめ
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
                            ]
    
    //メニュー
    var sidemenus:[UIImage] = [UIImage(named: "sidemenu1")!,
                               UIImage(named: "sidemenu2")!,
                               UIImage(named: "sidemenu3")!,
                               UIImage(named: "sidemenu4")!,
                               UIImage(named: "sidemenu5")!,
                               UIImage(named: "sidemenu6")!,
                               UIImage(named: "sidemenu7")!,
                               UIImage(named: "sidemenu8")!,
                               UIImage(named: "sidemenu9")!,
                               UIImage(named: "sidemenu10")!,
                               ]

    //雰囲気
    var appearance:[UIImage] = [UIImage(named: "appearance1")!,
                                UIImage(named: "appearance2")!,
                                UIImage(named: "appearance3")!,
                                UIImage(named: "appearance4")!,
                                UIImage(named: "appearance5")!,
                                UIImage(named: "appearance6")!,
                                UIImage(named: "appearance7")!,
                                UIImage(named: "appearance8")!,
                                UIImage(named: "appearance9")!,
                                UIImage(named: "appearance10")!,
                                ]
    
    //おすすめ
    var name:[String] = ["meat1",
                         "meat2",
                         "meat3",
                         "meat4",
                         "meat5",
                         "meat6",
                         "meat7",
                         "meat8",
                         "meat9",
                         "meat10",
                         ]
    
    //メニュー
    var sidemenuname:[String] = ["デザート１",
                         "デザート１",
                         "デザート２",
                         "デザート３",
                         "デザート４",
                         "デザート５",
                         "デザート６",
                         "デザート７",
                         "デザート８",
                         "デザート９",
                         "デザート１０",
                         ]
    
    //雰囲気
    var appearancename:[String] = ["外観",
                         "外観",
                         "外観",
                         "外観",
                         "外観",
                         "外観",
                         "店内",
                         "店内",
                         "店内",
                         "外観",
                         ]
    
    //インスタンス化
    var tableView1: UITableView  =   UITableView()
    var tableView2: UITableView  =   UITableView()
    var tableView3: UITableView  =   UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        //メニューの設定
        tableview1settings()
        
        //navigationの基本設定
        setupNavigation()
    }

}
extension Search4ViewController{
    func setupNavigation(){
        navigationItem.title = controllerjudge
    }
}

//テーブルview
extension Search4ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableview1settings(){
        
        //インスタンス化
        tableView1 =  UITableView()
        
        //下から出てくるtableview
        tableView1.frame = CGRect(
            x: 0.0,
            y: 0,
            width: self.view.frame.width,
            height: 812
        )
        
        tableView1.delegate      =   self
        tableView1.dataSource    =   self
        tableView1.separatorStyle = .none
        
        tableView1.backgroundColor = UIColor.init(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        tableView1.register (UINib(nibName: "Search4TableViewCell", bundle: nil),forCellReuseIdentifier:"Search4TableViewCell")
        tableView1.contentMode = .scaleAspectFit
        
        DispatchQueue.main.async {
            self.tableView1.scrollToRow(at: self.firstindex!, at: UITableView.ScrollPosition.top, animated: false)
        }
        
        view.addSubview(tableView1)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch controllerjudge {
        case "おすすめ":
            return dishes.count
        case "メニュー":
            return sidemenus.count
        case "雰囲気":
            return appearance.count
        default:
            break;
        }
        return dishes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Search4TableViewCell") as! Search4TableViewCell
        
        switch controllerjudge {
        case "おすすめ":
            cell.dishImage.image = dishes[indexPath.row]
            cell.dishName.text = name[indexPath.row]
            cell.money.text = "\(money[indexPath.row])円/人"
            
        case "メニュー":
            cell.dishImage.image = sidemenus[indexPath.row]
            cell.dishName.text = sidemenuname[indexPath.row]
            cell.money.text = "\(money[indexPath.row])円/人"
            
        case "雰囲気":
            cell.dishImage.image = appearance[indexPath.row]
            cell.dishName.text = appearancename[indexPath.row]
            cell.money.text = ""
        default:
            break;
        }
        
        //選択不可
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 375
    }
}
