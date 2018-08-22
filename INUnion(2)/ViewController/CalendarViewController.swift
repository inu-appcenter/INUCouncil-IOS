
import UIKit
import FSCalendar

struct CellData {
    let image : UIImage?
    let message : String?
    let time : String?
    let title : String?
    
}

class CalendarViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, FSCalendarDelegate,FSCalendarDataSource {
 
    @IBOutlet weak var CalendarTableView: UITableView!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var Label: UILabel!
  
    var titlelabel : NSArray = []
    var time : NSArray = []
    var location : NSArray = []
    var contents :NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        time = ["13:00","14:00"]
        titlelabel = ["밥먹기","집가기"]
        contents = ["밥드세요","집에가세요"]
        location = ["맥도날드","집"]
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = UIColor(red: 59/255, green: 91/255, blue: 219/255, alpha: 1)
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
        CalendarTableView.delegate = self
        CalendarTableView.dataSource = self
        calendar.dataSource = self
        calendar.delegate = self
        calendar.appearance.headerDateFormat = "YYYY년 M월 "
        Label.text = "\(calendar.year(of: calendar.currentPage))년 \(calendar.month(of: calendar.currentPage))월"
   
     self.calendar.appearance.headerMinimumDissolvedAlpha = 0.0;
            calendar.layer.cornerRadius = 10
            CalendarTableView.layer.cornerRadius = 10

      
       
    }
  
    //테이블 갯수 몇개인지
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titlelabel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarTableViewCell") as! CalendarTableViewCell
       cell.TimeLabel.text! = time[indexPath.row] as! String
        cell.TitleLabel.text! = titlelabel[indexPath.row] as! String
        cell.ContentsLabel.text! = contents[indexPath.row] as! String
       
        return cell
    }
    
    //선택한 테이블 뷰 상세보기
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let DvC = Storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
    
        DvC.getTitle = titlelabel[indexPath.row] as! String
        DvC.getTime = time[indexPath.row] as! String
        DvC.getcontents = contents[indexPath.row] as! String
        DvC.getlocation = location[indexPath.row] as! String
        
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
