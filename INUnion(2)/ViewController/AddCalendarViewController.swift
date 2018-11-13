//
//  AddCalendarViewController.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 9. 1..
//  Copyright © 2018년 이형주. All rights reserved.
//

import UIKit

class AddCalendarViewController: UIViewController,UITextViewDelegate {
    
    @IBOutlet weak var MemoTextView: UITextView!
    @IBOutlet weak var InputTextLabel: UILabel!
    
    @IBOutlet weak var MaximulLabel: UILabel!
    @IBAction func CompleteButtonClicked(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
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
        
        
        InputTextLabel.text = "0"
        MemoTextView.text = "내용을 적어주세요"
        MemoTextView.textColor = UIColor.lightGray
        MemoTextView.delegate = self
        
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
    
    //입력 글자 수 Count
    func checkRemaingChars(){
        let charsInTextView = (MemoTextView.text.characters.count)
        let remainingChars = charsInTextView
        InputTextLabel.text = String(remainingChars)
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        checkRemaingChars()
    }
    
    //텍스트 뷰 Placeholder
    func textViewDidBeginEditing(_ textView: UITextView) {
        if MemoTextView.text == "내용을 적어주세요" {
            MemoTextView.text = ""
            MemoTextView.textColor = UIColor.black
        }
    }
    
    //텍스트 뷰 글자수 제한 300자
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        return updatedText.count <= 300 // Change limit based on your requirement.
    }
    
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



    
   

