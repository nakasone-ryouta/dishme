

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
        else if alerttitle == "カテゴリを決める"{
            categorydicide()
        }
    }
//    width = 375 height = 812
    //価格を決める
    func moneydicide(){
        let width = view.frame.size.width
        let height = view.frame.size.height
        backview()
        lineview()
        valuelabel()
        valuetextfield()
        addButton()
        backButton()
        
        textfield.frame = CGRect(x: width / 6.69, y: height/1.96, width: width/1.29, height: height/19.3)
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
    //カテゴリを決める
    func categorydicide(){
        categorybackview()
        lineview()
        favoritebutton()
        valuelabel()
        backButton()
        appearanceButton()
        menubutton()
    }
    
    func backview(){
        let backview = UIView()
        let width = view.frame.size.width
        let height = view.frame.size.height
        backview.backgroundColor = .white
        backview.frame = CGRect(x: width / 62.5, y: height / 3.06, width: width / 1.03, height: height / 3.625)
        backview.layer.masksToBounds = true
        backview.layer.cornerRadius = 10
        view.addSubview(backview)
    }
    
    func lineview(){
        let lineview = UIView()
        let width = view.frame.size.width
        let height = view.frame.size.height
        lineview.frame = CGRect(x: width / 62.5, y: height / 2.56, width: width / 1.03, height: 1)
        lineview.backgroundColor = UIColor.init(red: 75/255, green: 149/255, blue: 233/255, alpha: 1)
        view.addSubview(lineview)
    }
    
    func valuetextfield(){
        let width = view.frame.size.width
        let height = view.frame.size.height
        textfield.frame = CGRect(x: width / 6.6, y: height / 1.96, width: width / 1.65, height: height / 19.3)
        textfield.font = UIFont.init(name: "HelveticaNeue-Light", size: 41)!
        textfield.textAlignment  = .center
        textfield.center.x = view.center.x
        view.addSubview(textfield)
    }
    
    func valuelabel(){
        let label = UILabel()
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        label.frame = CGRect(x: width / 2.757, y: height / 2.84, width: 0, height: 0)
        label.text = alerttitle
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: width / 22.05)!
        label.sizeToFit()
        label.textAlignment = .center
        label.center.x = view.center.x
        view.addSubview(label)
        
    }
    
    func yenlabel(){
        let label = UILabel()
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        label.frame = CGRect(x: width / 1.17, y: height / 1.98, width: 0, height: 0)
        label.text = "¥"
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: width / 9.14)!
        label.sizeToFit()
        label.textAlignment = .center
        view.addSubview(label)
        
    }
    func backButton(){
        let button = UIButton(type: .custom)
        let width = view.frame.size.width
        let height = view.frame.size.height
        button.addTarget(self, action: #selector(back), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: width / 19.73,
                              y: height / 2.859,
                              width: width / 18.75,
                              height: width / 18.75);
        button.setImage(UIImage(named: "backbutton"), for: UIControl.State())
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.addSubview(button)
    }
    
    func addButton(){
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(segue), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: width / 1.20,
                              y: height / 2.869,
                              width: width / 11.0,
                              height: height / 44.76);
        button.titleLabel?.font = UIFont.init(name: "HelveticaNeue-Bold", size: width / 22.05)!
        button.setTitle("決定", for: UIControl.State.normal)
        button.titleLabel?.sizeToFit()
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

//カテゴリを決めるアラート
extension CameraLastViewController{
    func categorybackview(){
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        let backview = UIView()
        backview.backgroundColor = .white
        backview.frame = CGRect(x: width / 62.5, y: height / 3.06, width: width / 1.03, height: height / 2.46)
        backview.layer.masksToBounds = true
        backview.layer.cornerRadius = 10
        view.addSubview(backview)
    }
    func favoritebutton(){
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        let button = UIButton(type: UIButton.ButtonType.system)
        
        button.setTitle("おすすめ", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.init(name: "HelveticaNeue-Bold", size: 16)!
        button.sizeToFit()
        button.center = self.view.center
        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button.frame = CGRect(x: width / 11.36, y: height / 1.62, width: width / 1.25, height: height / 16.24)
        button.layer.position = CGPoint(x: self.view.frame.width/2, y:height / 2.19)
        button.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        button.layer.cornerRadius = 10
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.addTarget(self, action: #selector(categoryaction), for: UIControl.Event.touchUpInside)
        self.view.addSubview(button)
    }
    func menubutton(){
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        let button = UIButton(type: UIButton.ButtonType.system)
        
        button.setTitle("メニュー", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.init(name: "HelveticaNeue-Bold", size: 16)!
        button.sizeToFit()
        button.center = self.view.center
        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button.frame = CGRect(x: width / 11.36, y: height / 1.62, width: width / 1.25, height: height / 16.24)
        button.layer.position = CGPoint(x: self.view.frame.width/2, y:height / 1.8)
        button.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        button.layer.cornerRadius = 10
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.addTarget(self, action: #selector(categoryaction), for: UIControl.Event.touchUpInside)
        self.view.addSubview(button)
        
    }
    func appearanceButton(){
        let width = view.frame.size.width
        let height  = view.frame.size.height
        
        let button = UIButton(type: UIButton.ButtonType.system)
        
        button.setTitle("雰囲気", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.init(name: "HelveticaNeue-Bold", size: 16)!
        button.sizeToFit()
        button.center = self.view.center
        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button.frame = CGRect(x: width / 11.36, y: height / 1.62, width: width / 1.25, height: height / 16.24)
        button.layer.position = CGPoint(x: width / 2, y: height / 1.53)
        button.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        button.layer.cornerRadius = 10
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.addTarget(self, action: #selector(categoryaction), for: UIControl.Event.touchUpInside)
        self.view.addSubview(button)
        
    }
    @objc func categoryaction(){
        dismiss(animated: true, completion: nil)
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
