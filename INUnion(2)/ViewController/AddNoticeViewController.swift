import UIKit
import Photos

class AddNoticeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate {
   
    
    var imageArr = [#imageLiteral(resourceName: "PlusButton-1")]
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
  
 
    @IBOutlet weak var UploadUpload: UICollectionView!
    
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

