//
//  TabBarController.swift
//  dishme
//
//  Created by 中曽根　涼太 on 2019/10/27.
//  Copyright © 2019年 中曽根　涼太. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.children.first is CameraViewController {
            if let newVC = tabBarController.storyboard?.instantiateViewController(withIdentifier: "CameraViewController"){ //withIdentifier: にはStory Board IDを設定
                tabBarController.present(newVC, animated: true, completion: nil)//newVCで設定したページに遷移
                return false
            }
        }
        return true
    }
}
