//
//  AddCalendarViewController.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 9. 1..
//  Copyright © 2018년 이형주. All rights reserved.
//

import UIKit


class AddCalendarViewController: UIViewController,UITextViewDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var model : NetworkModel?
    var uploadResult: AnsBoolResult?
    
    @IBOutlet weak var MemoTextView: UITextView!
    @IBOutlet weak var InputTextLabel: UILabel!
    
    @IBOutlet weak var MaximulLabel: UILabel!
    
    @IBAction func CompleteButtonClicked(_ sender: Any)
    {
        if ScheduleId == 0 {
          model?.upLoadCalendar(scheduleTitle: TitleText.text!, startTime: StartTime, position: LocateText.text!, memo: MemoTextView.text!, department: (self.appDelegate.department)!, endTime: EndTime, startDate: StartDate, endDate: EndDate)
          
        }
        
        
        
    }
    
    
    @IBAction func XbuttnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var CompleteButton: UIButton!
    
    @IBOutlet weak var TitleText: UITextField!
    @IBOutlet weak var StartText: UITextField!
    @IBOutlet weak var EndText: UITextField!
    @IBOutlet weak var LocateText: UITextField!
    
    var Title: String = ""
    var StartTime: String = ""
    var EndTime: String = ""
    var Locate: String = ""
    var Memo: String = ""
    var StartDate: String = ""
    var EndDate: String = ""
    var ScheduleId: Int = 0
    
    var datePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model = NetworkModel(self)
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
  
        
        var EndTime: String = ""
        var Locate: String = ""
        var Memo: String = ""
        var StartDate: String = ""
        var EndDate: String = ""
        var ScheduleId: Int = 0
        
        
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
        let timeFormatter = DateFormatter()
        
        timeFormatter.dateFormat = "HH:mm:00"
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if(StartText.isEditing){
            
            StartText.text = "\(dateFormatter.string(from: datePicker.date)) \(timeFormatter.string(from: datePicker.date))"
            StartDate = dateFormatter.string(from: datePicker.date)
            StartTime = timeFormatter.string(from: datePicker.date)
        }
        else
        {
            EndText.text = "\(dateFormatter.string(from: datePicker.date)) \(timeFormatter.string(from: datePicker.date))"
            EndDate = dateFormatter.string(from: datePicker.date)
            EndTime = timeFormatter.string(from: datePicker.date)
        }
    }
}


extension AddCalendarViewController:NetworkCallback{
    func networkSuc(resultdata: Any, code: String) {
        if code == "CalendarSaveSuccess"{
            print(resultdata)
            if let item = resultdata as? NSDictionary {
                let ans = item["ans"] as? Bool ?? false
                let obj = AnsBoolResult.init(ans: ans)
                self.uploadResult = obj
                self.dismiss(animated: true, completion: nil)

            }
        }
    }
    func networkFail(code: String) {
        if code == "DirectorySaveFail"{
            print("실패했습니다.")
        }
    }
    
    
}



    
   

