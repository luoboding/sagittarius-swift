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
        let logoImageView = UIImageView(frame: CGRect(x: (self.frame.size.width-156/2)/2, y: 31, width: 156/2, height: 42/2))
        logoImageView.image = UIImage(named: "images.bundle/home/logo@2x")
        self.addSubview(logoImageView)   
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
