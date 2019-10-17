//
//  TableLayouting.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/10/16.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import Foundation
import UIKit

class Layouting {
    
    func tableLayouting(tableview: UITableView, view: UIView){
        let width = view.frame.size.width
        
        switch UIScreen.main.nativeBounds.height {
        case 1136:
            print("iPhone 5/5S/5C")
            tableview.frame = CGRect(x: 0, y: 0, width: width, height: 370)
        case 1334:
            print("iPhone 6/6S/7/8")
            tableview.frame = CGRect(x: 0, y: 0, width: width, height: 510)
        case 2208:
            print("iPhone 6+/6S+/7+/8+")
            tableview.frame = CGRect(x: 0, y: 0, width: width, height: 570)
        case 2436:
            print("iPhone X")
            tableview.frame = CGRect(x: 0, y: 0, width: width, height: 600)
        case 960:
            print("iPad Pro(iPhone ver) (9.7-inch)/(10.5-inch)")
            print("iPad Air(iPhone ver) (5th generation)/Air/2")
        default:
            print("unknown!!!!!!!!!!!!" , UIScreen.main.nativeBounds.height)
        }
    }
    
    func acountTableLayouting(tableview: UITableView, view: UIView){
        let width = view.frame.size.width
        
        switch UIScreen.main.nativeBounds.height {
        case 1136:
            print("iPhone 5/5S/5C")
            tableview.frame = CGRect(x: 0, y: 0, width: width, height: 370)
        case 1334:
            print("iPhone 6/6S/7/8")
            tableview.frame = CGRect(x: 0, y: 0, width: width, height: 470)
        case 2208:
            print("iPhone 6+/6S+/7+/8+")
            tableview.frame = CGRect(x: 0, y: 0, width: width, height: 540)
        case 2436:
            print("iPhone X")
            tableview.frame = CGRect(x: 0, y: 0, width: width, height: 600)
        case 960:
            print("iPad Pro(iPhone ver) (9.7-inch)/(10.5-inch)")
            print("iPad Air(iPhone ver) (5th generation)/Air/2")
        default:
            print("unknown!!!!!!!!!!!!" , UIScreen.main.nativeBounds.height)
        }
    }
    
    func acountTableCellHeighting(view: UIView) -> Int{
        switch UIScreen.main.nativeBounds.height {
        case 1136:
            print("iPhone 5/5S/5C")
            return 40
        case 1334:
            print("iPhone 6/6S/7/8")
            return 40
        case 2208:
            print("iPhone 6+/6S+/7+/8+")
            return 55
        case 2436:
            print("iPhone X")
            return 55
        case 960:
            print("iPad Pro(iPhone ver) (9.7-inch)/(10.5-inch)")
            print("iPad Air(iPhone ver) (5th generation)/Air/2")
            return 55
        default:
            print("unknown!!!!!!!!!!!!" , UIScreen.main.nativeBounds.height)
            return 55
        }
    }
    
    func list2backview(view: UIView , backview: UIView){
        
        let maxwidth = view.frame.size.width
        let maxheight = view.frame.size.height
        
        switch UIScreen.main.nativeBounds.height {
        case 1136:
            print("iPhone 5/5S/5C")
            backview.frame = CGRect(x: 0, y: 50, width: maxwidth, height: maxheight)
        case 1334:
            print("iPhone 6/6S/7/8")
            backview.frame = CGRect(x: 0, y: 50, width: maxwidth, height: maxheight)
           
        case 2208:
            print("iPhone 6+/6S+/7+/8+")
            backview.frame = CGRect(x: 0, y: 50, width: maxwidth, height: maxheight)
            
        case 2436:
            print("iPhone X")
            backview.frame = CGRect(x: 0, y: 70, width: maxwidth, height: maxheight)
          
        case 960:
            backview.frame = CGRect(x: 0, y: 100, width: maxwidth, height: maxheight)
            print("iPad Pro(iPhone ver) (9.7-inch)/(10.5-inch)")
            print("iPad Air(iPhone ver) (5th generation)/Air/2")
           
        default:
            print("unknown!!!!!!!!!!!!" , UIScreen.main.nativeBounds.height)
        }
    }
}
