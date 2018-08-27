//
//  DataViewController.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 8. 12..
//  Copyright © 2018년 이형주. All rights reserved.
//


 import UIKit

class DetailViewController: UIViewController, UITextViewDelegate
{
    var getTitle = String()
    var getTime = String()
    var getlocation = String()
    var getcontents = String()
    
    @IBAction func ReviseButtonClick(_ sender: Any) {
    }
    
    @IBAction func BackButtonClick(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var timeText: UITextField!
    @IBOutlet weak var whereText: UITextField!
    @IBOutlet weak var textView: UITextView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textView.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(DetailViewController.updateTextView(notification:)), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(DetailViewController.updateTextView(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
        
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = UIColor(red: 59/255, green: 91/255, blue: 219/255, alpha: 1)
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
        titleText.text! = getTitle
        timeText.text! = getTime
        whereText.text! = getlocation
        textView.text! = getcontents
   
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
 
