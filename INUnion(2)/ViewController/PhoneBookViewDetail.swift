//
//  PhoneBookViewDetail.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 9. 1..
//  Copyright © 2018년 이형주. All rights reserved.
//

import Foundation
import UIKit

class PhoneBookViewDetail: UIViewController,UIScrollViewDelegate {
  
    var GetName = ""
    var GetNum = ""
    var GetEmail = ""
    var GetLab = ""
    var GetMemo = ""
    var GetAddressId : Int = 0
    
    var deleteResult: AnsBoolResult?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var model : NetworkModel?
    var directoryId:Int = 0

    var detailDirectory: DirectoryDetail? {
        didSet {
            if self.ScrollView != nil {
                self.ScrollView.reloadInputViews()
            }
        }
    }
    
    @IBAction func RightButtonClicked(_ sender: Any) {
        let alertController = UIAlertController(title: "선택하세요", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
       
        let deleteAction = UIAlertAction(title: "삭제하기", style: .destructive) {
            (action:UIAlertAction) in
            self.model?.deleteDirectory(addressId: "\(self.GetAddressId)")
            return
            }
        
        let editAction = UIAlertAction(title: "수정하기", style: .default) {
            (_) in
           
            if let addDirectory = self.storyboard?.instantiateViewController(withIdentifier: "AddPhoneDirectoryViewController") as? AddPhoneDirectoryViewController{
               
                addDirectory.ProfName = self.GetName
                addDirectory.ProfEtc = self.GetMemo
                addDirectory.ProfNum = self.GetNum
                addDirectory.ProfEmail = self.GetEmail
                addDirectory.ProfPosition = self.GetLab
                addDirectory.ProfAddressId = self.GetAddressId
                
                self.present(addDirectory, animated: true, completion: nil)
            }
            return
        }
        
        let cancelButton = UIAlertAction(title: "취소", style: UIAlertActionStyle.cancel, handler: nil)
        
        alertController.addAction(cancelButton)
        alertController.addAction(editAction)
        alertController.addAction(deleteAction)
        self.present(alertController, animated: true, completion: nil)

    }
    
    @IBOutlet weak var MajorLabel: UILabel!
    @IBOutlet weak var ProfNameLabel: UILabel!
    @IBOutlet weak var PhoneNumberLabel: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var LabLabel: UILabel!
    @IBOutlet weak var MemoLabel: UITextView!
 
    @IBOutlet weak var ScrollView: UIScrollView!
    
 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = NetworkModel(self)
        model?.DirectoryDetail(name: String(directoryId))
        
        MajorLabel.text! = self.appDelegate.department!
        ProfNameLabel.text! = GetName
        PhoneNumberLabel.text! = GetNum
        EmailLabel.text! = GetEmail
        LabLabel.text! = GetLab
        MemoLabel.text! = GetMemo
        self.title = "연락처 상세"
        ScrollView.layer.cornerRadius = 10
        ScrollView.backgroundColor = UIColor.init(red: 255, green: 255, blue: 255, alpha: 0)
  
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
extension PhoneBookViewDetail: NetworkCallback{
    func networkSuc(resultdata: Any, code: String) {
        if code == "directoryListSuccess" {
            print(resultdata)
            var temp: [DirectoryDetail] = []
            if let items = resultdata as? [NSDictionary] {
                for item in items {
                    let name = item["name"] as? String ?? ""
                    let phoneNumber = item["phoneNumber"] as? String ?? ""
                    let email = item["email"] as? String ?? ""
                    let position = item["position"] as? String ?? ""
                    let etc = item["etc"] as? String ?? ""
                    let addressId = item["addressId"] as? Int ?? 0
                    let department = item["department"] as? String ?? ""
                    
                    let obj = DirectoryDetail.init(name: name, phoneNumber: phoneNumber, email:email, position:position, etc:etc, addressId: addressId, department: department)
                    temp.append(obj)
                  
                    GetName = obj.name!
                    GetEmail = obj.email!
                    GetNum = obj.phoneNumber!
                    GetMemo = obj.etc!
                    GetLab = obj.position!
                    GetAddressId = obj.addressId!
                    detailDirectory = obj
                }
            }
        }else if code == "DirectoryDeleteSuccess"{
            print(resultdata)
            
            if let item = resultdata as? NSDictionary {
                let ans = item["ans"] as? Bool ?? false
                let obj = AnsBoolResult.init(ans: ans)
                self.deleteResult = obj
            }
            if deleteResult?.ans == true{
    self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func networkFail(code: String) {
        if(code == "DirectoryListError") {
            print("실패하였습니다.")
        }
        
    }
}

