//
//  HomeViewController.swift
//  sagittarius-swift
//
//  Created by bonedeng on 4/16/16.
//  Copyright © 2016 xingdongyou. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController{
    
    var dataSource : HomeTableViewDataSource!
    var delegate : HomeTableViewDelegate!
    let identifier:String = "homeTableDataSource"
    
    var table : UITableView!
    var tableData : Dictionary<String, AnyObject>!
    
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
    }
    
    func requestData() ->Void {
        let homeService = HomeService();
        homeService.getDataWith(nil, success: { (data, response) -> Void in
            
            if let result = data as? Dictionary <String, AnyObject> {
                self.tableData["dailyStars"] = result["dailyStars"]
                self.tableData["recommendPlayers"] = result["recommendPlayers"]
                self.dataSource.items = self.tableData
                dispatch_async(dispatch_get_main_queue(),{ ()->() in
                    self.table.reloadData()
                })
                
            }
            
            }) { (response) -> Void in
                print("error is \(response)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

}
