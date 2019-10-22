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
        
        //企業の場合
        if acountResister == "企業"{
            
            //写真
            cell.imageView.image = originalimages
            
            //カテゴリの表示ボタン
            if cameratarget == "新規"{
                cell.categoryBtn.setTitle("カテゴリを入力", for: UIControl.State.normal)
                cell.productBtn.setTitle("品名を入力", for: UIControl.State.normal)
                cell.moneyBtn.setTitle("価格を入力", for: UIControl.State.normal)
            }else{
                cell.categoryBtn.setTitle(categoryname, for: UIControl.State.normal)
                cell.productBtn.setTitle(productname, for: UIControl.State.normal)
                cell.moneyBtn.setTitle("\(moneyname)円", for: UIControl.State.normal)
                
                cell.categoryBtn.addTarget(self, action: #selector(tocategory(sender:)), for: .touchUpInside)
                cell.productBtn.addTarget(self, action: #selector(tomoney(sender:)), for: .touchUpInside)
                cell.moneyBtn.addTarget(self, action: #selector(todish(sender:)), for: .touchUpInside)
            }
            
            //ボタンの背景色
            cell.moneyBtn.backgroundColor = UIColor.init(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
            cell.productBtn.backgroundColor = UIColor.init(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
            cell.categoryBtn.backgroundColor = UIColor.init(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
            
            return cell
        }
        else{
            
            //ユーザの場合
            cell.valuemoji.text = ""
            cell.dishmoji.text = ""
            cell.categorymoji.text = ""
            cell.productBtn.removeFromSuperview()
            cell.moneyBtn.removeFromSuperview()
            cell.categoryBtn.removeFromSuperview()
            
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
