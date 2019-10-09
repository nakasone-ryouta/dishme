//
//  Settings.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/10/08.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class TableSettings :UIViewController{
    let alert = Alert()
    
    func cellForRowAt(cell: UITableViewCell ,indexPath: IndexPath ,opentitle: String, opentime: String, congestion: String,congestiontime: String, position: String, phonenumber: Int, maxnumber: String, holiday: String, temporaryClosed: String){
        //営業中
        if indexPath.row == 0{
            cell.textLabel?.text = opentitle
            cell.textLabel?.textAlignment = NSTextAlignment.right
            cell.textLabel?.font = UIFont.init(name: "HelveticaNeue-Bold", size: 13)
            //営業時間
            cell.detailTextLabel?.text = opentime
            cell.detailTextLabel?.textAlignment = NSTextAlignment.left
        }
        //混雑時間
        if indexPath.row == 1{
            cell.textLabel?.text = congestion
            cell.textLabel?.textAlignment = NSTextAlignment.right
            cell.textLabel?.font = UIFont.init(name: "HelveticaNeue-Bold", size: 13)
            //時間
            cell.detailTextLabel?.text = congestiontime
            cell.detailTextLabel?.textAlignment = NSTextAlignment.left
        }
        //場所
        if indexPath.row == 2{
            cell.textLabel?.text = position
            cell.textLabel?.textAlignment = NSTextAlignment.right
            cell.textLabel?.font = UIFont.init(name: "HelveticaNeue-Thin", size: 13)
        }
        //電話番号
        if indexPath.row == 3{
            cell.textLabel?.text = String(phonenumber)
            cell.textLabel?.textAlignment = NSTextAlignment.right
            cell.textLabel?.font = UIFont.init(name: "HelveticaNeue-Bold", size: 13)
        }
        //中休み
        if indexPath.row == 4{
            cell.textLabel?.text = "中休み"
            cell.textLabel?.textAlignment = NSTextAlignment.right
            cell.textLabel?.font = UIFont.init(name: "HelveticaNeue-Bold", size: 13)
            //営業時間
            cell.detailTextLabel?.text = opentime
            cell.detailTextLabel?.textAlignment = NSTextAlignment.left
        }
        //最大定員数
        if indexPath.row == 5{
            cell.textLabel?.text = "１時間予約上限人数"
            cell.textLabel?.textAlignment = NSTextAlignment.right
            cell.textLabel?.font = UIFont.init(name: "HelveticaNeue-Bold", size: 13)
            //営業時間
            cell.detailTextLabel?.text = maxnumber + "名"
            cell.detailTextLabel?.textAlignment = NSTextAlignment.left
        }
        if indexPath.row == 6{
            cell.textLabel?.text = "定休日"
            cell.textLabel?.textAlignment = NSTextAlignment.right
            cell.textLabel?.font = UIFont.init(name: "HelveticaNeue-Bold", size: 13)
            //営業時間
            cell.detailTextLabel?.text = holiday
            cell.detailTextLabel?.textAlignment = NSTextAlignment.left
        }
        //臨時休業
        if indexPath.row == 7{
            cell.textLabel?.text = "臨時休業"
            cell.textLabel?.textAlignment = NSTextAlignment.right
            cell.textLabel?.font = UIFont.init(name: "HelveticaNeue-Bold", size: 13)
            //営業時間
            cell.detailTextLabel?.text = temporaryClosed
            cell.detailTextLabel?.textAlignment = NSTextAlignment.left
        }
        
        //選択不可
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
    }
    
    
    func didSelectRowAt(indexPath: IndexPath){
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
    
    func hederInSection() -> UIView{
        //ヘッダーにするビューを生成
        let view = UIView()
        view.frame = CGRect(x: 0, y: 313, width: self.view.frame.size.width, height: 55)
        view.backgroundColor = UIColor.white
        
        //ヘッダーに追加するラベルを生成
        let headerLabel = UILabel()
        headerLabel.frame =  CGRect(x: 13, y: 10, width: 0, height: 0)
        headerLabel.text = "レストラン情報"
        headerLabel.textColor = UIColor.black
        headerLabel.font = UIFont.init(name: "HelveticaNeue-Bold", size: 17)
        headerLabel.textAlignment = NSTextAlignment.right
        headerLabel.sizeToFit()
        view.addSubview(headerLabel)
        
        return view
    }
}


//メール
extension TableSettings:MFMailComposeViewControllerDelegate{
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
