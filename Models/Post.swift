//
//  Post.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 9. 21..
//  Copyright © 2018년 이형주. All rights reserved.
//


import Foundation

class Post: Codable {
    let content: String
    let contentSerialID: Int
    let department: String
    let fileName: [String]
    let timeSave: String
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case content
        case department
        case fileName
        case timeSave
        case title
        case contentSerialID = "content_serial_id"
    }
}
