//
//  PhoneDirectoryViewController.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 9. 1..
//  Copyright © 2018년 이형주. All rights reserved.
//

import UIKit

class PhoneDirectoryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate  {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var Model : NetworkModel?
    var DirectoryList:[DirectoryName] = []{
        didSet {
            if self.PhoneBookTableView != nil {
                self.PhoneBookTableView.reloadData()
            }
        }
    }
 
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var PlusButton: UIButton!
    @IBOutlet weak var MajorLabel: UILabel!
    @IBOutlet weak var PhoneBookTableView: UITableView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PhoneBookTableView.layer.cornerRadius = 10;
        Model = NetworkModel(self)
        MajorLabel.text!=self.appDelegate.department!
        Model?.DirectoryList(department: self.appDelegate.department!)
        
        self.PhoneBookTableView.delegate = self
        self.PhoneBookTableView.dataSource = self
        SearchBar.backgroundImage = UIImage()
        SearchBar.setValue("취소", forKey: "_cancelButtonText")
        SearchBar.delegate = self
        SearchBar.returnKeyType = UIReturnKeyType.done
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "연락처"
        super.viewWillAppear(animated)
        Model = NetworkModel(self)
        DirectoryList.removeAll()
        Model?.DirectoryList(department: self.appDelegate.department!)
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DirectoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DirectoryTableViewCell", for: indexPath) as! DirectoryTableViewCell
        
        
        cell.ProfNameLabel.text! = DirectoryList[indexPath.row].name!
        return cell
    }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
         let cell = tableView.cellForRow(at: indexPath)
            cell?.isSelected = false
            
            if let dvc = storyboard?.instantiateViewController(withIdentifier: "PhoneBookViewDetail") as? PhoneBookViewDetail{
               
             dvc.GetName = DirectoryList[indexPath.row].name!
                dvc.GetNum = DirectoryList[indexPath.row].phoneNumber!
                dvc.GetEmail = DirectoryList[indexPath.row].email!
                dvc.GetLab = DirectoryList[indexPath.row].position!
                dvc.GetMemo = DirectoryList[indexPath.row].etc!
               
                self.navigationController?.show(dvc, sender: nil)
            }
        }
    
 
        
    /*
     // 서치바
     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
     filtered = searchText.isEmpty ? names : names.filter({(dataString : String) -> Bool in
     return dataString.range(of: searchText, options: .caseInsensitive) != nil
     })
     
     Tableview.reloadData()
     }
     
     func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
     searchActive = true
     
     }
     
     func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
     searchActive = false
     }
     }
     */
}

extension PhoneDirectoryViewController: NetworkCallback{
    func networkSuc(resultdata: Any, code: String) {
        if code == "directoryListSuccess" {
            print(resultdata)
            var temp: [DirectoryName] = []
            if let items = resultdata as? [NSDictionary] {
                for item in items {
                    let name = item["name"] as? String ?? ""
                    let phoneNumber = item["phoneNumber"] as? String ?? ""
                    let email = item["email"] as? String ?? ""
                    let position = item["position"] as? String ?? ""
                    let etc = item["ect"] as? String ?? ""
                    let addressId = item["addressId"] as? String ?? ""
                    let department = item["department"] as? String ?? ""
                    
                    let obj = DirectoryName.init(name: name, phoneNumber: phoneNumber, email:email, position:position, etc:etc, addressId: addressId, department: department)
                    temp.append(obj)
                }
            }
            self.DirectoryList = temp
        }
    }
    
    func networkFail(code: String) {
        if(code == "directoryListError") {
            print("실패하였습니다.")
        }
        
    }
}

