//
//  CustomNavigation.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 8. 1..
//  Copyright © 2018년 이형주. All rights reserved.
//

import UIKit

class CustomNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
       self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        

    }
    
}
