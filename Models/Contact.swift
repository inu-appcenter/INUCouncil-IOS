//
//  Contact.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 9. 21..
//  Copyright © 2018년 이형주. All rights reserved.
//
import Foundation

class Contact: Codable {
    let name: String
    let phoneNumber: String
    let email: String
    let location: String
    let etc: String
    let serialID: Int
    let department: String
    
    enum CodingKeys: String, CodingKey {
        case name, phoneNumber, email, etc, department
        case location = "position"
        case serialID = "addressId"
    }
}
