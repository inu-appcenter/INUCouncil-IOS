import Foundation
import Alamofire
import CodableAlamofire

class NetworkModel {
    
    var view: NetworkCallBack
    
    init (_ view: NetworkCallBack) {
        self.view = view
    }
}

//MARK: Login
extension NetworkModel {
    func login(userName: String, password: String) {
        let param = ["username": userName,
                     "password": password]
        
        let header = ["Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
                      "Content-Type" : "application/x-www-form-urlencoded"]
        
        Alamofire.request(ServerUrls.login.rawValue, method: .post, parameters: param, headers: header).responseJSON { response in
            switch response.result {
            case .success(let item):
                self.view.networkSuccess(data: item, code: "login")
            case .failure(let error):
                print(error)
                self.view.networkFail(code: "login")
            }
        }
    }
}


//MARK: Post
extension NetworkModel {
    func getBoardList(department: String){
        let param = ["department": department]
        
        let header = ["Content-Type" : "application/x-www-form-urlencoded"]
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        Alamofire.request(ServerUrls.board.rawValue, method: .post, parameters: param, headers: header).responseDecodableObject(decoder: decoder) {(response: DataResponse<[Post]>) in
            switch response.result {
            case .success(let item):
                self.view.networkSuccess(data: item, code: "boardList")
            case .failure(let error):
                self.view.networkFail(code: "boardList")
                print(error)
            }
        }
    }
    
    func uploadPost(userfile: [UIImage] ,title: String, content: String, department:String){
        let params: Parameters = [
            "title" : title,
            "content" : content,
            "department" : department]
        Alamofire.upload(multipartFormData: { multipartFormData in
            for (key,value) in params {
                if let value = value as? String {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
            }
            for index in 0..<userfile.count {
                var data = UIImagePNGRepresentation(userfile[index])
                if data != nil {
                    // PNG
                    multipartFormData.append(data!, withName: "userfile",fileName: "userfile", mimeType: "image/png")
                } else {
                    // jpg
                    data = UIImageJPEGRepresentation(userfile[index], 0.5)
                    multipartFormData.append((data?.base64EncodedData())!, withName: "userfile",fileName: "userfile", mimeType: "image/jpeg")
                }
            }
        },
                         to: ServerUrls.boardUpload.rawValue,
                         headers: ["Content-Type" : "multipart/form-data"],
                         encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload.responseJSON{ res in
                                    switch res.result{
                                    case .success(let item):
                                        self.view.networkSuccess(data: item, code: "postUploaded")
                                        break
                                    case .failure(let error):
                                        print(error)
                                        self.view.networkFail(code: "postUploaded")
                                        break
                                    }
                                }
                            case .failure(let encodingError):
                                print(encodingError)
                            }
        }
        )
    }
    
    func modifyPost(userfile: [UIImage] ,title: String, content: String, department:String, content_serial_id: Int){
        let params: Parameters = [
            "title" : title,
            "content" : content,
            "department" : department,
            "content_serial_id": "\(content_serial_id)"]
        Alamofire.upload(multipartFormData: { multipartFormData in
            for (key,value) in params {
                if let value = value as? String {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
            }
            for index in 0..<userfile.count {
                var data = UIImagePNGRepresentation(userfile[index])
                if data != nil {
                    // PNG
                    multipartFormData.append(data!, withName: "userfile",fileName: "userfile", mimeType: "image/png")
                } else {
                    // jpg
                    data = UIImageJPEGRepresentation(userfile[index], 0.5)
                    multipartFormData.append((data?.base64EncodedData())!, withName: "userfile",fileName: "userfile", mimeType: "image/jpeg")
                }
            }
        },
                         to: ServerUrls.boardModify.rawValue,
                         headers: ["Content-Type" : "multipart/form-data"],
                         encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload.responseJSON{ res in
                                    switch res.result{
                                    case .success(let item):
                                        self.view.networkSuccess(data: item, code: "postModified")
                                        break
                                    case .failure(let error):
                                        print(error)
                                        self.view.networkFail(code: "postModified")
                                        break
                                    }
                                }
                            case .failure(let encodingError):
                                print(encodingError)
                            }
        }
        )
    }
    
    func deletePost(content_serial_id: Int){
        let param = ["content_serial_id": "\(content_serial_id)"]
        
        let header = ["Content-Type" : "application/x-www-form-urlencoded"]
        
        Alamofire.request(ServerUrls.boardDelete.rawValue, method: .post, parameters: param, headers: header).responseJSON { response in
            switch response.result{
            case .success(let item):
                self.view.networkSuccess(data: item, code: "postDeleted")
                
            case .failure(let error):
                self.view.networkFail(code: "postDeleted")
                print(error)
            }
        }
    }
}

//MARK: Calendar
extension NetworkModel {
    func getCalendar(department: String) {
        let param = ["department": department]
        
        let header = ["Content-Type" : "application/x-www-form-urlencoded"]
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        Alamofire.request(ServerUrls.calendar.rawValue, method: .post, parameters: param, headers: header).responseDecodableObject(decoder: decoder) {(response: DataResponse<[Calendar]>) in
            switch response.result {
            case .success(let item):
                self.view.networkSuccess(data: item, code: "calendarList")
            case .failure(let error):
                self.view.networkFail(code: "calendarList")
                print(error)
            }
        }
    }
    
