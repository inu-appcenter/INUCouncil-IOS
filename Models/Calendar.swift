//
//  Calendar.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 9. 21..
//  Copyright © 2018년 이형주. All rights reserved.
//

import Foundation

class Calendar: Codable {
    let title: String
    let memo: String
    let startTime: String?
    let endTime: String?
    let location: String?
    let department: String
    let startDate: String?
    let endDate: String?
    let serialID: Int
    
    enum CodingKeys: String, CodingKey {
        case title = "scheduleTitle"
        case location = "position"
        case memo, startTime, endTime, department, startDate, endDate
        case serialID = "scheduleId"
    }
}
