

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
    
    var selectedTextField:UITextField?
    
    //テキスト被らないためのview
    var scrollView =  UIScrollView()
    var scrollView2 = UIScrollView()
    var scrollView3 = UIScrollView()
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
        textFieldInit()
        backView()
        pagesettings()
        comeagainLabel()
        setupNavigation()
        
        view.backgroundColor = UIColor.init(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
    }
    override func viewWillAppear(_ animated: Bool) {
        // キーボードイベントの監視開始
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillBeShown(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
    }

}

//textfieldの基本設定
extension SignInViewController{
    
    //textfieldの代入
    func textFieldInit() {
        // textfieldの条件わけ
        self.selectedTextField = self.signup_password_textfield
        
    }
    
    // TextFieldが選択された時
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // 選択されているTextFieldを更新
        self.selectedTextField = textField
        print("aaaaa")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        signin_email_textfield.resignFirstResponder()
        
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        signin_email_textfield.text = signin_password_textfield.text
        self.view.endEditing(true)
    }
}

//textfieldスクロールviewの基本設定
extension SignInViewController{

    func restoreScrollViewSize() {
        // キーボードが閉じられた時に、スクロールした分を戻す
        self.scrollView.contentInset = UIEdgeInsets.zero
        self.scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
        
        self.scrollView2.contentInset = UIEdgeInsets.zero
        self.scrollView2.scrollIndicatorInsets = UIEdgeInsets.zero
        
        self.scrollView3.contentInset = UIEdgeInsets.zero
        self.scrollView3.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    
    
    // キーボードが表示された時に呼ばれる
    @objc func keyboardWillBeShown(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue, let animationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue {
                restoreScrollViewSize()
                
                //textfieldが被ったら位置を再配置
                let convertedKeyboardFrame = scrollView2.convert(keyboardFrame, from: nil)
                positionTextField(selectedTextField: selectedTextField!, keyframe: convertedKeyboardFrame, animate: animationDuration)
            }
        }
    }
    //positionを配置する処理
    func positionTextField(selectedTextField: UITextField ,keyframe: CGRect ,animate: TimeInterval){
        let offsetY: CGFloat = self.selectedTextField!.frame.maxY - keyframe.minY + 40
        if offsetY < 0 { return }
        updateScrollViewSize(moveSize: offsetY, duration: animate)
        restoreScrollViewSize()
    }
    
    // moveSize分Y方向にスクロールさせる
    func updateScrollViewSize(moveSize: CGFloat, duration: TimeInterval) {
        UIView.beginAnimations("ResizeForKeyboard", context: nil)
        UIView.setAnimationDuration(duration)
        
        
        //scrollviewの条件わけ
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: moveSize, right: 0)
        
        //sininの場合
        if selectedTextField == signin_password_textfield || selectedTextField == signin_email_textfield{
            scrollposition(moveSize: Int(moveSize), selectscrollView: scrollView, contentInsets: contentInsets)
        }
        else if selectedTextField == signup_password_textfield || selectedTextField == signup_email_textfield || selectedTextField == signup_name_textfield{
            scrollposition(moveSize: Int(moveSize), selectscrollView: scrollView2, contentInsets: contentInsets)
        }
        else{
            scrollposition(moveSize: Int(moveSize), selectscrollView: scrollView3, contentInsets: contentInsets)
        }
    }
    //scrollviewの条件わけ
    func scrollposition(moveSize: Int,selectscrollView: UIScrollView, contentInsets: UIEdgeInsets){
        selectscrollView.contentInset = contentInsets
        selectscrollView.scrollIndicatorInsets = contentInsets
        selectscrollView.contentOffset = CGPoint(x: 0, y: moveSize)
        
        UIView.commitAnimations()
    }
}

//navigation周り
extension SignInViewController{
    func setupNavigation(){
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
}


//pageviewの下に引いているview
extension SignInViewController{
    
