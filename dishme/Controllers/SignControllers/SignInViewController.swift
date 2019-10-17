

//
//  SignInViewController.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/09/23.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    //メニューのページ
    var pageMenu: PageMenuViewinit!
    var backview = UIView()
    
    //signinのtextfield
    let signin_email_textfield = UITextField()
    let signin_password_textfield = UITextField()
    
    //signupのtextfield
    let signup_name_textfield = UITextField()
    let signup_email_textfield = UITextField()
    let signup_password_textfield = UITextField()
    //companyのtextfield
    let company_name_textfield = UITextField()
    let company_email_textfield = UITextField()
    let company_password_textfield = UITextField()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        backView()
        pagesettings()
        comeagainLabel()
        setupNavigation()
        
        view.backgroundColor = UIColor.init(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
    }

}

extension SignInViewController{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        signin_email_textfield.resignFirstResponder()
        signin_email_textfield.text = signin_email_textfield.text
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        signin_email_textfield.text = signin_password_textfield.text
        self.view.endEditing(true)
    }
}
extension SignInViewController{
    func setupNavigation(){
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
}

extension SignInViewController{
    
    func backView(){
        backview.frame = CGRect(x: 0, y: 132, width: 375, height: 657)
        backview.backgroundColor = UIColor.init(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        view.addSubview(backview)
    }
}


//メニューのレイアウト
extension SignInViewController:PageMenuViewDelegateinit{
    func willMoveToPage(_ pageMenu: PageMenuViewinit, from viewController: UIViewController, index currentViewControllerIndex: Int) {
        print("---------")
        print(viewController.title!)
    }
    
    func didMoveToPage(_ pageMenu: PageMenuViewinit, to viewController: UIViewController, index currentViewControllerIndex: Int) {
        print(viewController.title!)
    }
    
