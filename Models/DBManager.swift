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
    var keyNum:Int?
    var fileName:[String]?
    var fileKey:Int?
    
    init(content_serial_id: Int, title: String, content:String, department:String, timeSave:String, keyNum:Int, fileName:[String], fileKey:Int){
        self.content_serial_id = content_serial_id
        self.title = title
        self.content = content
        self.department = department
        self.timeSave = timeSave
        self.keyNum = keyNum
        self.fileName = fileName
        self.fileKey = fileKey
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