    func backView(){
        backview.frame = CGRect(x: 0, y: 132, width: 375, height: 657)
        backview.backgroundColor = UIColor.init(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        view.addSubview(backview)
    }
    
    func scrollview1(controller: UIViewController){
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        scrollView.frame = self.view.frame
        scrollView.contentSize = CGSize(width:width, height:height * 2)
        controller.view.addSubview(scrollView)
    }
    func scrollview2(controller: UIViewController){
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        scrollView2.frame = self.view.frame
        scrollView2.contentSize = CGSize(width:width, height:height * 2)
        controller.view.addSubview(scrollView2)
    }
    func scrollview3(controller: UIViewController){
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        scrollView3.frame = self.view.frame
        scrollView3.contentSize = CGSize(width:width, height:height * 2)
        controller.view.addSubview(scrollView3)
    }
}


//pageview周り
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
        
        //backviewの上に引いているscrollview
        scrollview1(controller: viewController1)
        scrollview2(controller: viewController2)
        scrollview3(controller: viewController3)
        
        //各部品の配置
        view1settings()
        view2settings()
        view3settings()

        
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
    
    
}
//サインインの設定
extension SignInViewController{
    
    func view1settings(){
        emailtextfield()
        passwordtextfield()
        SignInButton()
    }
    
    func comeagainLabel(){
        let label = UILabel()
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        label.frame = CGRect(x: 0, y: height/9.2, width: width , height: height/27)
        label.textAlignment = NSTextAlignment.center
        label.text = "WELLCOME TO DISHME"
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: width/16.3)
        label.adjustsFontSizeToFitWidth = true
        view.addSubview(label)
    }
    
    func emailtextfield(){
        //メール
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        //            textfield.frame = CGRect(x: 62, y: 116, width: 250, height: 50)
        signin_email_textfield.frame = CGRect(x: 0, y: height / 7, width: width/1.5, height: height/16.24)
        signin_email_textfield.center.x = view.center.x
        signin_email_textfield.textAlignment = NSTextAlignment.left
        signin_email_textfield.font = UIFont.systemFont(ofSize: width/22)
        signin_email_textfield.placeholder = "Email"
        signin_email_textfield.addBorderBottom(height: 1.0, color: UIColor.lightGray)
        scrollView.addSubview(signin_email_textfield)
    }
    
    func passwordtextfield(){
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        signin_password_textfield.frame = CGRect(x: 0, y: height/3.96, width: width/1.5, height: height/16.24)
        signin_password_textfield.center.x = view.center.x
        signin_password_textfield.textAlignment = NSTextAlignment.left
        signin_password_textfield.font = UIFont.systemFont(ofSize: width/22)
        signin_password_textfield.placeholder = "Password"
        signin_password_textfield.addBorderBottom(height: 1.0, color: UIColor.lightGray)
        scrollView.addSubview(signin_password_textfield)
    }
    
    //ログインボタン
    func SignInButton(){
        // UIButtonのインスタンスを作成する
        let button = UIButton(type: .custom)
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        button.addTarget(self, action: #selector(toyouserAcount), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 0, y: height/2.02, width: width/2.04, height: width/9.6)
        button.center.x = view.center.x
        button.setImage(UIImage(named: "signinbar"), for: UIControl.State())
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        scrollView.addSubview(button)
    }
}

//サインアップの設定
extension SignInViewController{
    func view2settings(){
        nametextfield()
        emailtextfield_view2()
        passwordtextfield_view2()
        acountbutton_view2()
        SignInButton_view2()
    }
    
