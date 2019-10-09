//
//  YouserAcountViewController.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/09/23.
import UIKit
import MessageUI

//下から
enum State {
    case collapsed
    case expanded
}

class YouserAcountViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //=========================================下から=====================================================
    
    var alert = Alert()
    // Constant
    let commentViewHeight: CGFloat = 64.0
    let animatorDuration: TimeInterval = 1
    
    // UI
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var blurEffectView: UIVisualEffectView!
//    @IBOutlet weak var closeButton: UIButton!
//    @IBOutlet weak var backButton: UIButton!
    
    
    var commentView = UIView()
    var commentTitleLabel = UILabel()
    var commentDummyView = UIImageView()
    
    // Tracks all running aninmators
    var progressWhenInterrupted: CGFloat = 0
    var runningAnimators = [UIViewPropertyAnimator]()
    var state: State = .collapsed
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    //=========================================下から=====================================================
    
    //[ユーザのメニュー追加],[企業のメニュー追加],[口コミの追加]
    var cameratarget = "ユーザのメニュー追加"
    
    //次の画面に渡す値
    var firstindex:IndexPath? = nil
    
    var name = "中曽根涼太"
    var point = "¥17200"
    var email = "sone.to.soccer@icloud.com"
    var acountimage = UIImage(named: "acount1")
    var sectionTitle:[String] = ["dishstore","ribface","焼肉大地","焼肉Narasino"]
    var image:[UIImage] = [UIImage(named: "meat1")!,
                           UIImage(named: "meat2")!,
                           UIImage(named: "meat3")!,
                           UIImage(named: "meat4")!,
                           UIImage(named: "meat5")!,
                           UIImage(named: "meat6")!,
                           UIImage(named: "meat7")!,
                           UIImage(named: "meat8")!,
                           UIImage(named: "meat9")!,
                           UIImage(named: "meat5")!,]
    
    var setting:[String] = ["ログアウト","アカウント切り替え","お知らせ","振込口座の変更","写真を非公開にする","問題を管理者に報告"]
    
    
    var myCollectionView : UICollectionView!
    let backview = UIView()
    let acountbackview = UIView()
    //アイコン画像
    let acountimageView = UIImageView()
    
    //[クレジット登録]の文字
    let creditbutton = UIButton(type: UIButton.ButtonType.system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setview()
        
        // CollectionViewのレイアウトを生成.
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:124, height:124)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.headerReferenceSize = CGSize(width:100,height:60)
        
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.sectionInset = UIEdgeInsets.zero
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        // Cellに使われるクラスを登録.
        myCollectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        myCollectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Section")
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        myCollectionView.backgroundColor = .white
        
        self.backview.addSubview(myCollectionView)
        
        setupNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //=========================================下から=====================================================
        view.bringSubviewToFront(blurEffectView)
        self.initSubViews()
        self.addGestures()
        tablesettings()
        //=========================================下から=====================================================
    }
    func setupNavigation(){
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.title = "アカウント"
        self.navigationItem.hidesBackButton = true
        
        let button = UIBarButtonItem(image: UIImage(named: "settingitem")?.withRenderingMode(.alwaysOriginal),
                                     style: .plain,
                                     target: self,
                                     action: #selector(settingaction));
        self.navigationItem.rightBarButtonItem = button
        
        
    }
    @objc func settingaction(){
        //したから設定のviewを出す
        self.animateOrReverseRunningTransition(state: self.nextState(), duration: animatorDuration)
    }
    
    //セクションの数
    internal func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch(section){
        case 0:
            return 5
            
        case 1:
            return 8
            
        case 2:
            return 10
            
        default:
            print("error")
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : PhotosCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath as IndexPath) as! PhotosCollectionViewCell
        
        // Section毎にCellのプロパティを変える.
        switch(indexPath.section){
        case 0:
            cell.backgroundColor = UIColor.red
            cell.textLabel?.text = "0"
            cell.imageView?.image = image[indexPath.row]
            
        case 1:
            cell.backgroundColor = UIColor.white
            cell.textLabel?.text = "1"
            cell.imageView?.image = image[indexPath.row]
            
        case 2:
            cell.backgroundColor = UIColor.blue
            cell.textLabel?.text = "2"
            cell.imageView?.image = image[indexPath.row]
            
        default:
            print("section error")
            cell.backgroundColor = UIColor.white
        }
        
        return cell
    }
    //セクションの高さ
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: self.view.frame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("Num: \(indexPath.row)")
        print("SectionNum:\(indexPath.section)")
        
        firstindex = indexPath
        performSegue(withIdentifier: "toPhotoSelect", sender: nil)
        
    }

    
    //collectionviewレイアウト周り
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let horizontalSpace:CGFloat = 5
        let cellSize:CGFloat = self.view.bounds.width/3 - horizontalSpace
        
        return CGSize(width: cellSize, height: cellSize)
        
    }
    
    
    /*
     Sectionに値を設定する
     */
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {


        var view:SectionHeader?
        view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Section", for: indexPath) as? SectionHeader

        if kind == UICollectionView.elementKindSectionHeader {
            view?.setTitle(title: sectionTitle[indexPath.section])
            view?.button.addTarget(self, action: #selector(menuadd), for: UIControl.Event.touchUpInside)
            return view!
        }

        return UICollectionReusableView()
    }
    
    @objc func menuadd(){
        self.performSegue(withIdentifier: "toCamera", sender: nil)
    }
    
    //画面に渡す値
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCamera" {
            let nextView = segue.destination as! CameraViewController
            nextView.cameratarget = cameratarget
        }
        if segue.identifier == "toPhotoSelect" {
            let nextVC = segue.destination as! PhotoSelectViewController
            nextVC.firstindex = firstindex
        }
    }
    
}


