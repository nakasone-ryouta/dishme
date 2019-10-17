

//
//  EditSettingViewController.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/09/23.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import UIKit

class EditSettingViewController: UIViewController {
    
    var text_view1 = UITextField()
    var text_view2 = UITextField()
    
    var pickerView: UIPickerView = UIPickerView()
    var pickerView_congestion: UIPickerView = UIPickerView()
    var pickerView_number:UIPickerView = UIPickerView()
    var pickerView_category:UIPickerView = UIPickerView()
    
    //予約OKな日
    let nodate:[String] = ["2019/9/22",
                           "2019/9/23",
                           "2019/9/24",
                           "2019/9/25",
                           ]

    
    let selecttime:[String] = ["1:00",
                               "2:00",
                               "3:00",
                               "4:00",
                               "5:00",
                               "6:00",
                               "7:00",
                               "8:00",
                               "9:00",
                               "10:00",
                               "11:00",
                               "12:00",
                               "13:00",
                               "14:00",
                               "15:00",
                               "16:00",
                               "17:00",
                               "18:00",
                               "19:00",
                               "20:00",
                               "21:00",
                               "22:00",
                               "23:00",
                               "24:00",]
    
    let selectnumber:[String] = ["予約不可","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30"]
    
    var category = ["和食","居酒屋","洋食","イタリアン・フレンチ","焼き鳥・韓国料理","中華","バー","カフェ・スイーツ","ラーメン","アジアン","各国料理","その他",]
    
    var setting = ""
    var fromtime = ""
    var totime = ""
    var sumtime = ""
    var tofrom = "〜"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pickersettings()    //pickerviewの基本設定
        textfiledsettings() //textfiledの基本設定
        
        setupNavigation()
    }

}
//navigation周り
extension EditSettingViewController{
    func setupNavigation(){
        
        // タイトルをセット
        self.navigationItem.title = setting
        
        let selectBtn = UIBarButtonItem(title: "保存", style: .done, target: self, action: #selector(save))
        self.navigationItem.rightBarButtonItems = [selectBtn]
    }
    @objc func save(){
        _ = SweetAlert().showAlert("変更を保存しました", subTitle: "", style: AlertStyle.success)
        self.navigationController?.popViewController(animated: true)
    }
}

//pickerviewの基本設定
extension EditSettingViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    @objc func done(){
        text_view1.resignFirstResponder()
    }
    
