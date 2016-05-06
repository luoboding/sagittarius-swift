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
        
        self.tableData = Dictionary<String, AnyObject>();
        
        dataSource = HomeTableViewDataSource(aIdentifier: self.identifier, aItems: self.tableData)
        delegate = HomeTableViewDelegate(aCellSelect: { (indexPath) -> Void in
            print("clicked");
        })
        
        self.navigationController?.navigationBarHidden = true
        
        self.setNavigationView()
        self.setLayoutTable()
        self.requestData()
    }
    
    func requestData() ->Void {
        let homeService = HomeService();
        homeService.getDataWith(nil, success: { (data, response) -> Void in
            
            if let result = data as? Dictionary <String, AnyObject> {
                self.tableData["dailyStars"] = result["dailyStars"]
                self.tableData["recommendPlayers"] = result["recommendPlayers"]
//                print("table data is \(self.tableData)")
                self.dataSource.items = self.tableData
                dispatch_async(dispatch_get_main_queue(),{ ()->() in
                    self.table.reloadData()
                })
                
            }
            
            }) { (response) -> Void in
                print("error is \(response)")
        }
    }
    
    func setNavigationView() -> Void {
        let homeNavigationView = HomeNavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 64.0))
        self.view.addSubview(homeNavigationView)
    }
    
    func setLayoutTable() -> Void {
        
        self.table = UITableView(frame: CGRect(x: 0, y: 64, width: CGRectGetWidth(UIScreen.mainScreen().bounds), height: CGRectGetHeight(UIScreen.mainScreen().bounds)-64-49), style: .Grouped)
        self.table.registerClass(UITableViewCell.self, forCellReuseIdentifier: self.identifier)
        self.table.dataSource = self.dataSource
        self.table.delegate = self.delegate
        self.view.addSubview(self.table)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

}
