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
    var timeSave: String?
    var fileName:[String]?
    
    init(content_serial_id: Int, title: String, content:String, department:String, timeSave:String, fileName:[String]){
        self.content_serial_id = content_serial_id
        self.title = title
        self.content = content
        self.department = department
        self.timeSave = timeSave
        self.fileName = fileName
                                            }
    
}

// 공지사항 디테일
class BoardDetail{

    var content_serial_id: Int?
    var title: String?
    var content: String?
    var department: String?
    var timeSave: String?
    var fileName:[String]?
    
    init(content_serial_id:Int, title:String, content:String, department:String, timeSave:String,fileName: [String]) {
        self.content_serial_id = content_serial_id
        self.timeSave = timeSave
        self.content = content
        self.department = department
        self.title = title
        self.fileName = fileName
    }
}

class DirectoryName{
    var name: String?
    
    init(name:String){
        self.name = name
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

