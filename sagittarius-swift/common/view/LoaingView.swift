//
//  LoaingView.swift
//  sagittarius-swift
//
//  Created by bonedeng on 5/11/16.
//  Copyright © 2016 xingdongyou. All rights reserved.
//

import UIKit

class LoaingView: UIView {
    
    var leftTopCircle: UIView!
    var leftBottomCircle: UIView!
    var rigthtTopCircle: UIView!
    var rightBottomCircle: UIView!
    let heightForCircle = 30.0
    let widthForCircle = 30.0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        assert(frame.size.width == frame.size.height, "must be a cube")
        
        let r = frame.size.width/2
        let halfOfBorderLength = Double(r) * sin(M_PI/8)
        
        print("r \(halfOfBorderLength)")
//        self.leftTopCircle = UIView(frame: CGRect(x: , y: <#T##CGFloat#>, width: widthForCircle, height: heightForCircle))
        
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
