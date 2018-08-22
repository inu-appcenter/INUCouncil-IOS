/*import UIKit
import FSCalendar

struct CellData2 {
    let image : UIImage?
    let message : String?
}

class StudentCalendarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FSCalendarDelegate,FSCalendarDataSource {
    
    
    @IBOutlet weak var calendar: FSCalendar!
 
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var CalendarTable: UITableView!
    var name:NSArray = []
    var imageArr:NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name = ["image1","image2"]
        imageArr = [UIImage(named: "다현")!,UIImage(named: "Icon")!]
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = UIColor(red: 59/255, green: 91/255, blue: 219/255, alpha: 1)
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
        CalendarTable.delegate = self
        CalendarTable.dataSource = self
        calendar.dataSource = self
        calendar.delegate = self
        calendar.appearance.headerDateFormat = "YYYY년 M월 "
        Label.text = "\(calendar.year(of: calendar.currentPage))년 \(calendar.month(of: calendar.currentPage))월"
        self.calendar.appearance.headerMinimumDissolvedAlpha = 0.0;
        
        calendar.layer.cornerRadius = 10
        CalendarTable.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    //테이블 갯수 몇개인지
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        
        cell.imgImage.image = imageArr[indexPath.row] as? UIImage //tableviewcell에 지정한 이미지랑 라벨
        cell.CellLabel.text! = name[indexPath.row] as! String
        
        return cell
    }
    
    //선택한 테이블 뷰 상세보기로 넘어가기
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let DvC = Storyboard.instantiateViewController(withIdentifier: "StudentDetailViewController") as! StudentDetailViewController
        DvC.getImage = imageArr[indexPath.row] as! UIImage
        DvC.getname = name[indexPath.row] as! String
        self.navigationController?.pushViewController(DvC, animated: true)
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
*/
