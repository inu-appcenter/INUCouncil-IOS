
import UIKit
import FSCalendar

struct CellData {
    let image : UIImage?
    let message : String?
    let time : String?
    let title : String?
    
}

class CalendarViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource, FSCalendarDelegate,FSCalendarDataSource {
 
    @IBOutlet weak var TodayEventCell: UICollectionView!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var Label: UILabel!
  
    var imageArr : NSArray = []
   
    var titlelabel : NSArray = []
     var time : NSArray = []
    var location : NSArray = []
    var contents :NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contents = ["오늘의 내용입니다~","오늘의 내용이에요~"]
        imageArr = [UIImage(named:"다현")!,UIImage(named:"Icon")!]
        time = ["13:00","14:00"]
        titlelabel = ["밥먹기","집가기"]
        
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = UIColor(red: 59/255, green: 91/255, blue: 219/255, alpha: 1)
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
        TodayEventCell.delegate = self
        TodayEventCell.dataSource = self
        calendar.dataSource = self
        calendar.delegate = self
        calendar.appearance.headerDateFormat = "YYYY년 M월 "
        Label.text = "\(calendar.year(of: calendar.currentPage))년 \(calendar.month(of: calendar.currentPage))월"
        self.calendar.appearance.headerMinimumDissolvedAlpha = 0.0;
       
        calendar.layer.cornerRadius = 10
        //CalendarTable.layer.cornerRadius = 10
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.CellLabel.text! = contents[indexPath.row] as! String
        cell.imgImage.image = imageArr[indexPath.row] as? UIImage
        cell.TimeLabel.text! = time[indexPath.row] as! String
        cell.TitleLabel.text! = titlelabel[indexPath.row] as! String
        
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.borderWidth = 1
        cell.contentView.layer.borderColor = UIColor(red: 248, green: 249, blue: 250, alpha: 1).cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        cell.layer.shadowRadius = 1
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        return cell
        
    }
    
    //선택한 테이블 뷰 상세보기
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let DvC = Storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        DvC.getImage = imageArr[indexPath.row] as! UIImage
        DvC.getTitle = titlelabel[indexPath.row] as! String
        DvC.getTime = time[indexPath.row] as! String
       // DvC.getlocation = location[indexPath.row] as! String
        DvC.getcontents = contents[indexPath.row] as! String
        self.navigationController?.pushViewController(DvC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
   
    // 이벤트 점
  /*  func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return 1
    }*/
    
    func calendarCurrentMonthDidChange(_ calendar: FSCalendar) {
       Label.text = "\(calendar.year(of: calendar.currentPage))년 \(calendar.month(of: calendar.currentPage))월"
    }
    
    // 날짜 연동
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date)
    }
    
}
