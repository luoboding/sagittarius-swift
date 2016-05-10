//
//  HomeNavigationView.swift
//  sagittarius-swift
//
//  Created by bonedeng on 5/5/16.
//  Copyright © 2016 xingdongyou. All rights reserved.
//

import UIKit

class HomeNavigationView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor(hexString: "#05121f")
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "images.bundle/home/logo@2x")
        self.addSubview(logoImageView)
        logoImageView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self)
            make.top.equalTo(31.0)
            make.height.equalTo(21)
            make.width.equalTo(78)
        }
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
