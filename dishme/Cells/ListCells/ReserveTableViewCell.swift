//
//  ReserveTableViewCell.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/10/21.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import UIKit

class ReserveTableViewCell: UITableViewCell {

    @IBOutlet var acountImage: UIImageView!
    @IBOutlet var maintitle: UILabel!
    @IBOutlet var title1: UILabel!
    @IBOutlet var title2: UILabel!
    @IBOutlet var leftButton: UIButton!
    @IBOutlet var rightButton: UIButton!
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
