//
//  ReplyTableViewCell.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/10/24.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import UIKit

class ReplyTableViewCell: UITableViewCell {
    
    @IBOutlet var acountImage: UIImageView!
    @IBOutlet var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        acountImage.circle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    
}