    func nametextfield(){
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        signup_name_textfield.frame = CGRect(x: 0, y: height/6.9, width: width/1.5, height: height/16.24)
        signup_name_textfield.textAlignment = NSTextAlignment.left
        signup_name_textfield.center.x = view.center.x
        signup_name_textfield.font = UIFont.systemFont(ofSize: width/22)
        signup_name_textfield.placeholder = "name"
        signup_name_textfield.addBorderBottom(height: 1.0, color: UIColor.lightGray)
        scrollView2.addSubview(signup_name_textfield)
    }
    func emailtextfield_view2(){
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height

        signup_email_textfield.frame = CGRect(x: 0, y: height/3.84, width: width/1.5, height: height/16.24)
        signup_email_textfield.textAlignment = NSTextAlignment.left
        signup_email_textfield.center.x = view.center.x
        signup_email_textfield.font = UIFont.systemFont(ofSize: width/22)
        signup_email_textfield.placeholder = "Email"
        signup_email_textfield.addBorderBottom(height: 1.0, color: UIColor.lightGray)
        scrollView2.addSubview(signup_email_textfield)
    }
    func passwordtextfield_view2(){
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height

        signup_password_textfield.frame = CGRect(x: 0, y: height/2.94, width: width/1.5, height: height/16.24)
        signup_password_textfield.textAlignment = NSTextAlignment.left
        signup_password_textfield.center.x = view.center.x
        signup_password_textfield.font = UIFont.systemFont(ofSize: width/22)
        signup_password_textfield.placeholder = "Password"
        signup_password_textfield.addBorderBottom(height: 1.0, color: UIColor.lightGray)
        scrollView2.addSubview(signup_password_textfield)
    }
    
    func acountbutton_view2(){
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(acountimage), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 0, y: height/20.24, width: width/6.35, height: width/6.35)
        button.center.x = view.center.x
        button.setImage(UIImage(named: "acount0"), for: UIControl.State())
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        scrollView2.addSubview(button)
    }
    
    //新規サインイン
    func SignInButton_view2(){
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(toyouserAcount), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 0, y: height/2.13, width: width/2.05, height: width/9.6)
        button.center.x = view.center.x
        button.setImage(UIImage(named: "signupbar"), for: UIControl.State())
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        scrollView2.addSubview(button)
    }
}


//会社の登録
extension SignInViewController{
    func view3settings(){
        nametextfield_view3()
        emailtextfield_view3()
        passwordtextfield_view3()
        acountbutton_view3()
        SignInButton_view3()
    }
    
    func nametextfield_view3(){
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        //        textfield.frame = CGRect(x: 62, y: 117, width: 250, height: 50)
        company_name_textfield.frame = CGRect(x: 0, y: height/4.9, width: width/1.5, height: height/23.09)
        company_name_textfield.textAlignment = NSTextAlignment.left
        company_name_textfield.center.x = view.center.x
        company_name_textfield.font = UIFont.systemFont(ofSize: width/22)
        company_name_textfield.placeholder = "CompanyName"
        company_name_textfield.addBorderBottom(height: 1.0, color: UIColor.lightGray)
        scrollView3.addSubview(company_name_textfield)
    }
    func emailtextfield_view3(){
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        //        textfield.frame = CGRect(x: 62, y: 211, width: 250, height: 50)
        company_email_textfield.frame = CGRect(x: 0, y: height/3.85, width: width/1.5, height: height/23.09)
        company_email_textfield.textAlignment = NSTextAlignment.left
        company_email_textfield.center.x = view.center.x
        company_email_textfield.font = UIFont.systemFont(ofSize: width/22)
        company_email_textfield.placeholder = "CompanyEmail"
        company_email_textfield.addBorderBottom(height: 1.0, color: UIColor.lightGray)
        scrollView3.addSubview(company_email_textfield)
    }
    func passwordtextfield_view3(){
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height

        company_password_textfield.frame = CGRect(x: 0, y: height/2.64, width: width/1.5, height: height/23.09)
        company_password_textfield.textAlignment = NSTextAlignment.left
        company_password_textfield.center.x = view.center.x
        company_password_textfield.font = UIFont.systemFont(ofSize: width/22)
        company_password_textfield.placeholder = "CompanyPassword"
        company_password_textfield.addBorderBottom(height: 1.0, color: UIColor.lightGray)
        scrollView3.addSubview(company_password_textfield)
    }
    
    func acountbutton_view3(){
        // UIButtonのインスタンスを作成する
        let button = UIButton(type: .custom)
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        button.addTarget(self, action: #selector(acountimage), for: UIControl.Event.touchUpInside)

        button.frame = CGRect(x: 0, y: height/20.24, width: width/6.35, height: width/6.35)
        button.center.x = view.center.x
        button.setImage(UIImage(named: "acount0"), for: UIControl.State())
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        scrollView3.addSubview(button)
    }
    
    func SignInButton_view3(){
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
        scrollView3.addSubview(button)
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
