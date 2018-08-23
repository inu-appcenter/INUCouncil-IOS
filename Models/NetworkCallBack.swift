//
//  NetworkCallBack.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 8. 3..
//  Copyright © 2018년 이형주. All rights reserved.
//

import Foundation

protocol NetworkCallback {
    func networkSuc(resultdata : Any, code: String)
    func networkFail(code: String)
}

protocol ViewCallback{
    func viewSuc(code : String)
    func viewFail(code : String)
}
