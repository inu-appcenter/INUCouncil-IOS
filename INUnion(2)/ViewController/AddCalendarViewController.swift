//
//  AddCalendarViewController.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 9. 1..
//  Copyright © 2018년 이형주. All rights reserved.
//

import UIKit

class AddCalendarViewController: UIViewController {
    
    @IBAction func CompleteButtonClicked(_ sender: Any)
    {
    print("ok")
    }
    
    
    @IBAction func XbuttnClicked(_ sender: Any) {
  self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var CompleteButton: UIButton!
    
    @IBOutlet weak var TitleText: UITextField!
    @IBOutlet weak var StartText: UITextField!
    @IBOutlet weak var EndText: UITextField!
    @IBOutlet weak var LocateText: UITextField!
    
    var datePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = UIDatePickerMode.dateAndTime
        StartText.inputView = datePicker
        EndText.inputView = datePicker
        datePicker?.addTarget(self, action: #selector(AddCalendarViewController.dateChanged(datePicker:)), for: .valueChanged)
   
        //배경 선택시 DatePicker 종료
       let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddCalendarViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        StartText.inputView = datePicker
    }
    
    //배경 탭하면 입력 종료되는 함수
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
  /*  override func viewWillAppear(_ animated: Bool) {
        if(TitleText.text?.isEmpty == true)
        {
            CompleteButton.isEnabled = false
        }
    }*/
    
   
    
 
    //시작일,종료일 입력받음. 입력 완료 후 배경 탭해야 종료 됨.
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        if(StartText.isEditing){
        StartText.text = dateFormatter.string(from: datePicker.date)
            }
        else
        {
        EndText.text =  dateFormatter.string(from: datePicker.date)
        }
    }
    
    }
   
    
   

