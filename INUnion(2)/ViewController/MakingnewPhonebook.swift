//
//  MakinnewPhonebook.swift
//  INUnion(2)
//
//  Created by 유용상 on 2018. 8. 25..
//  Copyright © 2018년 이형주. All rights reserved.
//

import Foundation
import UIKit

extension UITextField{
    func underlined(){
    let border = CALayer()
    let lineWidth = CGFloat(0.3)
    border.borderColor = UIColor.lightGray.cgColor
    border.frame = CGRect(x: 0, y: self.frame.size.height - lineWidth, width:  self.frame.size.width, height: self.frame.size.height)
    border.borderWidth = lineWidth
    self.layer.addSublayer(border)
    self.layer.masksToBounds = true
    }
}

class MakingNewPhonebook: UIViewController{
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var numberTextfield: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var memoTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextfield.placeholder = "이름"
        nameTextfield.underlined()
        
        numberTextfield.placeholder = "전화번호"
        numberTextfield.underlined()
        
        emailTextField.placeholder = "이메일"
        emailTextField.underlined()
        
        locationTextField.placeholder = "위치"
        locationTextField.underlined()
        
        memoTextField.underlined()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
