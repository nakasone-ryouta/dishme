
//
//  ListTableViewCell.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/09/20.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    @IBOutlet weak var acountImage: UIImageView!
    @IBOutlet weak var acountLabel: UILabel!
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var Position: UILabel!
    
    @IBOutlet weak var changeBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBOutlet weak var moji1Label: UILabel!
    @IBOutlet weak var moji2Label: UILabel!
    @IBOutlet weak var moji3Label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
