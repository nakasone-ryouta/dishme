

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
    var pickerView: UIPickerView = UIPickerView()
    var pickerView_congestion: UIPickerView = UIPickerView()
    
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
    }
    //textの基本設定
    func textfiledsettings(){
        //時間帯
        text_view1.frame = CGRect(x: 0, y: 119, width: 375, height: 50)
        text_view1.textAlignment = .center
        text_view1.font = UIFont.systemFont(ofSize: 17)
        text_view1.placeholder = "時間を決める"
        text_view1.layer.borderColor = UIColor.black.cgColor
        text_view1.layer.borderWidth = 1
        view.addSubview(text_view1)
        
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
            text_view1.keyboardType = UIKeyboardType.numberPad
        case "定休日":
            text_view1.placeholder = "定休日の設定"
        default: break //地図を表示
        }
    }
    
    // ドラムロールの列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    // ドラムロールの行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case pickerView_congestion:
            return selecttime.count
        default:
            return selecttime.count
        }
    }
    
    // ドラムロールの各タイトル
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        switch pickerView {
        case pickerView_congestion:
            return selecttime[row]
        default:
            return selecttime[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    
            totime = selecttime[pickerView.selectedRow(inComponent: 0)]
            fromtime = selecttime[pickerView.selectedRow(inComponent: 1)]
            
            text_view1.text = totime + tofrom + fromtime
    }
}
