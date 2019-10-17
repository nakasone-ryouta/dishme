



//
//  PhotosCollectionViewCell.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/09/18.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    var textLabel : UILabel?
    var imageView: UIImageView?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // UILabelを生成.
        textLabel = UILabel(frame: CGRect(x:0, y:0, width:frame.width, height:frame.height))
        textLabel?.text = "nil"
        textLabel?.textAlignment = NSTextAlignment.center
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        imageView?.image = nil
        // Cellに追加.
        self.contentView.addSubview(textLabel!)
        self.contentView.addSubview(imageView!)
    }
    func setImage(size: Int){
        imageView?.frame = CGRect(x: 0, y: 0, width: size, height: size)
    }
}

class SectionHeader: UICollectionReusableView {
    var titleLabel:UILabel!
    let button = UIButton(type: .custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel = UILabel(frame: frame)
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        titleLabel.frame = CGRect(x: 46, y: 0, width: 375, height: 60)
        self.addSubview(titleLabel)
        
        
        button.setImage(UIImage(named: "menuadd"), for: UIControl.State())
        button.sizeToFit()
        button.frame = CGRect(x: 15, y: 20, width: 22, height: 22)
        self.addSubview(button)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(title:String){
        titleLabel.text = title
    }
    
    func setImage(image: UIImage){
    }
}
