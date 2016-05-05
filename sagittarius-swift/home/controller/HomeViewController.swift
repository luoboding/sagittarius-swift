//
//  HomeViewController.swift
//  sagittarius-swift
//
//  Created by bonedeng on 4/16/16.
//  Copyright © 2016 xingdongyou. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var table = UITableView(frame: UIScreen.mainScreen().bounds, style: .Grouped)
    var tableData : Dictionary<String, AnyObject>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        let homeService = HomeService();
        homeService.getDataWith(nil, success: { (data, response) -> Void in
            if let result = data as? Dictionary<String, AnyObject> {
                print("result is \(result)")
            }
        }) { (response) -> Void in
            print("error is \(response)")
        }
        self.setNavigationView()
        

        // Do any additional setup after loading the view.
    }
    
    func setNavigationView() -> Void {
        let homeNavigationView = HomeNavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 64.0))
        self.view.addSubview(homeNavigationView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
