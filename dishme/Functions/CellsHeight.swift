//
//  CellsHeight.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/10/22.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import Foundation
import UIKit

class CellsHeight {
    
    func menuHeight(cellsum: Int ,view: UIView) ->Int{
        var result = 0
        let line = cellsum / 3
        result = line * Int(view.frame.size.width)
        return result
    }
}