    func pagesettings(){
        // Init View Contollers
        let viewController1 = UIViewController()
        viewController1.view.backgroundColor = UIColor.init(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        viewController1.title = "Sign in"
        
        let viewController2 = UIViewController()
        viewController2.view.backgroundColor = UIColor.init(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        viewController2.title = "Sign up"
        
        let viewController3 = UIViewController()
        viewController3.view.backgroundColor = UIColor.init(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        viewController3.title = "Company"
        
        
        // Add to array
        let viewControllers = [viewController1, viewController2 ,viewController3]
        
        //メニュー写真の追加
        view1settings(controller: viewController1)
        view2settings(controller: viewController2)
        view3settings(controller: viewController3)
        
        
        
        
        // Init Page Menu with view controllers and UI option
        pageMenu = PageMenuViewinit(viewControllers: viewControllers, option: optionview())
        pageMenu.delegate = self
        backview.addSubview(pageMenu)
    }
    
    func optionview() ->PageMenuOption{
        // Page menu UI option
        var option = PageMenuOption(frame: CGRect(
            x: 0, y: 20, width: view.frame.size.width, height: view.frame.size.height - 20))
        
        // Page menu UI option
        option = PageMenuOption(
            frame: CGRect(x: 0, y: 20, width: view.frame.size.width, height: view.frame.size.height - 100))
        option.menuItemWidth = view.frame.size.width / 3
        option.menuTitleMargin = 0
        
        // Page menu UI option
        option = PageMenuOption(frame: CGRect(
            x: 0, y: 20, width: view.frame.size.width, height: view.frame.size.height - 20))
        option.menuItemWidth = view.frame.size.width / 3
        //ここ
        
        option.menuItemBackgroundColorNormal = UIColor.init(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        option.menuItemBackgroundColorSelected = UIColor.init(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        option.menuTitleMargin = 0
        option.menuTitleColorNormal = .black
        option.menuTitleFont = UIFont.init(name: "HelveticaNeue-Bold", size: 15)!
        option.menuTitleColorSelected = .black
        option.menuIndicatorHeight = 3
        option.menuIndicatorColor = UIColor.init(red: 55/255, green: 151/255, blue: 240/255, alpha: 1)
        
        return option
    }
    
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if UIDevice.current.orientation == .portrait {
            pageMenu.frame = CGRect(
                x: 0, y: 20, width: view.frame.size.width, height: view.frame.size.height - 100)
        } else {
            pageMenu.frame = CGRect(
                x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        }
    }
    
    func comeagainLabel(){
        let label = UILabel()
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        //        label.frame =  CGRect(x: 48, y: 84, width: 0, height: 0)
        label.frame = CGRect(x: 0, y: height/9.2, width: width , height: height/27)
        label.textAlignment = NSTextAlignment.center
        label.text = "WELLCOME TO DISHME"
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: width/16.3)
        //        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        view.addSubview(label)
    }
    //    height = 812 width = 375
    func view1settings(controller: UIViewController){
        emailtextfield(controller: controller)
        passwordtextfield(controller: controller)
        SignInButton(controller: controller)
    }
    func emailtextfield(controller: UIViewController){
        //メール
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        //            textfield.frame = CGRect(x: 62, y: 116, width: 250, height: 50)
        signin_email_textfield.frame = CGRect(x: 0, y: height/7, width: width/1.5, height: height/16.24)
        signin_email_textfield.center.x = view.center.x
        signin_email_textfield.textAlignment = NSTextAlignment.left
        signin_email_textfield.font = UIFont.systemFont(ofSize: width/22)
        signin_email_textfield.placeholder = "Email"
        signin_email_textfield.addBorderBottom(height: 1.0, color: UIColor.lightGray)
        controller.view.addSubview(signin_email_textfield)
    }
    func passwordtextfield(controller: UIViewController){
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        //            textfield.frame = CGRect(x: 62, y: 205, width: 250, height: 50)
        signin_password_textfield.frame = CGRect(x: 0, y: height/3.96, width: width/1.5, height: height/16.24)
        signin_password_textfield.center.x = view.center.x
        signin_password_textfield.textAlignment = NSTextAlignment.left
        signin_password_textfield.font = UIFont.systemFont(ofSize: width/22)
        signin_password_textfield.placeholder = "Password"
        signin_password_textfield.addBorderBottom(height: 1.0, color: UIColor.lightGray)
        controller.view.addSubview(signin_password_textfield)
    }
    
    //ログイン
    func SignInButton(controller: UIViewController){
        // UIButtonのインスタンスを作成する
        let button = UIButton(type: .custom)
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        button.addTarget(self, action: #selector(toyouserAcount), for: UIControl.Event.touchUpInside)
        //            button.frame = CGRect(x: 96,
        //                                  y: 401,
        //                                  width: 183,
        //                                  height: 39)
        button.frame = CGRect(x: 0, y: height/2.02, width: width/2.04, height: width/9.6)
        button.center.x = view.center.x
        button.setImage(UIImage(named: "signinbar"), for: UIControl.State())
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        controller.view.addSubview(button)
    }
    
}

//signUPの設定
extension SignInViewController{
    func view2settings(controller: UIViewController){
        nametextfield(controller: controller)
        emailtextfield_view2(controller: controller)
        passwordtextfield_view2(controller: controller)
        acountbutton_view2(controller: controller)
        SignInButton_view2(controller: controller)
    }
    
    func nametextfield(controller: UIViewController){
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        signup_name_textfield.frame = CGRect(x: 0, y: height/6.9, width: width/1.5, height: height/16.24)
        signup_name_textfield.textAlignment = NSTextAlignment.left
        signup_name_textfield.center.x = view.center.x
        signup_name_textfield.font = UIFont.systemFont(ofSize: width/22)
        signup_name_textfield.placeholder = "name"
        signup_name_textfield.addBorderBottom(height: 1.0, color: UIColor.lightGray)
        controller.view.addSubview(signup_name_textfield)
    }
    func emailtextfield_view2(controller: UIViewController){
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height

        signup_email_textfield.frame = CGRect(x: 0, y: height/3.84, width: width/1.5, height: height/16.24)
        signup_email_textfield.textAlignment = NSTextAlignment.left
        signup_email_textfield.center.x = view.center.x
        signup_email_textfield.font = UIFont.systemFont(ofSize: width/22)
        signup_email_textfield.placeholder = "Email"
        signup_email_textfield.addBorderBottom(height: 1.0, color: UIColor.lightGray)
        controller.view.addSubview(signup_email_textfield)
    }
    func passwordtextfield_view2(controller: UIViewController){
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height

        signup_password_textfield.frame = CGRect(x: 0, y: height/2.94, width: width/1.5, height: height/16.24)
        signup_password_textfield.textAlignment = NSTextAlignment.left
        signup_password_textfield.center.x = view.center.x
        signup_password_textfield.font = UIFont.systemFont(ofSize: width/22)
        signup_password_textfield.placeholder = "Password"
        signup_password_textfield.addBorderBottom(height: 1.0, color: UIColor.lightGray)
        controller.view.addSubview(signup_password_textfield)
    }
    
    func acountbutton_view2(controller: UIViewController){
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(acountimage), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 0, y: height/20.24, width: width/6.35, height: width/6.35)
        button.center.x = view.center.x
        button.setImage(UIImage(named: "acount0"), for: UIControl.State())
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        controller.view.addSubview(button)
    }
    
    //新規サインイン
    func SignInButton_view2(controller: UIViewController){
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(toyouserAcount), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 0, y: height/2.13, width: width/2.05, height: width/9.6)
        button.center.x = view.center.x
        button.setImage(UIImage(named: "signupbar"), for: UIControl.State())
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        controller.view.addSubview(button)
    }
}

//    height = 812 width = 375
//会社の登録
extension SignInViewController{
    func view3settings(controller: UIViewController){
        nametextfield_view3(controller: controller)
        emailtextfield_view3(controller: controller)
        passwordtextfield_view3(controller: controller)
        acountbutton_view3(controller: controller)
        SignInButton_view3(controller: controller)
    }
    
    func nametextfield_view3(controller: UIViewController){
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        //        textfield.frame = CGRect(x: 62, y: 117, width: 250, height: 50)
        company_name_textfield.frame = CGRect(x: 0, y: height/4.9, width: width/1.5, height: height/23.09)
        company_name_textfield.textAlignment = NSTextAlignment.left
        company_name_textfield.center.x = view.center.x
        company_name_textfield.font = UIFont.systemFont(ofSize: width/22)
        company_name_textfield.placeholder = "CompanyName"
        company_name_textfield.addBorderBottom(height: 1.0, color: UIColor.lightGray)
        controller.view.addSubview(company_name_textfield)
    }
    func emailtextfield_view3(controller: UIViewController){
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        //        textfield.frame = CGRect(x: 62, y: 211, width: 250, height: 50)
        company_email_textfield.frame = CGRect(x: 0, y: height/3.85, width: width/1.5, height: height/23.09)
        company_email_textfield.textAlignment = NSTextAlignment.left
        company_email_textfield.center.x = view.center.x
        company_email_textfield.font = UIFont.systemFont(ofSize: width/22)
        company_email_textfield.placeholder = "CompanyEmail"
        company_email_textfield.addBorderBottom(height: 1.0, color: UIColor.lightGray)
        controller.view.addSubview(company_email_textfield)
    }
    func passwordtextfield_view3(controller: UIViewController){
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        //        textfield.frame = CGRect(x: 62, y: 276, width: 250, height: 50)
        company_password_textfield.frame = CGRect(x: 0, y: height/2.64, width: width/1.5, height: height/23.09)
        company_password_textfield.textAlignment = NSTextAlignment.left
        company_password_textfield.center.x = view.center.x
        company_password_textfield.font = UIFont.systemFont(ofSize: width/22)
        company_password_textfield.placeholder = "CompanyPassword"
        company_password_textfield.addBorderBottom(height: 1.0, color: UIColor.lightGray)
        controller.view.addSubview(company_password_textfield)
    }
    
    func acountbutton_view3(controller: UIViewController){
        // UIButtonのインスタンスを作成する
        let button = UIButton(type: .custom)
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        button.addTarget(self, action: #selector(acountimage), for: UIControl.Event.touchUpInside)
        //        button.frame = CGRect(x: 154,
        //                              y: 50,
        //                              width: 70,
        //                              height: 70);
        button.frame = CGRect(x: 0, y: height/20.24, width: width/6.35, height: width/6.35)
        button.center.x = view.center.x
        button.setImage(UIImage(named: "acount0"), for: UIControl.State())
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        controller.view.addSubview(button)
    }
    
    func SignInButton_view3(controller: UIViewController){
        // UIButtonのインスタンスを作成する
        let button = UIButton(type: .custom)
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        button.addTarget(self, action: #selector(toAcount), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 0, y: height/2.02, width: width/2.05, height: width/9.6)
        button.center.x = view.center.x
        button.setImage(UIImage(named: "signupbar"), for: UIControl.State())
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        controller.view.addSubview(button)
    }
    
    //ユーザアカウントに飛ぶ画面遷移
    @objc func toyouserAcount(){
        self.performSegue(withIdentifier: "toYouserAcount", sender: nil)
    }
    
    //企業側にログイン
    @objc func toAcount(){
        performSegue(withIdentifier: "toAcount", sender: nil)
    }
    
    @objc func acountimage(){
        
    }

    
}
