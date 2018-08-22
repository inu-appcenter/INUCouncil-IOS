//
//  StudentDetailViewController.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 8. 14..
//  Copyright © 2018년 이형주. All rights reserved.
//

import UIKit

class StudentDetailViewController: UIViewController, UITextViewDelegate
{
    var getname = String()
    var getImage = UIImage()
    
    
    @IBAction func ReviseButtonClick(_ sender: Any) {
    }
    
    @IBAction func BackButtonClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var NoticeLabel: UILabel!
    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var timeText: UITextField!
    @IBOutlet weak var whereText: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.textView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(DetailViewController.updateTextView(notification:)), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(DetailViewController.updateTextView(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
        
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = UIColor(red: 59/255, green: 91/255, blue: 219/255, alpha: 1)
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
        
        imgImage.image = getImage
        NoticeLabel.text! = getname
        
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
    
    @objc func updateTextView(notification:Notification) {
        let userInfo = notification.userInfo!
        let keyboardEndFrameScreenCoordinates = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardEndFrame = self.view.convert(keyboardEndFrameScreenCoordinates, to: view.window)
        
        if notification.name == Notification.Name.UIKeyboardWillHide{
            textView.contentInset = UIEdgeInsets.zero
        } else{
            textView.contentInset = UIEdgeInsets(top :0, left:0, bottom: keyboardEndFrame.height, right: 0)
            textView.scrollIndicatorInsets = textView.contentInset
        }
        textView.scrollRangeToVisible(textView.selectedRange)
    }
    
    class CustomNavController: UINavigationController {
        override func viewDidLoad() {
            super.viewDidLoad()
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationBar.shadowImage = UIImage()
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "";
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
