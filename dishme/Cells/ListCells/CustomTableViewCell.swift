//
//  CustomTableViewCell.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/10/21.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.black
        label.frame = CGRect(x: 79, y: 5, width: 100, height: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let acountImage: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 25, y: 10, width: 43, height: 43)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.circle()
        return imageView
    }()
    
    let title1Label: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 79, y: 32, width: 100, height: 30)
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let title2Label: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 79, y: 48, width: 100, height: 30)
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let leftButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 246, y: 20, width: 44, height: 28)
        button.setImage(UIImage(named: "cancelbar"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let rightButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 311, y: 20, width: 44, height: 28)
        button.setImage(UIImage(named: "changebar"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setPositions(view: UIView){
        let width = view.frame.size.width
        
        leftButton.frame = CGRect(x: 246, y: 20, width: 44, height: 28)
        rightButton.frame = CGRect(x: 311, y: 20, width: 44, height: 28)
        
        leftButton.frame.origin.x = width - 100
        rightButton.frame.origin.x = width - 48
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier )
        addSubview(nameLabel)
        addSubview(title1Label)
        addSubview(title2Label)
        addSubview(acountImage)
        addSubview(leftButton)
        addSubview(rightButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
