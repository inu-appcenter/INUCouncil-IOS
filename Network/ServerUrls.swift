//
//  ServerUrls.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 9. 22..
//  Copyright © 2018년 이형주. All rights reserved.
//

import Foundation

enum ServerUrls: String {
    case login = "http://117.16.231.66:7001/login/"
    case board = "http://117.16.231.66:7001/boardSelect/"
    case boardModify = "http://117.16.231.66:7001/boardModify/"
    case imageLoad = "http://117.16.231.66:7001/imgload/"
    case boardUpload = "http://117.16.231.66:7001/boardSave/"
    case boardDelete = "http://117.16.231.66:7001/boardDelete/"
    case calendar = "http://117.16.231.66:7001/calendarSelect/"
    case calendarUpload = "http://117.16.231.66:7001/calendarSave/"
    case calendarModify = "http://117.16.231.66:7001/calendarModify/"
    case calendarDelete = "http://117.16.231.66:7001/calendarDelete/"
    case contact = "http://117.16.231.66:7001/addressSelectAll/"
    case contactModify = "http://117.16.231.66:7001/addressModify/"
    case contactUpload = "http://117.16.231.66:7001/addressSave/"
    case contactDelete = "http://117.16.231.66:7001/addressDelete/"
}
