//
//  PhoneDirectoryViewController.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 9. 1..
//  Copyright © 2018년 이형주. All rights reserved.
//

import UIKit

class Prof {
    let name : String
    let phoneNumber : String
    let email : String
    let position : String
    let etc : String
    let addressId : Int
    let department : String
    init(name : String, phoneNumber: String, email: String, position: String, etc: String, addressId: Int, department: String){
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
        self.position = position
        self.etc = etc
        self.addressId = addressId
        self.department = department
    }
}

let appDelegate = UIApplication.shared.delegate as! AppDelegate
var model : NetworkModel?
var Address:[NoticeResult] = []{
    didSet {
        if self.tableView != nil {
            self.tableView.reloadData()
        }
    }
}

class PhoneDirectoryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
    
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var PlusButton: UIButton!
    @IBOutlet weak var MajorLabel: UILabel!
    @IBOutlet weak var PhoneBookTableView: UITableView!
    @IBOutlet weak var MajorLabel: UILabel!
    
    var profArray = [Prof]()
    var currentProfArray = [Prof]() //Upload Table

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpProf()
        setUpSearchBar()
        
        MajorLabel.text = self.appDelegate.department!
        PhoneBookTableView.layer.cornerRadius = 10
        SearchBar.backgroundImage = UIImage()
        SearchBar.setValue("취소", forKey: "_cancelButtonText")
        SearchBar.delegate = self
        SearchBar.returnKeyType = UIReturnKeyType.done
    }
    
    private func setUpProf() {
        profArray.append(Prof(name: "Lim", phoneNumber: "4321", email: "gudwn@naver.com", position: "korea", etc: "hello"))
        profArray.append(Prof(name: "Lee", phoneNumber: "1234", email: "gudwn@naver.com", position: "korea", etc: "hello"))
        profArray.append(Prof(name: "Kim", phoneNumber: "3421", email: "gudwn@naver.com", position: "korea", etc: "hello"))
           profArray.append(Prof(name: "Park", phoneNumber: "4321", email: "gudwn@naver.com", position: "korea", etc: "hello"))
        profArray.append(Prof(name: "Lim", phoneNumber: "4321", email: "gudwn@naver.com", position: "korea", etc: "hello"))
        currentProfArray = profArray
    }
    
    private func setUpSearchBar() {
        SearchBar.delegate = self
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Address.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DirectoryTableViewCell", for: indexPath) as? DirectoryTableViewCell else {
            return UITableViewCell()
        }
        cell.ProfNameLabel.text = currentProfArray[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let dvc = storyboard?.instantiateViewController(withIdentifier: "PhoneBookViewDetail") as? PhoneBookViewDetail{
            dvc.GetName = profArray[indexPath.row].name
            dvc.GetNum = profArray[indexPath.row].phoneNumber
            dvc.GetEmail = profArray[indexPath.row].email
            dvc.GetLab = profArray[indexPath.row].position
            dvc.GetMemo = profArray[indexPath.row].etc
            self.navigationController?.show(dvc, sender: nil)
        }
        
    }
 
    //Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        guard !searchText.isEmpty else {
            currentProfArray = profArray
            PhoneBookTableView.reloadData()
            return
        }
        currentProfArray = profArray.filter({Prof -> Bool in
        guard let text = searchBar.text else {return false}
       return Prof.name.contains(text)
     })
     PhoneBookTableView.reloadData()
    }
}

extension PhoneDirectoryViewController: NetworkCallback{
   
    func networkSuc(resultdata: Any, code: String) {
        if code == "AddressListSuccess" {
            print(resultdata)
            
            var temp: [NoticeResult] = []
            if let items = resultdata as? [NSDictionary] {
                for item in items {
                   
                    let name = item["name"] as? String ?? ""
                    let phoneNumber = item["phoneNumber"] as? String ?? ""
                    let position = item["position"] as? String ?? ""
                    let etc = item["etc"] as? String ?? ""
                    let addressId = item["addressId"] as? Int ?? 0
                    let department = item["department"] as? String ?? ""
                    
                    let obj = NoticeResult.init(name: name, phoneNumber: phoneNumber, position: position, etc: etc, addressId: addressId, department: department)
                    temp.append(obj)
                }
            }
            
            self.AddressList = temp
            
        }
    }
    
    func networkFail(code: String) {
        if(code == "AddressListError") {
            print("실패하였습니다.")
        }
        
    }
}