extension YouserAcountViewController{
    func setview(){
        acountbackView()
        backView()
        acountname()
        acountemail()
        acountImage()
        line()
        initpointbutton()
        acountImageChange()
    }
    func acountbackView(){
        acountbackview.frame = CGRect(x: 0, y: 0, width: 375, height: 160)
        acountbackview.backgroundColor = UIColor.init(red: 249/255, green: 247/255, blue: 246/255, alpha: 1)
        view.addSubview(acountbackview)
    }
    func backView(){
        backview.frame = CGRect(x: 0, y: 155, width: 375, height: 577)
        view.addSubview(backview)
    }
    
    func acountname(){
        let label = UILabel()
        label.frame = CGRect(x: 89, y: 94, width: 0, height: 0)
        label.text = name
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 15)
        label.textAlignment = NSTextAlignment.left
        label.sizeToFit()
        view.addSubview(label)
    }
    func acountemail(){
        let label = UILabel()
        label.frame = CGRect(x: 89, y: 126, width: 0, height: 0)
        label.text = email
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 12)
        label.textAlignment = NSTextAlignment.left
        label.sizeToFit()
        view.addSubview(label)
    }
    
    func acountImage(){
        acountimageView.frame = CGRect(x: 15, y: 92, width: 55, height: 55)
        acountimageView.image = acountimage
        acountimageView.circle()
        view.addSubview(acountimageView)
    }
    func acountImageChange(){
        let button = UIButton()
        button.addTarget(self, action: #selector(showAlbum), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 27, y: 92, width: 55, height: 55);
        button.setTitle("", for: .normal) // ボタンのタイトル
        button.titleLabel?.font = UIFont.init(name: "HelveticaNeue-Bold", size: 11)
        button.sizeToFit()
        button.setTitleColor(UIColor.white, for: .normal)
        view.addSubview(button)
    }
    
    func line(){
        let line = UIView()
        line.frame = CGRect(x: 275, y: 82, width: 1, height: 57)
        line.backgroundColor = UIColor.init(red: 226/255, green: 226/255, blue: 226/255, alpha: 1)
        view.addSubview(line)
    }
    
    @objc func pointlabel(){
        let label = UILabel()
        label.frame = CGRect(x: 300, y: 92, width: 0, height: 0)
        label.text = point
        label.textColor = UIColor.init(red: 75/255, green: 149/255, blue: 233/255, alpha: 1)
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 15)
        label.textAlignment = NSTextAlignment.left
        label.sizeToFit()
        view.addSubview(label)
    }
    
    func pointname(){
        // UIButtonのインスタンスを作成する
        let button = UIButton(type: UIButton.ButtonType.system)
        button.frame = CGRect(x: 290, y: 121, width: 0, height: 0)
        button.setTitleColor(UIColor.init(red: 75/255, green: 149/255, blue: 233/255, alpha: 1), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(creditRegister), for: UIControl.Event.touchUpInside)
        button.setTitle("ポイント換金", for: UIControl.State.normal)
        button.titleLabel!.font = UIFont(name: "Helvetica-Bold",size: CGFloat(12))
        button.sizeToFit()
        view.addSubview(button)
    }
    func initpointbutton(){
        // UIButtonのインスタンスを作成する
        creditbutton.frame = CGRect(x: 289, y: 99, width: 0, height: 0)
        creditbutton.setTitleColor(UIColor.init(red: 75/255, green: 149/255, blue: 233/255, alpha: 1), for: UIControl.State.normal)
        creditbutton.addTarget(self, action: #selector(creditRegister), for: UIControl.Event.touchUpInside)
        creditbutton.setTitle("振込口座登録", for: UIControl.State.normal)
        creditbutton.titleLabel!.font = UIFont(name: "Helvetica-Bold",size: CGFloat(12))
        creditbutton.sizeToFit()
        view.addSubview(creditbutton)
    }
    @objc func creditRegister(){
        pointlabel()
        pointname()
        creditbutton.removeFromSuperview()
    }
}

