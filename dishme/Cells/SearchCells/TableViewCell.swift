//
//  TableViewCell.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/09/19.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var isOpen = false
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var acountButton: UIButton!
    @IBOutlet weak var resevebButton: UIButton!
    @IBOutlet weak var dishImage: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var goodlabel: UILabel!
    @IBOutlet weak var badlabel: UILabel!
    @IBOutlet var goodButton: UIButton!
    @IBOutlet var badButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        acountButton.layer.masksToBounds = true
        acountButton.layer.cornerRadius = 16
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if #available(iOS 10, *) {
            UIView.animate(withDuration: 0.3) { self.contentView.layoutIfNeeded() }
        }
    }

}
