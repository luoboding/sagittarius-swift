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
        var heightForHeader: CGFloat;
        switch(section) {
        case 0:
            heightForHeader = 5
        case 3:
            heightForHeader = 55
        default:
            heightForHeader = 30
        }
        return heightForHeader
    }
}
