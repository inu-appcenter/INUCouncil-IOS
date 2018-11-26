//
//  AddCalendarViewController.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 9. 1..
//  Copyright © 2018년 이형주. All rights reserved.
//

import UIKit
import Toast_Swift

class AddPhoneDirectoryViewController: UIViewController,UITextViewDelegate {
    
    
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var MemoTextView: UITextView!
    @IBOutlet weak var InputTextLabel: UILabel!
    
    @IBOutlet weak var MaximulLabel: UILabel!
    
    @IBAction func CompleteButtonClicked(_ sender: Any) {
     
        if ProfAddressId == 0 {
            model?.upLoadDirectory(name: NameText.text!, phoneNumber: AddNumberText.text!, email: AddEmail.text!, position: LocateText.text!, etc: MemoTextView.text!, department: (self.appDelegate.department)!)
        }
        else{
        
                  model?.modifyDirectory(name: NameText.text!, phoneNumber: AddNumberText.text!, email: AddEmail.text!, position: LocateText.text!, etc: MemoTextView.text!, department: (self.appDelegate.department)!, addressId: ProfAddressId)
        }
                 self.dismiss(animated: true, completion: nil)
  
    }
    
    @IBAction func XButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBOutlet weak var NameText: UITextField!
    @IBOutlet weak var AddNumberText: UITextField!
    @IBOutlet weak var AddEmail: UITextField!
    
    @IBOutlet weak var LocateText: UITextField!
   

    var
    ProfName: String = ""
    var ProfNum: String = ""
    var ProfEmail: String = ""
    var ProfPosition: String = ""
    var ProfEtc: String = ""
    var ProfAddressId: Int = 0
    
    var deleteResult: AnsBoolResult?
    var model : NetworkModel?
    var uploadResult: AnsBoolResult?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model = NetworkModel(self)
        
        if ProfName != ""{
            NameText.text = ProfName
        }
        if ProfNum != ""{
            AddNumberText.text = ProfNum
        }
        if ProfEmail != ""{
            AddEmail.text = ProfEmail
        }
        if ProfEtc != ""{
            MemoTextView.text = ProfEtc
        }
        if ProfPosition != ""{
            LocateText.text = ProfPosition
        }
   
        
        InputTextLabel.text = "0"
        MemoTextView.text = "내용을 적어주세요"
        MemoTextView.textColor = UIColor.lightGray
        MemoTextView.delegate = self
        
    }
 
    override func viewWillDisappear(_ animated: Bool) {
       
    }
    
    //배경 탭하면 입력 종료되는 함수
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    //입력 글자 수 Count
    func checkRemaingChars(){
        let charsInTextView = (MemoTextView.text.characters.count)
        let remainingChars = charsInTextView
        InputTextLabel.text = String(remainingChars)
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        checkRemaingChars()
    }
    
    //텍스트 뷰 Placeholder
    func textViewDidBeginEditing(_ textView: UITextView) {
        if MemoTextView.text == "내용을 적어주세요" {
            MemoTextView.text = ""
            MemoTextView.textColor = UIColor.black
        }
    }
    
    //텍스트 뷰 글자수 제한 300자
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        return updatedText.count <= 300 // Change limit based on your requirement.
    }
    
}

extension AddPhoneDirectoryViewController:NetworkCallback{
    func networkSuc(resultdata: Any, code: String) {
        if code == "DirectorySaveSucces"{
            print(resultdata)
            
            if let item = resultdata as? NSDictionary {
                let ans = item["ans"] as? Bool ?? false
                let obj = AnsBoolResult.init(ans: ans)
                self.uploadResult = obj
            }
           
        }
        else if code == "DirectoryDeleteSuccess"{
            print(resultdata)
            
            if let item = resultdata as? NSDictionary {
                let ans = item["ans"] as? Bool ?? false
                let obj = AnsBoolResult.init(ans: ans)
                self.deleteResult = obj
            }
            if deleteResult?.ans == true{
                self.navigationController?.popViewController(animated: true)
            }
        }else if code == "DirectoryModifySucces"{
            print(resultdata)
            
            if let item = resultdata as? NSDictionary {
                let ans = item["ans"] as? Bool ?? false
                let obj = AnsBoolResult.init(ans : ans)
                self.uploadResult = obj
            }
        }
    }
    func networkFail(code: String) {
        if code == "DirectorySaveFail"{
            print("실패했습니다.")
        }
    }
    
    
}
