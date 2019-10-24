
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
    
    func goodButton(alreadygoods: [Bool],indexPath: IndexPath ,goods: [Int] ,button: DOFavoriteButton) -> (goods:Int,alreadygoods:Bool, button:DOFavoriteButton){
        
        //まだ押されていなかったら
        if alreadygoods[indexPath.row] == false{
            button.select()
            return (goods[indexPath.row] + 1, true , button)
        }
        else{
            button.deselect()
            return (goods[indexPath.row], false, button)
        }
    }
    
    func badButton(alreadybads: [Bool],indexPath: IndexPath ,bads: [Int],button: DOFavoriteButton) -> (bads:Int,alreadybads:Bool, button:DOFavoriteButton){
        
        //まだ押されていなかったら
        if alreadybads[indexPath.row] == false{
            button.select()
            return (bads[indexPath.row] + 1, true , button)
        }
        else{
            button.deselect()
            return (bads[indexPath.row], false, button)
        }
    }
}
