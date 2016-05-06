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
    
    var table : UITableView!
    var tableData : Dictionary<String, AnyObject>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableData = Dictionary<String, AnyObject>();
        
        dataSource = HomeTableViewDataSource(aIdentifier: "homeTableDataSource", aItems: tableData)
        delegate = HomeTableViewDelegate(aCellSelect: { (indexPath) -> Void in
            
        })
        
        table = UITableView(frame: CGRect(x: 0, y: 64, width: CGRectGetWidth(UIScreen.mainScreen().bounds), height: CGRectGetHeight(UIScreen.mainScreen().bounds)-64-49), style: .Grouped)
        
        
        self.navigationController?.navigationBarHidden = true
        let homeService = HomeService();
        homeService.getDataWith(nil, success: { (data, response) -> Void in
            if let result = data as? Dictionary <String, AnyObject> {
                
                self.tableData["dailyStars"] = result["dailyStars"]
                self.tableData["recommendPlayers"] = result["recommendPlayers"]
                self.table.reloadData()
                
            }
        }) { (response) -> Void in
            print("error is \(response)")
        }
        self.setNavigationView()
        self.setLayoutTable()
        
        // Do any additional setup after loading the view.
    }
    
    func setNavigationView() -> Void {
        let homeNavigationView = HomeNavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 64.0))
        self.view.addSubview(homeNavigationView)
    }
    
    func setLayoutTable() -> Void {
        table.dataSource = dataSource
        table.delegate = delegate
        view.addSubview(table)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

}
