

//
//  PhotoCommentViewController.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/10/08.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import UIKit

class PhotoCommentViewController: UIViewController ,UITextViewDelegate{

    
    //[ユーザのメニュー追加],[企業のメニュー追加],[口コミの追加]
    var cameratarget = ""
    //[外観][メインメニュー][サイドメニュー][ドリンク]
    var companyphoto = ""
    //[店の名前]
    var userphoto = ""
    
    let textfield = PlaceHolderTextView.init(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
    
    //渡されてくる値
    var searchstore = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textfield.delegate = self
        
        view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6)
        addview()
    }
    
    func addview(){
        backview()
        lineview()
        valuelabel()
        yenlabel()
        valuetextfield()
        addButton()
        backButton()
    }
    
    func backview(){
        let backview = UIView()
        backview.backgroundColor = .white
        backview.frame = CGRect(x: 6, y: 269, width: 363, height: 290)
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
        textfield.frame = CGRect(x: 32, y: 320, width: 328, height: 240)
        textfield.placeHolder = "口コミを書く"
        textfield.font = UIFont.init(name: "HelveticaNeue-Light", size: 16)!
        textfield.textAlignment  = .left
        textfield.center.x = view.center.x
        view.addSubview(textfield)
    }
    
    func valuelabel(){
        let label = UILabel()
        label.frame = CGRect(x: 136, y: 285, width: 0, height: 0)
        label.text = "口コミを書く"
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
        }else{
            _ = SweetAlert().showAlert("写真を保存しました", subTitle: "店名:\(searchstore)", style: AlertStyle.success)
        }
        self.dismiss(animated: true, completion: nil)
    }
    @objc func back(){
        self.dismiss(animated: true, completion: nil)
    }
}
extension PhotoCommentViewController{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textfield.resignFirstResponder()
    }
}