//下から
extension YouserAcountViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tablesettings(){
        let tableView:UITableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = CGRect(x: 0, y: 70, width: 375, height: 500)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Home")
        tableView.contentMode = .scaleAspectFit
        tableView.tableFooterView = UIView(frame: .zero)
        commentView.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setting.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: .value1, reuseIdentifier: "Home")
        cell.textLabel?.text = setting[indexPath.row]
        cell.textLabel?.font = UIFont.init(name: "HelveticaNeue-Thin", size: 15)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("aaaaaaaaa")
        switch indexPath.row {
        //ログアウト
        case 0:
            alert.infoAlert(Title: "ログアウトしますか？", subTitle: "", yes: "はい", no: "いいえ", yesTitle: "ログアウトしました", yessubTitle: "")
            break;
        //アカウント切り替え
        case 1:
            alert.infoAlert(Title: "アカウントを切り替えますか？", subTitle: "現在あなたは企業アカウントです", yes: "はい", no: "いいえ", yesTitle: "アカウントを切り替えました", yessubTitle: "")
            break;
        //お知らせ
        case 2:
            performSegue(withIdentifier: "toNotice", sender: nil)
            break;
        //振込口座の変更
        case 3:
            break;
        //写真の公開非公開
        case 4:
            alert.infoAlert(Title: "写真を非公開にしますか？", subTitle:"非公開にすると収入ははいりません", yes: "はい", no: "いいえ",yesTitle: "写真は非公開になりました", yessubTitle: "")
            break;
        //問題を管理者に報告
        case 5:
            emailbutton()
            break;
            
        default:
            break;
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    private func initSubViews() {
        self.blurEffectView.effect = nil
        
        // Collapsed comment view
        commentView.frame = self.collapsedFrame()
        commentView.backgroundColor = .white
        self.view.addSubview(commentView)
        
        // Title label
        commentTitleLabel.text = "各種設定"
        commentTitleLabel.sizeToFit()
        commentTitleLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
        commentTitleLabel.center = CGPoint(x: self.view.frame.width / 2, y: commentViewHeight / 2)
        commentView.addSubview(commentTitleLabel)
        
        // Dummy view
        commentDummyView.frame = CGRect(
            x: 0.0,
            y: commentViewHeight,
            width: self.view.frame.width,
            height: self.view.frame.height - commentViewHeight - self.headerView.frame.height
        )
        commentDummyView.image = UIImage(named: "comments")
        commentDummyView.contentMode = .scaleAspectFit
        commentView.addSubview(commentDummyView)
    }
    
    private func addGestures() {
        // Tap gesture
//        commentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture(_:))))
        
        // Pan gesutre
        commentView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(_:))))
    }
    
    // MARK: Util
    private func expandedFrame() -> CGRect {
        return CGRect(
            x: 0,
            y: self.headerView.frame.height,
            width: self.view.frame.width,
            height: self.view.frame.height - self.headerView.frame.height
        )
    }
    
    private func collapsedFrame() -> CGRect {
        return CGRect(
            x: 0,
            y: self.view.frame.height - commentViewHeight,
            width: self.view.frame.width,
            height: commentViewHeight)
    }
    
    private func fractionComplete(state: State, translation: CGPoint) -> CGFloat {
        let translationY = state == .expanded ? -translation.y : translation.y
        return translationY / (self.view.frame.height - commentViewHeight - self.headerView.frame.height) + progressWhenInterrupted
    }
    
    private func nextState() -> State {
        switch self.state {
        case .collapsed:
            return .expanded
        case .expanded:
            return .collapsed
        }
    }
    
    // MARK: Gesture
