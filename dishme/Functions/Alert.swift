//
//  Alert.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/10/07.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import Foundation
import UIKit

class Alert :SweetAlert{
    func infoAlert(Title: String,subTitle: String ,
                   yes: String,no: String ,
                   yesTitle: String,yessubTitle: String){
        
        _ = SweetAlert().showAlert(Title,
                                   subTitle: subTitle,
                                   style: AlertStyle.warning,
                                   buttonTitle:no,
                                   buttonColor:UIColor.colorFromRGB(0xD0D0D0) ,
                                   otherButtonTitle:yes,
                                   otherButtonColor: UIColor.colorFromRGB(0xDD6B55))
        { (isOtherButton) -> Void in
            if isOtherButton == true {
                
            }
            else {
                _ = SweetAlert().showAlert(yesTitle, subTitle: yessubTitle, style: AlertStyle.success)
            }
        }
    }
    func changeAcountAlert(Title: String,subTitle: String ,
                   yes: String,no: String ,
                   noTitle: String,nosubTitle: String,
                   yesTitle: String,yessubTitle: String){
        
        _ = SweetAlert().showAlert(Title,
                                   subTitle: subTitle,
                                   style: AlertStyle.warning,
                                   buttonTitle:no,
                                   buttonColor:UIColor.colorFromRGB(0xD0D0D0) ,
                                   otherButtonTitle:yes,
                                   otherButtonColor: UIColor.colorFromRGB(0xDD6B55))
        { (isOtherButton) -> Void in
            if isOtherButton == true {
                
                _ = SweetAlert().showAlert(noTitle, subTitle: nosubTitle, style: AlertStyle.error)
            }
            else {
                _ = SweetAlert().showAlert("アカウント切り替えをやめました", subTitle: "", style: AlertStyle.error)
            }
        }
    }
}
