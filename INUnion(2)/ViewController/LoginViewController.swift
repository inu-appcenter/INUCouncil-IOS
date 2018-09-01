//
//  LoginView.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 8. 1..
//  Copyright © 2018년 이형주. All rights reserved.
//
import UIKit
import Toast_Swift
/*
컴퓨터공학부
ID: dcse0780
PW: zjavb1698
 
정보통신공학과 ID: dite0781
PW: wjdqh0828
*/

class LoginViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var CheckIDLabel: UILabel!
    
    @IBOutlet weak var IDTextField: UITextField!
    @IBOutlet weak var PassTextField: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
   
    var loginResult : AnsResult?
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
   
    override func viewWillAppear(_ animated: Bool) {
        IDTextField.text = ""
        PassTextField.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ""
        IDTextField.delegate = self
        PassTextField.delegate = self
        CheckIDLabel.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == IDTextField{
            PassTextField.becomeFirstResponder()
        } else if textField == PassTextField{
            textField.resignFirstResponder()
        }
        return true
    }
    @objc func keyboardWillChange(notification: Notification){
        guard ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil else {
            return
        }
        if notification.name == Notification.Name.UIKeyboardWillShow || notification.name == Notification.Name.UIKeyboardWillChangeFrame{
            view.frame.origin.y = -270
        }
        else{
            view.frame.origin.y = 0
        }
    }
    
    @IBAction func LoginButtonClicked(_ sender: Any) {
        var username : String!
        var password : String!
         username=IDTextField.text!
        password=PassTextField.text!
        let model = NetworkModel(self)
        startLoading()
        model.login(username: username, password: password)
        
        //주석 해제하면 login 생략 가능.
        
      /*  let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
       if let vc = storyBoard.instantiateViewController(withIdentifier: "Start") as? UITabBarController {
         self.present(vc, animated: true, completion: nil)
        }*/
    }
    
    func startLoading(){
        self.view.makeToastActivity(.center)
    }
    func endLoading(){
        self.view.hideToastActivity()
        self.dismiss(animated: true, completion: nil)
    }
}

      extension LoginViewController : NetworkCallback{
            func networkSuc(resultdata: Any, code: String) {
                if code == "loginSuccess" {
                    print(resultdata)
                    if let item = resultdata as? NSDictionary{
                        let ans = item["ans"] as? Bool ?? false
                        let department = item["department"] as? String ?? ""
                        
                        let obj = AnsResult.init(ans: ans, department: department )
                        self.loginResult = obj
                        
                        self.appDelegate.department = self.loginResult?.department
                    }
                    endLoading()
                    if loginResult?.ans == true {
                        
                         CheckIDLabel.isHidden = true
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                       
                        if let vc = storyBoard.instantiateViewController(withIdentifier: "Start") as? UITabBarController {self.present(vc, animated: true, completion: nil)
                        }
                    
                    }else{
                         CheckIDLabel.isHidden = false
                    }
                }
            }
        
            func networkFail(code: String) {
                if(code == "loginError") {
                    print("실패하였습니다.")
                    CheckIDLabel.isHidden = false
                }
            }
}