//    @objc private func handleTapGesture(_ recognizer: UITapGestureRecognizer) {
//        self.animateOrReverseRunningTransition(state: self.nextState(), duration: animatorDuration)
//    }
    
    @objc private func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: commentView)
        
        switch recognizer.state {
        case .began:
            self.startInteractiveTransition(state: self.nextState(), duration: animatorDuration)
        case .changed:
            self.updateInteractiveTransition(fractionComplete: self.fractionComplete(state: self.nextState(), translation: translation))
        case .ended:
            self.continueInteractiveTransition(fractionComplete: self.fractionComplete(state: self.nextState(), translation: translation))
        default:
            break
        }
    }
    
    @IBAction func didTapCloseButton(_ sender: UIButton) {
        if self.state == .expanded {
            self.animateOrReverseRunningTransition(state: self.nextState(), duration: animatorDuration)
        }
    }
    // MARK: Animation
    // Frame Animation
    private func addFrameAnimator(state: State, duration: TimeInterval) {
        // Frame Animation
        let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
            switch state {
            case .expanded:
                self.commentView.frame = self.expandedFrame()
            case .collapsed:
                self.commentView.frame = self.collapsedFrame()
            }
        }
        frameAnimator.addCompletion({ (position) in
            switch position {
            case .start:
                // Fix blur animator bug don't know why
                switch self.state {
                case .expanded:
                    self.blurEffectView.effect = UIBlurEffect(style: .dark)
                case .collapsed:
                    self.blurEffectView.effect = nil
                }
            case .end:
                self.state = self.nextState()
            default:
                break
            }
            self.runningAnimators.removeAll()
        })
        runningAnimators.append(frameAnimator)
    }
    
    // Blur Animation
    private func addBlurAnimator(state: State, duration: TimeInterval) {
        var timing: UITimingCurveProvider
        switch state {
        case .expanded:
            timing = UICubicTimingParameters(controlPoint1: CGPoint(x: 0.75, y: 0.1), controlPoint2: CGPoint(x: 0.9, y: 0.25))
        case .collapsed:
            timing = UICubicTimingParameters(controlPoint1: CGPoint(x: 0.1, y: 0.75), controlPoint2: CGPoint(x: 0.25, y: 0.9))
        }
        let blurAnimator = UIViewPropertyAnimator(duration: duration, timingParameters: timing)
        if #available(iOS 11, *) {
            blurAnimator.scrubsLinearly = false
        }
        blurAnimator.addAnimations {
            switch state {
            case .expanded:
                self.blurEffectView.effect = UIBlurEffect(style: .dark)
            case .collapsed:
                self.blurEffectView.effect = nil
            }
        }
        runningAnimators.append(blurAnimator)
    }
    
    // Label Scale Animation
    private func addLabelScaleAnimator(state: State, duration: TimeInterval) {
        let scaleAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
            switch state {
            case .expanded:
                self.commentTitleLabel.transform = CGAffineTransform.identity.scaledBy(x: 1.8, y: 1.8)
            case .collapsed:
                self.commentTitleLabel.transform = CGAffineTransform.identity
            }
        }
        runningAnimators.append(scaleAnimator)
    }
    
    // CornerRadius Animation
    private func addCornerRadiusAnimator(state: State, duration: TimeInterval) {
        commentView.clipsToBounds = true
        // Corner mask
        if #available(iOS 11, *) {
            commentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
            switch state {
            case .expanded:
                self.commentView.layer.cornerRadius = 12
            case .collapsed:
                self.commentView.layer.cornerRadius = 0
            }
        }
        runningAnimators.append(cornerRadiusAnimator)
    }
    
    // KeyFrame Animation
    private func addKeyFrameAnimator(state: State, duration: TimeInterval) {
        let keyFrameAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
            UIView.animateKeyframes(withDuration: 0, delay: 0, options: [], animations: {
                switch state {
                case .expanded:
                    UIView.addKeyframe(withRelativeStartTime: duration / 2, relativeDuration: duration / 2, animations: {
                        self.blurEffectView.effect = UIBlurEffect(style: .dark)
                    })
                case .collapsed:
                    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: duration / 2, animations: {
                        self.blurEffectView.effect = nil
                    })
                }
            }, completion: nil)
        }
        runningAnimators.append(keyFrameAnimator)
    }
    
    // Perform all animations with animators if not already running
    func animateTransitionIfNeeded(state: State, duration: TimeInterval) {
        if runningAnimators.isEmpty {
            self.addFrameAnimator(state: state, duration: duration)
            self.addBlurAnimator(state: state, duration: duration)
            self.addLabelScaleAnimator(state: state, duration: duration)
            self.addCornerRadiusAnimator(state: state, duration: duration)
            self.addKeyFrameAnimator(state: state, duration: duration)
        }
    }
    
    // Starts transition if necessary or reverse it on tap
    func animateOrReverseRunningTransition(state: State, duration: TimeInterval) {
        if runningAnimators.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
            runningAnimators.forEach({ $0.startAnimation() })
        } else {
            runningAnimators.forEach({ $0.isReversed = !$0.isReversed })
        }
    }
    
    // Starts transition if necessary and pauses on pan .began
    func startInteractiveTransition(state: State, duration: TimeInterval) {
        self.animateTransitionIfNeeded(state: state, duration: duration)
        runningAnimators.forEach({ $0.pauseAnimation() })
        progressWhenInterrupted = runningAnimators.first?.fractionComplete ?? 0
    }
    
    // Scrubs transition on pan .changed
    func updateInteractiveTransition(fractionComplete: CGFloat) {
        runningAnimators.forEach({ $0.fractionComplete = fractionComplete })
    }
    
    // Continues or reverse transition on pan .ended
    func continueInteractiveTransition(fractionComplete: CGFloat) {
        let cancel: Bool = fractionComplete < 0.2
        
        if cancel {
            runningAnimators.forEach({
                $0.isReversed = !$0.isReversed
                $0.continueAnimation(withTimingParameters: nil, durationFactor: 0)
            })
            return
        }
        
        let timing = UICubicTimingParameters(animationCurve: .easeOut)
        runningAnimators.forEach({ $0.continueAnimation(withTimingParameters: timing, durationFactor: 0) })
    }
}


