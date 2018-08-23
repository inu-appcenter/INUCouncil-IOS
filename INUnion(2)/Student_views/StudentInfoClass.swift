//
//  StudentInfoCalss.swift
//  INUnion(2)
//
//  Created by 유용상 on 2018. 8. 10..
//  Copyright © 2018년 이형주. All rights reserved.
//


/*
 학생의 정보를 저장하는 클래스.
 FirstMajor : 주전공
 SecondMAjor : 복수전공
 */

import Foundation

class Student{
    var FirstMajor: String = ""
    var SecondMajor: String = "없음"
    
}

var PersonInfo = Student()

let MajoruserDefault = UserDefaults.standard

let SecondMajorUserDefault = UserDefaults.standard


func is_mainMajor()->Bool{
    
    /*
     주전공이 영구 저장 되었는지 확인하는 함수.
     전공이 String 형태로 저장이 되어 있을 경우 true 반환.
     만약 저장이 안 되어 있으면 false 반환.
     */
    
    if MajoruserDefault.object(forKey: "FirstMajor") != nil{ // 전공이 영구 저장된 객체인가?
        return true
    }
    else{
        return false
    }
}
