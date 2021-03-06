//
//  HomeViewController.swift
//  sagittarius-swift
//
//  Created by bonedeng on 4/16/16.
//  Copyright © 2016 xingdongyou. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, CarouselViewDelegate{
    
    var dataSource : HomeTableViewDataSource!
    var delegate : HomeTableViewDelegate!
    let identifier:String = "homeTableDataSource"
    
    var table : UITableView!
    var tableData : Dictionary<String, AnyObject>!
    var carouselView: CarouselView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("enmu is \(Constant.contestStatus.Cancelled.rawValue)")
        
        self.tableData = Dictionary<String, AnyObject>();
        dataSource = HomeTableViewDataSource(aIdentifier: self.identifier)
        
        delegate = HomeTableViewDelegate(aCellSelect: { (indexPath) -> Void in
            print("clicked");
        })
        self.navigationController?.navigationBarHidden = true
        self.setupUi("-----babababab");
        self.requestData()
//        self.test()
        
    }
    
//    func test() {
//        let persons = [["name": "张三", "age": 12], ["name": "李四", "age" :10], ["name":"王五", "age": 18], ["name": "王二", "age" : 15]]
//    
//        
//        let array = persons.map { (x: [String : NSObject]) -> [String : NSObject] in
//            let age =  x["age"] as! Int
//            return ["name": x["name"]!, "age": age*2]
//        }
//    
//        let result = persons.find { (x: [String: NSObject]) -> Bool in
//            return x["name"] as! String == "王二"
//        }
//    
//        print("array is \(array)")
//        
//    }
    
    func requestData() ->Void {
        
        let success :SuccessedHttpRequestHandler = { (data, response) -> Void in
            
            if let result = data as? Dictionary <String, AnyObject> {
                self.tableData["dailyStars"] = result["dailyStars"]
                self.tableData["recommendPlayers"] = result["recommendPlayers"]
                self.dataSource.items = self.tableData
                self.table.reloadData()
            }
            
        }
        
        let failure: FailureHttpRequestHandler = {(response) -> Void in
            print("error is \(response)")
        }
        
        HomeService.sharedInstance.getDataWith(nil, success: success, failure: failure);
        
        HomeService.sharedInstance.getCarousel({ (data, response) -> Void in
            
            if let result = data as? [AnyObject] {
                print("data is \(result)")
                self.carouselView.setImages(result)
            }
            
            }) { (response) -> Void in
                
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func didClickedImageAtIndex(index: Int) {
        print("clicked at \(index)")
    }

}
