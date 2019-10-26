
//
//  PhotoSelectLayouting.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/10/25.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import Foundation
import UIKit

class PhotoSelectLayouting {
    func photoselectCell(collectionView: UICollectionView, view: UIView){
        
        let layout = CustomFlowLayout()
        let width = view.frame.size.width
        
        switch UIScreen.main.nativeBounds.height {
        case 1136:
            print("iPhone 5/5S/5C")
            layout.itemSize = CGSize(width: width, height: 570)
            collectionView.collectionViewLayout = layout
           
        case 1334:
            print("iPhone 6/6S/7/8")
            layout.itemSize = CGSize(width: width, height: 570)
            collectionView.collectionViewLayout = layout

        case 2208:
            print("iPhone 6+/6S+/7+/8+")
            layout.itemSize = CGSize(width: width, height: 570)
            collectionView.collectionViewLayout = layout
        
        case 2436:
            print("iPhone X")
            layout.itemSize = CGSize(width: width, height: 620)
            collectionView.collectionViewLayout = layout

        case 960:
            print("iPad Pro(iPhone ver) (9.7-inch)/(10.5-inch)")
            print("iPad Air(iPhone ver) (5th generation)/Air/2")
        default:
            print("unknown!!!!!!!!!!!!" , UIScreen.main.nativeBounds.height)
        }
    }
    
    func kutikomiLayout(label: UILabel, view: UIView){
        
        switch UIScreen.main.nativeBounds.height {
        case 1136:
            print("iPhone 5/5S/5C")
            label.frame = CGRect(x: 20,y: 430,width: 0, height: 0)
            
        case 1334:
            print("iPhone 6/6S/7/8")
            label.frame = CGRect(x: 20,y: 430,width: 0, height: 0)
           
            
        case 2208:
            print("iPhone 6+/6S+/7+/8+")
            label.frame = CGRect(x: 20,y: 430,width: 0, height: 0)
          
            
        case 2436:
            print("iPhone X")
            label.frame = CGRect(x: 20,y: 500,width: 0, height: 0)
            
        case 960:
            print("iPad Pro(iPhone ver) (9.7-inch)/(10.5-inch)")
            print("iPad Air(iPhone ver) (5th generation)/Air/2")
        default:
            print("unknown!!!!!!!!!!!!" , UIScreen.main.nativeBounds.height)
        }
    }
}