    //pickerviewの中のレイアウト
    func setKeyboardAccessory() {
        let keyboardAccessory = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 36))
        keyboardAccessory.backgroundColor = UIColor.white
        text_view1.inputAccessoryView = keyboardAccessory
        
        //pickerviewの一番上の線
        let topBorder = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 0.5))
        topBorder.backgroundColor = UIColor.lightGray
        keyboardAccessory.addSubview(topBorder)
        
        //決定ボタン
        let completeButton = UIButton(frame: CGRect(x: keyboardAccessory.bounds.size.width - 48,
                                                    y: 0,
                                                    width: 48,
                                                    height: keyboardAccessory.bounds.size.height - 0.5 * 2))
        completeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        completeButton.setTitle("決定", for: .normal)
        completeButton.setTitleColor(UIColor.black, for: .normal)
        completeButton.setTitleColor(UIColor.init(red: 3/255, green: 125/255, blue: 201/255, alpha: 1),
                                     for: .highlighted)
        
        completeButton.addTarget(self, action: #selector(done), for: .touchUpInside)
        keyboardAccessory.addSubview(completeButton)
        
        //pickerviewの選ぶところ
        let bottomBorder = UIView(frame: CGRect(x: 0, y: keyboardAccessory.bounds.size.height - 0.5,
                                                width:  keyboardAccessory.bounds.size.width,
                                                height: 0.5))
        bottomBorder.backgroundColor = UIColor.white
        keyboardAccessory.addSubview(bottomBorder)
    }
    
    //pickerviewの基本設定
    func pickersettings(){
        // ピッカー設定
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true
        pickerView.backgroundColor = .white
        
        // ピッカー設定
        pickerView_congestion.delegate = self
        pickerView_congestion.dataSource = self
        pickerView_congestion.showsSelectionIndicator = true
        pickerView_congestion.backgroundColor = .white
        
        // ピッカー設定
        pickerView_number.delegate = self
        pickerView_number.dataSource = self
        pickerView_number.showsSelectionIndicator = true
        pickerView_number.backgroundColor = .white
        
        // ピッカー設定
        pickerView_category.delegate = self
        pickerView_category.dataSource = self
        pickerView_category.showsSelectionIndicator = true
        pickerView_category.backgroundColor = .white
    }
    //textの基本設定
    func textfiledsettings(){
        let width = view.frame.size.width
        let height = view.frame.size.height
        //時間帯
        text_view1.frame = CGRect(x: 0, y: 120, width: width, height: height / 15)
        text_view1.textAlignment = .center
        text_view1.font = UIFont.systemFont(ofSize: 17)
        text_view1.placeholder = "時間を決める"
        text_view1.layer.borderColor = UIColor.black.cgColor
        text_view1.layer.borderWidth = 1
        view.addSubview(text_view1)
        
        //お金の平均
        text_view2.frame = CGRect(x: 0, y: 230, width: width, height: height / 15)
        text_view2.textAlignment = .center
        text_view2.font = UIFont.systemFont(ofSize: 17)
        text_view2.placeholder = "MAXの額"
        text_view2.layer.borderColor = UIColor.black.cgColor
        text_view2.layer.borderWidth = 1
        
        
        switch setting {
        case "営業時間":
            text_view1.placeholder = "営業時間設定"
            text_view1.inputView = pickerView
        case "混雑時間":
            text_view1.placeholder = "混雑時間設定"
            text_view1.inputView = pickerView
        case "電話番号":
            text_view1.placeholder = "電話番号設定"
            text_view1.keyboardType = UIKeyboardType.numberPad
        case "中休み":
            text_view1.placeholder = "中休み設定"
            text_view1.inputView = pickerView
        case "定員人数":
            text_view1.placeholder = "１時間上限人数設定"
            text_view1.inputView = pickerView_number
        case "定休日":
            text_view1.placeholder = "定休日の設定"
        case "平均使用額":
            text_view1.placeholder = "MINの額"
            text_view1.keyboardType = UIKeyboardType.numberPad
            text_view2.keyboardType = UIKeyboardType.numberPad
            view.addSubview(text_view2)
            kara()
        case "お店の料理ジャンル":
            text_view1.placeholder = "料理ジャンルの設定"
            text_view1.inputView = pickerView_category
            
        default: break //地図を表示
        }
    }
    
    // ドラムロールの列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch pickerView {
        case pickerView_number:
            return 1
        case pickerView_category:
            return 1
        default:
            return 2
        }
    }
    
    // ドラムロールの行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
            
        case pickerView_congestion:
            return selecttime.count
            
        case pickerView_number:
            return selectnumber.count
            
        case pickerView_category:
            return category.count
            
        default:
            return selecttime.count
        }
    }
    
    // ドラムロールの各タイトル
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        switch pickerView {
            
        case pickerView_congestion:
            return selecttime[row]
            
        case pickerView_number:
            return selectnumber[row]
        case pickerView_category:
            return category[row]
        default:
            return selecttime[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    
        switch pickerView {
        case pickerView_number:
            return text_view1.text = selectnumber[pickerView.selectedRow(inComponent: 0)]
        case pickerView_category:
            return text_view1.text = category[pickerView.selectedRow(inComponent: 0)]
        default:
            totime = selecttime[pickerView.selectedRow(inComponent: 0)]
            fromtime = selecttime[pickerView.selectedRow(inComponent: 1)]
            text_view1.text = totime + tofrom + fromtime
        }
    }
}


extension EditSettingViewController{
    func kara(){
        let label = UILabel()
        label.frame = CGRect(x: view.frame.size.width / 2, y: 190, width: 50, height: 50)
        label.text = "〜"
        label.center.x = view.center.x
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 20)
        label.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        view.addSubview(label)
    }
}
