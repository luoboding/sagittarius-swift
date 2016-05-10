//
//  HomeViewController+setupUI.swift
//  sagittarius-swift
//
//  Created by bonedeng on 5/6/16.
//  Copyright © 2016 xingdongyou. All rights reserved.
//

import UIKit
import ObjectiveC
import SnapKit
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
        let homeNavigationView = HomeNavigationView()
        self.view.addSubview(homeNavigationView)
        homeNavigationView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.view).offset(0)
            make.width.equalTo(self.view.frame.width)
            make.height.equalTo(64.0)
        }
    }
    
    func setLayoutTable() -> Void {
        print("key is \(self.extensionProperty)")
        self.table = UITableView(frame: CGRectZero, style: .Plain)

        self.table.backgroundColor = UIColor(hexString: "#030c16")
        self.table.registerClass(UITableViewCell.self, forCellReuseIdentifier: self.identifier)
        self.table.separatorStyle = .None
        self.table.dataSource = self.dataSource
        self.table.delegate = self.delegate
        
        let imageUrl = ["images.bundle/home/test/test_EPL.jpg", "images.bundle/home/test/test_NBA.jpg"]
        let carouselView = CarouselView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 113), delegate: self, imageUrls: imageUrl, placeHolderImage: "", timeInterval: 3, currentPageIndicatorColor: UIColor.whiteColor(), pageIndicatorColor: UIColor.lightGrayColor())
        self.table.tableHeaderView = carouselView
        self.view.addSubview(self.table)
        self.table.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(0)
            make.top.equalTo(64)
            make.right.equalTo(0)
            make.bottom.equalTo(self.view.snp_bottom).offset(49)
        }
        
    }
}
