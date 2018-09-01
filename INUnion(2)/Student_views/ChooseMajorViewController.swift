//
//  ChooseMajorViewController.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 8. 8..
//  Copyright © 2018년 이형주. All rights reserved.
//

import UIKit

class ChooseMajorViewController: UIViewController {

    @IBOutlet weak var SearchBar: UISearchBar!
    
    var isShowed: Bool = false
    
    func addNoti() {
        NotificationCenter.default.addObserver(self, selector: #selector(SearchMajorViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SearchMajorViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if !isShowed{
            isShowed = true
            self.SearchBar.setShowsCancelButton(true, animated: true)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
    }
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.tintColor = UIColor.white

        super.viewDidLoad()
        addNoti()
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = UIColor(red: 59/255, green: 91/255, blue: 219/255, alpha: 1)
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
        SearchBar.backgroundImage = UIImage()
        SearchBar.setValue("취소", forKey: "_cancelButtonText")
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.isShowed = false
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
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return.lightContent
    }
    
    
}
