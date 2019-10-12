

//
//  ResreveMemberTableViewCell.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/10/04.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import UIKit

class ResreveMemberTableViewCell: UITableViewCell {
    @IBOutlet weak var acountname: UILabel!
    @IBOutlet weak var acountImage: UIImageView!
    @IBOutlet weak var member: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var phonenumber: UILabel!
    
    @IBOutlet var callbutton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
        
        acountImage.frame.origin.x = 30
        acountname.textAlignment = .center
    }
    @IBAction func callAction(_ sender: Any) {
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
