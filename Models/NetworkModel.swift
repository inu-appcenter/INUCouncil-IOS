//
//  NetworkModel.swift
//  INUnion(2)
//
//  Created by 이형주 on 2018. 8. 3..
//  Copyright © 2018년 이형주. All rights reserved.
//

import Foundation


import Alamofire
import UIKit

class NetworkModel{

private let serverURL = "http://117.16.231.66:7001"
    var view : NetworkCallback
    init(_ view: NetworkCallback) {
        self.view = view
    }

    func login(username: String, password: String) {
      
        let param = ["username": username,
                     "password": password]
        
        let header = ["Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            "Content-Type" : "application/x-www-form-urlencoded"]
        
        Alamofire.request("\(serverURL)/login", method: .post, parameters: param, headers: header).responseJSON { response in
            switch response.result{
            case .success:
                print("login succes")
            case .failure(let error):
                print(error)
            
            }
        }
    }

class ViewModel{
    var view: ViewCallback
    init(_ view: ViewCallback){
        self.view = view
    }
    func letter() {
        self.view.viewSuc(code: "letter")
    }
}
 }
