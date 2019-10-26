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
    
    func totalHeight(cellsum: [Int] ,view: UIView) ->Int{
        var result = 0
        let cellsize = Int(view.frame.size.width / 3 - 1)
        for i in 0..<cellsum.count{
            let line = Double(cellsum[i]) / 3
            let lineup = ceil(line)
            let linedown = Int(lineup)
            result = cellsize * linedown + result
            print("aaaaa",result)
        }
        return result
    }
}
