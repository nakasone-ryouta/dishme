


//
//  List2TableViewCell.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/09/20.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import UIKit

class List2TableViewCell: UITableViewCell {

    @IBOutlet weak var acountName: UILabel!
    @IBOutlet weak var acountImage: UIImageView!
    @IBOutlet var reserveButton: UIButton!
    @IBOutlet var position: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
