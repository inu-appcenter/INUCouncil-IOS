//
//  PhoneBookViewDetail.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 9. 1..
//  Copyright © 2018년 이형주. All rights reserved.
//

/*import Foundation
import UIKit



class PhoneBookViewDetail: UIViewController {
    
    // Outlet 모음
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var NumTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var LabTextField: UITextField!
    @IBOutlet weak var MemoTextField: UITextField!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(PhoneBookViewDetail.updateTextView(notification:)), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(PhoneBookViewDetail.updateTextView(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
        
        Name.text! = GetName
        
        NumTextField.text! = GetNum
        NumTextField.underlined()
        NumTextField.resignFirstResponder()
        
        EmailTextField.text! = GetEmail
        EmailTextField.underlined()
        
        LabTextField.text! = GetLab
        LabTextField.underlined()
        
        MemoTextField.text! = GetMemo
        MemoTextField.underlined()
    }
    
    
    
    var GetName = String()
    var GetNum = String()
    var GetEmail = String()
    var GetLab = String()
    var GetMemo = String()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func updateTextView(notification:Notification) {
        let userInfo = notification.userInfo!
        let keyboardEndFrameScreenCoordinates = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        _ = self.view.convert(keyboardEndFrameScreenCoordinates, to: view.window)
        
        if notification.name == Notification.Name.UIKeyboardWillHide{
            //tableview.contentInset = UIEdgeInsets.zero
        } else{
            //Tableview.contentInset = UIEdgeInsets(top :0, left:0, bottom: keyboardEndFrame.height, right: 0)
            //Tableview.scrollIndicatorInsets = textView.contentInset
        }
        //Tableview.scrollRangeToVisible(textView.selectedRange)
    }
    
    
}

*/
