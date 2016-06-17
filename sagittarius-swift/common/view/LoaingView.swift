//
//  LoaingView.swift
//  sagittarius-swift
//
//  Created by bonedeng on 5/11/16.
//  Copyright © 2016 xingdongyou. All rights reserved.
//

import UIKit

class LoaingView: UIView {
    
    let heightForCircle = 30.0
    let widthForCircle = 30.0
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        drawTrianglePath(rect)
    }
    
    func drawTrianglePath (frame: CGRect) {
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0, y: 2))
        path.addLineToPoint(CGPoint(x: CGRectGetWidth(frame), y: 2))
        path.addLineToPoint(CGPoint(x: CGRectGetWidth(frame)/2, y: CGRectGetHeight(frame)));
        path.closePath()
        path.lineWidth = 2
        
        UIColor.redColor().set()
        path.fill()
        UIColor.blueColor().set()
        path.stroke()
        
    }

}
