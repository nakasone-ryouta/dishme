//
//  Search4TableViewCell.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/10/05.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import UIKit

class Search4TableViewCell: UITableViewCell {
    
    @IBOutlet var dishImage: UIImageView!
    @IBOutlet var dishName: UILabel!
    @IBOutlet var money: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
