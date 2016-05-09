//
//  HomeViewController+setupUI.swift
//  sagittarius-swift
//
//  Created by bonedeng on 5/6/16.
//  Copyright © 2016 xingdongyou. All rights reserved.
//

import UIKit
import ObjectiveC
private var homeAssociationKey: String = "extensionProperty"
extension HomeViewController{
    
    var extensionProperty : String {
        get {
            return objc_getAssociatedObject(self, &homeAssociationKey) as! String
        }
        set(newValue) {
            objc_setAssociatedObject(self, &homeAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    func setupUi(key: String)->Void {
        self.extensionProperty = key
        self.setNavigationView()
        self.setLayoutTable()
    }
    
    func setNavigationView() -> Void {
        let homeNavigationView = HomeNavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 64.0))
        self.view.addSubview(homeNavigationView)
    }
    
    func setLayoutTable() -> Void {
        print("key is \(self.extensionProperty)")
        self.table = UITableView(frame: CGRect(x: 0, y: 64, width: CGRectGetWidth(UIScreen.mainScreen().bounds), height: CGRectGetHeight(UIScreen.mainScreen().bounds)-64-49), style: .Plain)
        self.table.backgroundColor = UIColor(hexString: "#030c16")
        self.table.registerClass(UITableViewCell.self, forCellReuseIdentifier: self.identifier)
        self.table.separatorStyle = .None
        self.table.dataSource = self.dataSource
        self.table.delegate = self.delegate
        self.view.addSubview(self.table)
        let imageUrl = ["images.bundle/home/test/test_EPL.jpg", "images.bundle/home/test/test_NBA.jpg"]
        let carouselView = CarouselView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 113), delegate: self, imageUrls: imageUrl, placeHolderImage: "", timeInterval: 3, currentPageIndicatorColor: UIColor.whiteColor(), pageIndicatorColor: UIColor.lightGrayColor())
        self.table.tableHeaderView = carouselView
        
    }
}
