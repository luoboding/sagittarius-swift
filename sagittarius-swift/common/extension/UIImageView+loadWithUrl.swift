//
//  UIImage+webImage.swift
//  sagittarius-swift
//
//  Created by bonedeng on 5/10/16.
//  Copyright © 2016 xingdongyou. All rights reserved.
//

import UIKit

public extension UIImageView {
    func loadWithUrl(url: String, placeHolder: String) {
        dispatch_async(dispatch_get_global_queue(0, 0)) { () -> Void in
            do{
                let data = try NSData(contentsOfURL: NSURL(string: url)!, options: NSDataReadingOptions.DataReadingMappedIfSafe)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.image = UIImage(data: data)
                })
                
            } catch{
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.image = UIImage(named: placeHolder)
                })
            }
        }
    }
}