//
//  LoginView.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 8. 1..
//  Copyright © 2018년 이형주. All rights reserved.
//
import UIKit


class LoginViewController: UIViewController, UITextFieldDelegate
{

    
    @IBOutlet weak var IDTextField: UITextField!
    @IBOutlet weak var PassTextField: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
   
    var loginResult : Bool?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ""
        IDTextField.delegate = self
        PassTextField.delegate = self
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)}
    
    @IBAction func LoginButtonClicked(_ sender: Any) {
        var username : String!
        var password : String!
         username=IDTextField.text!
        password=PassTextField.text!
        let model = NetworkModel(self)
        model.login(username: username, password: password)
       
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
       if let vc = storyBoard.instantiateViewController(withIdentifier: "Start") as? UINavigationController {
         self.present(vc, animated: true, completion: nil)
        }
    }
}

      extension LoginViewController : NetworkCallback{
            func networkSuc(resultdata: Any, code: String) {
                if code == "loginSuccess" {
                    print(resultdata)
                    loginResult = resultdata as? Bool
                    if loginResult == true {
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        if let vc = storyBoard.instantiateViewController(withIdentifier: "MainNavigationController") as?
                            UINavigationController {self.present(vc, animated: true, completion: nil)}} else{
                        IDTextField.text = ""
                        PassTextField.text = ""
                       
                    }
                }
            }
        
            func networkFail(code: String) {
                if(code == "loginError") {
                    print("실패하였습니다.")
                }
            }
}




