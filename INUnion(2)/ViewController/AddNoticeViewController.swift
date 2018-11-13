import UIKit
import Photos
import BSImagePicker
import Toast_Swift

class AddNoticeViewController: UIViewController,UIImagePickerControllerDelegate {
   
   @IBAction func CancelButtonClicked(_ sender: Any) {
    // 글작성 취소
    self.dismiss(animated: true, completion: nil)
    }
    @IBAction func CompleteButton(_ sender: Any) {
        // 서버전송
        startLoading()
        for i in 1..<imageArr.count{
        uploadArr.append(imageArr[i])
        }
        if noticeNumber == 0{
            // 글등록
        model?.uploadBoard(userfile: uploadArr, title: uploadTitleTextField.text!, content: UploadTextField.text!, department: (self.appDelegate.department)!)
        }else{
            // 글 수정
            model?.modifyBoard(userfile: uploadArr, title: uploadTitleTextField.text!, content: UploadTextField.text, department: (self.appDelegate.department)!, content_serial_id: String(noticeNumber))
        }
    }
    
    var imageArr = [#imageLiteral(resourceName: "PlusButton-1")]
    var uploadArr:[UIImage] = []
    var selectRow: Int?
    var buttonCount = [0,1,2,3,4,5,6,7]
    var SelectedAssets = [PHAsset]()
    var isfull : Bool = false
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var model : NetworkModel?
    var uploadResult: AnsBoolResult?
    var noticeTitle: String = ""
    var noticeContent: String = ""
    var noticeNumber: Int = 0
  
    
   @IBOutlet weak var UploadCollectionView: UICollectionView!
    @IBOutlet weak var UploadTextField: UITextView!
    @IBOutlet weak var uploadTitleTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//    self.navigationController?.navigationBar.topItem?.title = "";

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        model = NetworkModel(self)
        if noticeTitle != ""{
            uploadTitleTextField.text = noticeTitle
                            }
        if noticeContent != ""{
            UploadTextField.text = noticeContent
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startLoading(){
        self.view.makeToastActivity(.center)
    }
    func endLoading(){
        self.view.hideToastActivity()
        self.dismiss(animated: true, completion: nil)
    }
 }

extension AddNoticeViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageUploadCollectionViewCell", for: indexPath) as! ImageUploadCollectionViewCell
        cell.ImageUpload.image = imageArr[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.isSelected = true
        selectRow = buttonCount[indexPath.row]
        print(imageArr[indexPath.row])
        if selectRow == 0{
            album()
        }
        else{
            deletePhoto()
        }
    }
}


extension AddNoticeViewController{
    // 앨범 접근이 허용되었는지 파악하는 함수
    func checkIfAuthorizedToAccessPhotos(_ handler: @escaping (_ isAuthorized: Bool) -> Void) {
        switch PHPhotoLibrary.authorizationStatus() {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                DispatchQueue.main.async {
                    switch status {
                    case .authorized:
                        handler(true)
                    default:
                        handler(false)
                    }
                }
            }
        case .restricted:
            handler(false)
        case .denied:
            handler(false)
        case .authorized:
            handler(true)
        }
    }
    
    func album(){
        // 접근이 허용되었는지 체크
        checkIfAuthorizedToAccessPhotos { isAuthorized in
            DispatchQueue.main.async(execute: {
                if isAuthorized {
                    //접근허용일때
                    let imagePicker = BSImagePickerViewController()
                    imagePicker.maxNumberOfSelections = 7
                    self.bs_presentImagePickerController(imagePicker, animated: true,
                                                         select:
                        { (asset: PHAsset) -> Void in
                            print("Selected: \(asset)")
                    }, deselect: { (asset: PHAsset) -> Void in
                        print("Deselected: \(asset)")
                    }, cancel: { (assets: [PHAsset]) -> Void in
                        print("Cancel: \(assets)")
                    }, finish: { (assets: [PHAsset]) -> Void in
                        print("Finish: \(assets)")
                        for i in 0..<assets.count
                        {
                            self.SelectedAssets.append(assets[i])
                            print(self.SelectedAssets)
                        }
                        self.getAllImages()
                        self.SelectedAssets.removeAll()
                    }, completion: nil)
                } else {
                    let alert = UIAlertController(title: "에러!", message: "앨범 접근을 허용해 주세요!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }
    
    func getAllImages() -> Void {
        print("get all images method called here")
        if SelectedAssets.count != 0{
            for i in 0..<SelectedAssets.count{
                let manager = PHImageManager.default()
                let option = PHImageRequestOptions()
                var thumbnail = UIImage()
                option.isSynchronous = true
                manager.requestImage(for: SelectedAssets[i], targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: option, resultHandler: {(result, info)->Void in
                    thumbnail = result!
                })
                if imageArr.count > 7{
                    self.isfull = true
                    break
                }
                self.imageArr.append(thumbnail)
            }
            OperationQueue.main.addOperation {
                if self.isfull == false{
                    self.UploadCollectionView.reloadData()
                }else{
                   self.view.makeToast("사진은 7개가 최대입니다.")
                    self.UploadCollectionView.reloadData()
                }
            }
        }
    }
    
    func deletePhoto(){
        let alertController = UIAlertController(title: "사진을 삭제하시겠습니까?", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "삭제", style: UIAlertActionStyle.destructive) { (action:UIAlertAction) in

            self.imageArr.remove(at: self.selectRow!)
            self.UploadCollectionView.reloadData()
//            self.navigationController?.popToRootViewController(animated: true)
            
        }
        
        let cancelButton = UIAlertAction(title: "취소", style: UIAlertActionStyle.cancel, handler: nil)
        
        alertController.addAction(cancelButton)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension AddNoticeViewController:NetworkCallback{
    func networkSuc(resultdata: Any, code: String) {
        if code == "uploadProductSuccess"{
            print(resultdata)
            
            if let item = resultdata as? NSDictionary {
                let ans = item["ans"] as? Bool ?? false
                let obj = AnsBoolResult.init(ans: ans)
                self.uploadResult = obj
            }
            if uploadResult?.ans == true{
                endLoading()
            }
        }else if code == "modifyProductSuccess"{
            print(resultdata)
            
            if let item = resultdata as? NSDictionary {
                let ans = item["ans"] as? Bool ?? false
                let obj = AnsBoolResult.init(ans: ans)
                self.uploadResult = obj
            }
            if uploadResult?.ans == true{
                endLoading()
            }
        }
    }
    func networkFail(code: String) {
        if code == "uploadProductError"{
            print("실패했습니다.")
        }
    }
    
    
}
