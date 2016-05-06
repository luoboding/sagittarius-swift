//
//  HomeTableViewDelegate.swift
//  sagittarius-swift
//
//  Created by bonedeng on 5/6/16.
//  Copyright © 2016 xingdongyou. All rights reserved.
//

import UIKit

typealias TableCellSelect = (indexPath: NSIndexPath)->Void

class HomeTableViewDelegate: NSObject, UITableViewDelegate{
    
    var cellSelect: TableCellSelect!
    
    init(aCellSelect: TableCellSelect) {
        cellSelect = aCellSelect
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        cellSelect(indexPath: indexPath)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 65;
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: CGRectGetWidth(UIScreen.mainScreen().bounds), height: 100))
        view.backgroundColor = UIColor.redColor()
        return view
    }
}
