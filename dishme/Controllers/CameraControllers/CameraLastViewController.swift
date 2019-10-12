

//
//  CameraLastViewController.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/09/20.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import UIKit

class CameraLastViewController: UIViewController {
    
    //サインイン(企業orユーザ)
    var acountResister = "企業"
    
    //[ユーザのメニュー追加],[企業のメニュー追加],[口コミの追加]
    var cameratarget = ""
    //[外観][メインメニュー][サイドメニュー][ドリンク]
    var companyphoto = ""
    //[店の名前]
    var userphoto = ""
    
    let textfield = CustomTextField()
    
    var alerttitle = ""
    
    //渡されてくる値
    var searchstore = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textfield.delegate = self

       view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        if alerttitle == "品名を決める"{
            moneydicide()
        }
        else if alerttitle == "価格を決める"{
            dishnamedicide()
        }
    }
    
    //価格を決める
    func moneydicide(){
        backview()
        lineview()
        valuelabel()
        valuetextfield()
        addButton()
        backButton()
        
        textfield.frame = CGRect(x: 56, y: 414, width: 290, height: 42)
        textfield.center.x = view.center.x
        textfield.keyboardType = .default
        textfield.font = UIFont.init(name: "HelveticaNeue-Light", size: 20)!
    }
    //品名を決める
    func dishnamedicide(){
        backview()
        lineview()
        valuelabel()
        yenlabel()
        valuetextfield()
        addButton()
        backButton()
        textfield.center.x = view.center.x
        textfield.keyboardType = .numberPad
    }
    
    func backview(){
        let backview = UIView()
        backview.backgroundColor = .white
        backview.frame = CGRect(x: 6, y: 265, width: 363, height: 224)
        backview.layer.masksToBounds = true
        backview.layer.cornerRadius = 10
        view.addSubview(backview)
    }
    
    func lineview(){
        let lineview = UIView()
        lineview.frame = CGRect(x: 6.5, y: 317, width: 363, height: 1)
        lineview.backgroundColor = UIColor.init(red: 75/255, green: 149/255, blue: 233/255, alpha: 1)
        view.addSubview(lineview)
    }
    
    func valuetextfield(){
        textfield.frame = CGRect(x: 56, y: 414, width: 226, height: 42)
        textfield.font = UIFont.init(name: "HelveticaNeue-Light", size: 41)!
        textfield.textAlignment  = .center
        textfield.center.x = view.center.x
        view.addSubview(textfield)
    }
    
    func valuelabel(){
        let label = UILabel()
        label.frame = CGRect(x: 136, y: 285, width: 0, height: 0)
        label.text = alerttitle
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 17)!
        label.sizeToFit()
        label.textAlignment = .center
        label.center.x = view.center.x
        view.addSubview(label)
        
    }
    
    func yenlabel(){
        let label = UILabel()
        label.frame = CGRect(x: 320, y: 410, width: 0, height: 0)
        label.text = "¥"
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 41)!
        label.sizeToFit()
        label.textAlignment = .center
        view.addSubview(label)
        
    }
    func backButton(){
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(back), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 19,
                              y: 284,
                              width: 20,
                              height: 20);
        button.setImage(UIImage(named: "backbutton"), for: UIControl.State())
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.addSubview(button)
    }
    
    func addButton(){
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(segue), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 316,
                              y: 284,
                              width: 34,
                              height: 17);
        button.titleLabel?.font = UIFont.init(name: "HelveticaNeue-Bold", size: 17)!
        button.setTitle("決定", for: UIControl.State.normal)
        button.setTitleColor(UIColor.init(red: 75/255, green: 149/255, blue: 233/255, alpha: 1), for: UIControl.State.normal)
        view.addSubview(button)
    }
    
    @objc func segue(){
        if textfield.text == ""{
            _ = SweetAlert().showAlert("値段を設定してください", subTitle: "値段を決めないと追加できません", style: AlertStyle.error)
            self.dismiss(animated: true, completion: nil)
        }else{
            _ = SweetAlert().showAlert("写真を保存しました", subTitle: "店名:\(searchstore)", style: AlertStyle.success)
            self.dismiss(animated: true, completion: nil)
        }
    }
    @objc func back(){
        self.dismiss(animated: true, completion: nil)
    }

}
extension CameraLastViewController{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 入力を反映させたテキストを取得する
        let resultText: String = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if resultText.count <= 15 && alerttitle == "品名を決める"{
            return true
        }
        else if resultText.count <= 6{
            return true
        }
        return false
    }
}

class CustomTextField: UITextField {
    override open var bounds: CGRect {
        didSet {
            updateBorder()
        }
    }
    
    private let borderLayer = CALayer()
    
    override func draw(_ rect: CGRect) {
        updateBorder()
        self.layer.addSublayer(borderLayer)
    }
    
    func updateBorder () {
        borderLayer.backgroundColor = UIColor.black.cgColor
        borderLayer.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: 1)
    }
}


extension CameraLastViewController :UITextFieldDelegate{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textfield.resignFirstResponder()
    }
}
