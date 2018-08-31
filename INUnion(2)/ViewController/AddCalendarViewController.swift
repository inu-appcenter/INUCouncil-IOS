//
//  AddCalendarViewController.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 9. 1..
//  Copyright © 2018년 이형주. All rights reserved.
//

import UIKit

class AddCalendarViewController: UIViewController {
    
    @IBOutlet weak var LocateText: UITextField!
    @IBOutlet weak var TitleText: UITextField!
 
    @IBOutlet weak var EndText: UITextField!
    @IBOutlet weak var StartText: UITextField!
    
    var datePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         datePicker = UIDatePicker()
         datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(AddCalendarViewController.dateChanged(datePicker:)), for: .valueChanged)
   
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddCalendarViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        StartText.inputView = datePicker
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        StartText.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    }
   
    
   

