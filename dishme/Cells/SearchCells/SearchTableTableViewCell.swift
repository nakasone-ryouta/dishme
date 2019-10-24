
//
//  SearchTableTableViewCell.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/10/23.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import UIKit

class SearchTableTableViewCell: UITableViewCell {
    
    @IBOutlet var acountImage: UIImageView!
    @IBOutlet var searchLabel: UILabel!
    @IBOutlet var kmLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code]
        kmLabel.sizeToFit()
        acountImage.circle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