    func uploadCalendar(title: String, startTime: String, endTime: String, startDate: String, endDate: String, memo: String?, location: String, department: String) {
        let params: Parameters = [
            "scheduleTitle" : title,
            "startTime" : startTime,
            "position" : location,
            "memo" : memo ?? "",
            "department" : department,
            "endTime" : endTime,
            "startDate" : startDate,
            "endDate" : endDate]
        
        let url = URL.init(string: ServerUrls.calendarUpload.rawValue)
        
        Alamofire.request(url!, method: .post, parameters: params, headers: ["Content-Type" : "application/x-www-form-urlencoded"]).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(let item):
                self.view.networkSuccess(data: item, code: "calendarUploaded")
            case .failure(let error):
                print(error)
                self.view.networkFail(code: "calendarUploaded")
            }
        })
    }
    
    func modifyCalendar(title: String, startTime: String, endTime: String, startDate: String, endDate: String, memo: String?, location: String, department: String, serialID: Int) {
        let params: Parameters = [
            "scheduleTitle" : title,
            "startTime" : startTime,
            "position" : location,
            "memo" : memo ?? "",
            "department" : department,
            "endTime" : endTime,
            "startDate" : startDate,
            "endDate" : endDate,
            "scheduleId" : serialID]
        
        let url = URL.init(string: ServerUrls.calendarModify.rawValue)
        
        Alamofire.request(url!, method: .post, parameters: params, headers: ["Content-Type" : "application/x-www-form-urlencoded"]).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(let item):
                self.view.networkSuccess(data: item, code: "calendarModified")
            case .failure(let error):
                print(error)
                self.view.networkFail(code: "calendarModified")
            }
        })
    }
    
    func deleteCalendar(serialID: Int) {
        let param: Parameters = [
            "scheduleId" : serialID]
        
        let url = URL.init(string: ServerUrls.calendarDelete.rawValue)
        
        Alamofire.request(url!, method: .post, parameters: param, headers: ["Content-Type" : "application/x-www-form-urlencoded"]).responseJSON { response in
            switch response.result {
            case .success(let item):
                self.view.networkSuccess(data: item, code: "calendarDelete")
            case .failure(let error):
                print(error)
                self.view.networkFail(code: "calendarDelete")
            }
        }
    }
}

//MARK: Contact
extension NetworkModel {
    func getContact(department: String) {
        let param: Parameters = [
            "department" : department]
        
        let url = URL.init(string: ServerUrls.contact.rawValue)
        
        Alamofire.request(url!, method: .post, parameters: param, headers: ["Content-Type" : "application/x-www-form-urlencoded"]).responseDecodableObject{ (response: DataResponse<[Contact]>) in
            switch response.result {
            case .success(let item):
                self.view.networkSuccess(data: item, code: "contact")
            case .failure(let error):
                print(error)
                self.view.networkFail(code: "contact")
            }
        }
    }
    
    func modifyContact(name: String, phoneNumber: String, email: String, location: String, etc: String, department: String, serialID: Int) {
        let params: Parameters = [
            "name" : name,
            "phoneNumber" : phoneNumber,
            "email" : email,
            "position" : location,
            "etc" : etc,
            "department" : department,
            "addressId" : serialID]
        
        let url = URL.init(string: ServerUrls.contactModify.rawValue)
        
        Alamofire.request(url!, method: .post, parameters: params, headers: ["Content-Type" : "application/x-www-form-urlencoded"]).responseJSON { response in
            switch response.result {
            case .success(let item):
                self.view.networkSuccess(data: item, code: "contactModified")
            case .failure(let error):
                print(error)
                self.view.networkFail(code: "contactModified")
            }
        }
    }
    
    func uploadContact(name: String, phoneNumber: String, email: String, location: String, etc: String, department: String) {
        let params: Parameters = [
            "name" : name,
            "phoneNumber" : phoneNumber,
            "email" : email,
            "position" : location,
            "etc" : etc,
            "department" : department]
        
        let url = URL.init(string: ServerUrls.contactUpload.rawValue)
        
        Alamofire.request(url!, method: .post, parameters: params, headers: ["Content-Type" : "application/x-www-form-urlencoded"]).responseJSON { response in
            switch response.result {
            case .success(let item):
                self.view.networkSuccess(data: item, code: "contactUpload")
            case .failure(let error):
                print(error)
                self.view.networkFail(code: "contactUpload")
            }
        }
    }
    
    func deleteContact(serialID: Int) {
        let param: Parameters = [
            "addressId" : serialID]
        
        let url = URL.init(string: ServerUrls.contactDelete.rawValue)
        
        Alamofire.request(url!, method: .post, parameters: param, headers: ["Content-Type" : "application/x-www-form-urlencoded"]).responseJSON { response in
            switch response.result {
            case .success(let item):
                self.view.networkSuccess(data: item, code: "contactDeleted")
            case .failure(let error):
                print(error)
                self.view.networkFail(code: "contactDeleted")
            }
        }
    }
}

