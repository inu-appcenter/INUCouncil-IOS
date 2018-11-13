//
//  Setting.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 8. 1..
//  Copyright © 2018년 이형주. All rights reserved.
//
import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var settingTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTable.tableFooterView = UIView()

    }
      
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension SettingViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return " 알림 설정"
        case 1:
            return " 관리자 로그인"
        default:
            return ""
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell") as! SettingTableViewCell
        switch indexPath.section {
        case 0:
            cell.settingSwitch.isHidden = false
            cell.settingNameLabel.text = "   알림 허용"
       
        case 1:
            cell.settingSwitch.isHidden = true
            cell.settingNameLabel.text = "   로그아웃"
            cell.settingNameLabel.textColor = UIColor.red
        default:
            break
        }
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = false
        switch indexPath.section {
        case 0:
            break
        case 1:
            self.dismiss(animated: true, completion:nil)
            break
        default:
            break
        }
    }
    
}
