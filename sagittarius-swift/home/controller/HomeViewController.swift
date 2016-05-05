//
//  HomeViewController.swift
//  sagittarius-swift
//
//  Created by bonedeng on 4/16/16.
//  Copyright © 2016 xingdongyou. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Home"
        let homeService = HomeService();
        homeService.getDataWith(nil, success: { (data, response) -> Void in
            if let result = data as? Dictionary<String, AnyObject> {
                print("result is \(result)")
            }
        }) { (response) -> Void in
            print("error is \(response)")
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
