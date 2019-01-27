
import UIKit
import FSCalendar

struct CellData {
    let image : UIImage?
    let message : String?
    let time : String?
    let title : String?
}

class CalendarViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, FSCalendarDelegate,FSCalendarDataSource {
 
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var model : NetworkModel?
    var CalendarList:[CalendarResult] = []{
        didSet{
            if self.CalendarTableView != nil{
                self.CalendarTableView.reloadData()
            }
        }
    }
    
    var SCalendarList:[CalendarResult] = []{
        didSet{
            if self.CalendarTableView != nil{
                self.CalendarTableView.reloadData()
            }
        }
    }
 

    @IBOutlet weak var CalendarTableView: UITableView!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var Label: UILabel!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "달력"
        model = NetworkModel(self)
        CalendarList.removeAll()
        SCalendarList.removeAll()
        
        model?.CalendarList(department: self.appDelegate.department!)
   
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
        return SCalendarList.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarTableViewCell") as! CalendarTableViewCell
        cell.TimeLabel.text! = SCalendarList[indexPath.row].startTime!
        cell.TitleLabel.text! = SCalendarList[indexPath.row].scheduleTitle!
        cell.ContentsLabel.text! = SCalendarList[indexPath.row].memo!
        
        return cell
    }
    
    //선택한 테이블 뷰 상세보기
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let dvc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController{
            /*dvc.getTitle = titlelabel[indexPath.row]
            dvc.getStartTime = StartTime[indexPath.row]
            dvc.getEndTime = EndTime[indexPath.row]
            dvc.getcontents = contents[indexPath.row]
            dvc.getlocation = location[indexPath.row]*/
            self.navigationController?.show(dvc, sender: nil)
        }
        
    }
    
    //테이블 뷰 삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.delete)
        {
          /*  StartTime.remove(at: indexPath.row)
            titlelabel.remove(at: indexPath.row)
            contents.remove(at: indexPath.row)
            location.remove(at: indexPath.row)
            tableView.reloadData()*/
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "달력"
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        model = NetworkModel(self)
        SCalendarList.removeAll()
         model?.CalendarList(department: self.appDelegate.department!)
    
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
        self.SCalendarList.removeAll()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        for item in CalendarList{
            let itemDate = item.startDate
            let calDate = formatter.string(from: date)
            if itemDate == calDate{
                SCalendarList.append(item)
            }
            
        }
    }
    
}

extension CalendarViewController: NetworkCallback{
    func networkSuc(resultdata: Any, code: String) {
        if code == "calendarListSuccess" {
            print(resultdata)
            
            var temp: [CalendarResult] = []
            if let items = resultdata as? [NSDictionary] {
                for item in items {
                    let scheduleTitle = item["scheduleTitle"] as? String ?? ""
                    let startTime = item["startTime"] as? String ?? ""
                    let position = item["position"] as? String ?? ""
                    let department = item["department"] as? String ?? ""
                    let memo = item["memo"] as? String ?? ""
                    let scheduleId = item["scheduleId"] as? Int ?? 0
                    let endTime = item["endTime"] as? String ?? ""
                    let endDate = item["endDate"] as? String ?? ""
                    let startDate = item["startDate"] as? String ?? ""
                    let obj = CalendarResult.init(scheduleTitle: scheduleTitle, startTime: startTime, position: position, memo: memo, department: department, scheduleId: scheduleId, endTime: endTime, endDate: endDate, startDate: startDate)
                    temp.append(obj)
                }
            }
            
            self.CalendarList = temp
            
        }
    }
    
    func networkFail(code: String) {
        if(code == "boardListError") {
            print("실패하였습니다.")
        }
        
    }
}
