
//
//  EvalutionButton.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/10/22.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import Foundation
import UIKit

class  EvalutionButton {
    
    func goodButton(alreadygoods: [Bool],indexPath: IndexPath ,goods: [Int] ,button: UIButton) -> (goods:Int,alreadygoods:Bool, button:UIButton){
        
        //まだ押されていなかったら
        if alreadygoods[indexPath.row] == false{
            let backImage = UIImage(named: "good")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            button.setImage(backImage, for: .normal)
            button.tintColor = UIColor.init(red: 55/255, green: 151/255, blue: 240/255, alpha: 1)
            return (goods[indexPath.row] + 1, true , button)
        }
        else{
            button.setImage(UIImage(named: "good"), for: .normal)
            return (goods[indexPath.row], false, button)
        }
    }
    
    func badButton(alreadybads: [Bool],indexPath: IndexPath ,bads: [Int],button: UIButton) -> (bads:Int,alreadybads:Bool, button:UIButton){
        
        //まだ押されていなかったら
        if alreadybads[indexPath.row] == false{
            let backImage = UIImage(named: "bad")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            button.setImage(backImage, for: .normal)
            button.tintColor = UIColor.init(red: 55/255, green: 151/255, blue: 240/255, alpha: 1)
            return (bads[indexPath.row] + 1, true , button)
        }
        else{
            button.setImage(UIImage(named: "bad"), for: .normal)
            return (bads[indexPath.row], false, button)
        }
    }
}
