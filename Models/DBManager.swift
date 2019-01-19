//
//  DBManager.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 8. 29..
//  Copyright © 2018년 이형주. All rights reserved.
//

import Foundation

// 로그인 결과 확인
class AnsResult{
    var ans : Bool?
    var department : String?
    
    init(ans : Bool, department: String){
        self.ans = ans
        self.department = department
    }
}
// 결과 확인
class AnsBoolResult{
    var ans: Bool?
    
    init(ans:Bool){
        self.ans = ans
    }
}

//공지사항 불러오기

class NoticeResult{
    var content_serial_id: Int?
    var title: String?
    var content: String?
    var department: String?
    var date: String?
    var fileName:[String]?
    
    init(content_serial_id: Int, title: String, content:String, department:String, date:String, fileName:[String]){
        self.content_serial_id = content_serial_id
        self.title = title
        self.content = content
        self.department = department
        self.date = date
        self.fileName = fileName
                                            }
    
}

// 공지사항 디테일
class BoardDetail{

    var content_serial_id: Int?
    var title: String?
    var content: String?
    var department: String?
    var date: String?
    var fileName:[String]?
    
    init(content_serial_id:Int, title:String, content:String, department:String, date:String,fileName: [String]) {
        self.content_serial_id = content_serial_id
        self.date = date
        self.content = content
        self.department = department
        self.title = title
        self.fileName = fileName
    }
}

class DirectoryName{
    var name: String?
    var phoneNumber: String?
    var email: String?
    var position: String?
    var etc: String?
    var addressId: Int?
    var department: String?
    
    init(name: String, phoneNumber: String, email:String, position:String, etc:String, addressId:Int, department: String){
        
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
        self.position = position
        self.etc = etc
        self.addressId = addressId
        self.department = department
    }
}

class DirectoryDetail{
    var name: String?
    var phoneNumber: String?
    var email: String?
    var position: String?
    var etc: String?
    var addressId: Int?
    var department: String?
    
    init(name: String, phoneNumber: String, email:String, position:String, etc:String, addressId: Int, department: String){
      
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
        self.position = position
        self.etc = etc
        self.addressId = addressId
        self.department = department
    }
}

//캘린더 불러오기
    class CalendarResult{
        var scheduleTitle: String?
        var startTime: String?
        var position: String?
        var memo: String?
        var department: String?
        var scheduleId: Int?
        var endTime: String?
        var endDate: String?
        var startDate: String?
        
        init(scheduleTitle: String, startTime: String, position: String, memo:String, department: String, scheduleId: Int, endTime: String, endDate: String, startDate: String)
        {
            self.scheduleTitle = scheduleTitle
            self.startTime = startTime
            self.position = position
            self.memo = memo
            self.department = department
            self.scheduleId = scheduleId
            self.endTime = endTime
            self.endDate = endDate
            self.startDate = startDate
        }
        
    }




