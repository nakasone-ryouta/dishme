

    //
//  CameraEditCollectionViewCell.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/09/17.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import UIKit
import SnapLikeCollectionView

class CameraEditCollectionViewCell: UICollectionViewCell , SnapLikeCell{
    
    @IBOutlet weak var imageView: UIImageView!
    
    var item: UIImage? {
        didSet {
            imageView.image = item
        }
    }
    
    @IBOutlet weak var bgView: UIView! {
        didSet {
            bgView.layer.cornerRadius = 5
        }
    }
}
