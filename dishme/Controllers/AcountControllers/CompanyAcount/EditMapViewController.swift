

//
//  EditMapViewController.swift
//  dishme
//
import UIKit
import MapKit

class EditMapViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    
    
    //検索バー
    var searchBar: UISearchBar!
    
    //住所
    var searchStr = "千葉県船橋市習志野５丁目"
    let companyname = "焼肉大地"
    
    //CLLocationManagerの入れ物を用意
    var myLocationManager:CLLocationManager!
    
    //指定された住所
    var passlocation:CLLocation? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupNavigation()
        searchAdress(adress: searchStr, adressname: companyname)
        setupSearchBar()
        
        //CLLocationManagerをインスタンス化
        myLocationManager = CLLocationManager()
        myLocationManager.requestWhenInUseAuthorization()
    }
    

    
    //位置情報取得に失敗したときに呼び出されるメソッド
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
    
}
extension EditMapViewController{
    func setupNavigation(){
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.title = companyname
        
        //右のボタン
        let selectBtn = UIBarButtonItem(title: "保存", style: .done, target: self, action: #selector(save))
        self.navigationItem.rightBarButtonItems = [selectBtn]
    }
}

//住所を探す
extension EditMapViewController{
    func searchAdress(adress: String ,adressname: String){
        self.view.endEditing(true)
        
        let myGeocoder:CLGeocoder = CLGeocoder()
        
        //住所を座標に変換する。
        myGeocoder.geocodeAddressString(adress, completionHandler: {(placemarks, error) in
            
            if(error == nil) {
                for placemark in placemarks! {
                    let location:CLLocation = placemark.location!
                    
                    //中心座標
                    let center = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
                    
                    //表示範囲
                    let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
                    
                    //中心座標と表示範囲をマップに登録する。
                    let region = MKCoordinateRegion(center: center, span: span)
                    self.mapView.setRegion(region, animated:true)
                    
                    //地図にピンを立てる。
                    let Pin = MKPointAnnotation()
                    Pin.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
                    Pin.title = adressname
                    self.mapView.addAnnotation(Pin)
                    
                    self.passlocation = location
                    
                }
            } else {
                print("検索結果がありません")
            }
        })
    }
}

//
extension EditMapViewController{
    //ボタン押下時の呼び出しメソッド
    @objc func save(){
        _ = SweetAlert().showAlert("変更が保存されました", subTitle: "", style: AlertStyle.success)
        self.navigationController?.popViewController(animated: true)
    }
}


//検索ボタン
extension EditMapViewController:UISearchBarDelegate{
    func setupSearchBar() {
        if let navigationBarFrame = navigationController?.navigationBar.bounds {
            let searchBar: UISearchBar = UISearchBar(frame: navigationBarFrame)
            searchBar.delegate = self
            searchBar.placeholder = "検索"
            searchBar.tintColor = UIColor.gray
            searchBar.keyboardType = UIKeyboardType.default
            navigationItem.titleView = searchBar
            navigationItem.titleView?.frame = searchBar.frame
            self.searchBar = searchBar
        }
    }
    
    // MARK: - UISearchBar Delegate methods
    
    // 編集が開始されたら、キャンセルボタンを有効にする
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
//        searchBar.showsCancelButton = true
        let selectBtn = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancel))
        self.navigationItem.rightBarButtonItems = [selectBtn]
        return true
    }
    
    @objc func cancel(){
        //保存ボタンに戻す
        let selectBtn = UIBarButtonItem(title: "保存", style: .done, target: self, action: #selector(save))
        self.navigationItem.rightBarButtonItems = [selectBtn]
        //テキストを閉じる
        searchBar.resignFirstResponder()
    }
    
    // 検索ボタンが押された時に呼ばれる
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //ここで決定して検索する
        searchAdress(adress: searchBar.text!, adressname: searchBar.text!)
        searchBar.resignFirstResponder()
        cancel()
    }
    
    // キャンセルボタンが押されたらキャンセルボタンを無効にしてフォーカスを外す
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
}
