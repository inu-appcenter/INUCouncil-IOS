//
//  DataViewController.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 8. 12..
//  Copyright © 2018년 이형주. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController
{
    
     let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var getTitle = ""
    var getStartTime = ""
    var getEndTime = ""
    var getlocation = ""
    var getcontents = ""
    
    var boardId:Int = 0
  
    @IBOutlet weak var MajorLabel: UILabel!
    
    @IBOutlet weak var CardView: UIView!
 
    @IBAction func RightButtonClicked(_ sender: Any) {
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "수정하기", style: .default, handler: self.okHandler))
        alertController.addAction(UIAlertAction(title: "삭제하기", style: .destructive, handler: self.okHandler))
        alertController.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(alertController,animated:true, completion: nil)
    }
    
    func okHandler(alert: UIAlertAction!){
        self.navigationController?.pushViewController(UIViewController(), animated: true)
    }
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var StartTimeText: UILabel!
    @IBOutlet weak var EndTimeText: UILabel!
    @IBOutlet weak var whereText: UILabel!
    @IBOutlet weak var textView: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "달력 상세"
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.white
        
 
        CardView.layer.cornerRadius = 10
        titleText.text! = getTitle
        StartTimeText.text! = getStartTime
        EndTimeText.text! = getEndTime
        whereText.text! = getlocation
        textView.text! = getcontents
        MajorLabel.text = self.appDelegate.department
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.textView.resignFirstResponder()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.backgroundColor = UIColor.lightGray
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.backgroundColor = UIColor.white
    }
    
  
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.navigationController?.navigationBar.topItem?.title = "";
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
