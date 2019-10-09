


//
//  SearchMapViewController.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/09/28.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import UIKit
import MapKit

class SearchMapViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    
    //住所
    let searchStr = "千葉県船橋市習志野５丁目"
    let companyname = "焼肉大地"
    
    //CLLocationManagerの入れ物を用意
    var myLocationManager:CLLocationManager!
    
    //
    var passlocation:CLLocation? = nil


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupNavigation()
        searchAdress()
        
        //CLLocationManagerをインスタンス化
        myLocationManager = CLLocationManager()
        myLocationManager.requestWhenInUseAuthorization()
    }
    func setupNavigation(){
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.title = companyname
        
        //右のボタン
        let selectBtn = UIBarButtonItem(title: "経路", style: .done, target: self, action: #selector(passmap))
        self.navigationItem.rightBarButtonItems = [selectBtn]
    }
    
    func searchAdress(){
        self.view.endEditing(true)
        
        let myGeocoder:CLGeocoder = CLGeocoder()
        
        //住所を座標に変換する。
        myGeocoder.geocodeAddressString(searchStr, completionHandler: {(placemarks, error) in
            
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
                    Pin.title = self.companyname
                    self.mapView.addAnnotation(Pin)
                    
                    self.passlocation = location
                    
                }
            } else {
                print("検索結果がありません")
            }
        })
    }
    
    //位置情報取得に失敗したときに呼び出されるメソッド
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }

}

extension SearchMapViewController{
    //ボタン押下時の呼び出しメソッド
    @objc func passmap(){
        //マップアプリに渡す目的地の位置情報を作る。
        let coordinate = CLLocationCoordinate2DMake((passlocation?.coordinate.latitude)!, (passlocation?.coordinate.longitude)!)
        let placemark = MKPlacemark(coordinate:coordinate, addressDictionary:nil)
        let mapItem = MKMapItem(placemark: placemark)
        
        //起動オプション
        let option:[String:AnyObject] = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving as AnyObject, //車で移動
            MKLaunchOptionsMapTypeKey : MKMapType.hybrid.rawValue as AnyObject]  //地図表示はハイブリッド
        
        //マップアプリを起動する。
        mapItem.openInMaps(launchOptions: option)
    }
}
