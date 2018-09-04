//
//  PhoneBookViewDetail.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 9. 1..
//  Copyright © 2018년 이형주. All rights reserved.
//

import Foundation
import UIKit



class PhoneBookViewDetail: UIViewController {
    
    @IBOutlet weak var CardView: UIView!
    
    @IBAction func AlertButton(_ sender: Any) {
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "수정하기", style: .default, handler: self.okHandler))
        alertController.addAction(UIAlertAction(title: "삭제하기", style: .destructive, handler: self.okHandler))
        alertController.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(alertController,animated:true, completion: nil)
    }
    func okHandler(alert: UIAlertAction!){
        self.navigationController?.pushViewController(UIViewController(), animated: true)
    }
    
    
    @IBAction func BackButtonClicked(_ sender: Any) {
    
    }
    
    @IBOutlet weak var ProfNameLabel: UILabel!
    @IBOutlet weak var PhoneNumberLabel: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var LabLabel: UILabel!
    @IBOutlet weak var MemoTextView: UITextView!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CardView.layer.cornerRadius = 10
        ProfNameLabel.text! = GetName
        PhoneNumberLabel.text! = GetNum
        EmailLabel.text! = GetEmail
        LabLabel.text! = GetLab
        MemoTextView.text! = GetMemo
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
    
}