//メール
extension YouserAcountViewController:MFMailComposeViewControllerDelegate{
    func emailbutton(){
        let mailComposeViewController = configureMailComposeViewController()
        
        if MFMailComposeViewController.canSendMail(){
            
            self.present(mailComposeViewController, animated: true, completion: nil)
        }else{
            self.showSendMailErrorAlert()
        }
    }
    
    func configureMailComposeViewController() -> MFMailComposeViewController{
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["tsudoi0410@gmail.com"])
        
        mailComposerVC.setSubject("お問い合わせ")
        mailComposerVC.setMessageBody("１．①〜④よりお問い合わせ内容をお選びください。\n①アプリの不具合\n②問題のアカウントを通報する\n③追加してほしい機能\n④その他\n\n2.返信用のメールアドレスを記載してください\n\n3.②をお選びいただいた方は問題のアカウント名と問題行動を記載してください\nお客様入力内容：", isHTML: false)
        
        return mailComposerVC
        
    }
    
    func showSendMailErrorAlert(){
        _ = UIAlertView(title: "送信できませんでした", message: "your device must have an active mail account", delegate: self, cancelButtonTitle: "Ok")
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

//カメラ機能
extension YouserAcountViewController:UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
    
    // アルバムを表示
    @objc func showAlbum() {
        
        let sourceType:UIImagePickerController.SourceType =
            UIImagePickerController.SourceType.photoLibrary
        
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.photoLibrary){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
            print("Tap the [Start] to save a picture")
            
        }
        else{
            print("error")
            
        }
    }
    
    //　撮影が完了時した時に呼ばれる
    func imagePickerController(_ imagePicker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        if let pickedImage = info[.originalImage]
            as? UIImage {
            acountimage = pickedImage
            acountimageView.removeFromSuperview()
            acountimageView.circle()
            acountImage()
            
        }
        //閉じる処理
        imagePicker.dismiss(animated: true, completion: nil)
        print("Tap the [Save] to save a picture")
        
        
    }
    
    // 撮影がキャンセルされた時に呼ばれる
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        print("Canceled")
    }
    
    // 書き込み完了結果の受け取り
    @objc func image(_ image: UIImage,
                     didFinishSavingWithError error: NSError!,
                     contextInfo: UnsafeMutableRawPointer) {
        
        if error != nil {
            print(error.code)
            print("Save Failed !")
        }
        else{
            print("Save Succeeded")
        }
    }
}
