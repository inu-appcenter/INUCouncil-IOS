import UIKit
import Photos

class AddNoticeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate {
   
    //앨범에서 사진 선택
    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        return picker
    }()
    //사진 선택 끄기
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    // 이미지 추가 7개 초과시 종료
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            if imageArr.count > 7{
                dismiss(animated: true) {
                }
            }else{
                imageArr.append(originalImage)
                OperationQueue.main.addOperation {
                    self.UploadCollectionView.reloadData()
                }
                dismiss(animated: true, completion: nil)
            }
        }
}
    
   @IBAction func CancelButtonClicked(_ sender: Any) {
    navigationController.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func CompleteButton(_ sender: Any) {
        var postTextview = UploadTextField
        var postImageArray : [UIImage] = []
        for i in 1..<imageArr.count{
            postImageArray.append(imageArr[i])
            //ViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    var photomaximum : Int = 0
    var imageArr = [#imageLiteral(resourceName: "PlusButton-1")]

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageUploadCollectionViewCell", for: indexPath) as! ImageUploadCollectionViewCell
        cell.ImageUpload.image = imageArr[IndexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          return imageArr.count
    }
    
   @IBOutlet weak var UploadCollectionView: UICollectionView!
    @IBOutlet weak var UploadTextField: UITextView!
 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    self.navigationController?.navigationBar.topItem?.title = "";

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
