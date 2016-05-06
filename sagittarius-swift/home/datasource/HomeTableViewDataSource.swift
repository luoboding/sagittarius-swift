//
//  HomeTableViewDataSource.swift
//  sagittarius-swift
//
//  Created by bonedeng on 5/6/16.
//  Copyright © 2016 xingdongyou. All rights reserved.
//

import UIKit

class HomeTableViewDataSource: NSObject, UITableViewDataSource {
    
    var identifier:String!
    var items: Dictionary<String, AnyObject>!
    
    init(aIdentifier: String) {
        identifier = aIdentifier
        items = Dictionary<String, AnyObject>()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier(self.identifier, forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = "呼呼"
        return cell
    }
}
