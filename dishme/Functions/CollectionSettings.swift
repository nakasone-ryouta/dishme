//
//  CollectionSettings.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/10/22.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import Foundation
import UIKit

class CollectionSettings {
    func photoSelectCellForRowAt(originalimages:UIImage,
                                 acountResister: String ,
                                 cameratarget: String,
                                 categoryname:String,
                                 productname:String,
                                 moneyname:Int,
                                 collectionvew: UICollectionView,
                                 indexPath: IndexPath) ->UICollectionViewCell{
        
        let cell = collectionvew.dequeueReusableCell(withReuseIdentifier: "Cell2",for: indexPath as IndexPath) as! PhotosBigViewCell
    
            // Section毎にCellのプロパティを変える.
            switch(indexPath.section){
            case 0:
                cell.imageView.image = originalimages
                
            case 1:
                cell.imageView.image = originalimages
                
            case 2:
                cell.imageView.image = originalimages
                
            default:
                cell.imageView.image = originalimages
            }
            
            return cell
    }
    
    @objc func tomoney(sender: UIButton){
        let viewcontroller = PhotoSelectViewController()
            viewcontroller.performSegue(withIdentifier: "toCameraLast", sender: nil)
            
    }
    //ボタンから取得する
    @objc func todish(sender: UIButton){
        let viewcontroller = PhotoSelectViewController()
            viewcontroller.performSegue(withIdentifier: "toCameraLast", sender: nil)
    }
    
    //ボタンから取得する
    @objc func tocategory(sender: UIButton){
        let viewcontroller = PhotoSelectViewController()
            viewcontroller.performSegue(withIdentifier: "toCameraLast", sender: nil)
    }
}
