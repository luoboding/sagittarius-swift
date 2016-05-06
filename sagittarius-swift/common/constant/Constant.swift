//
//  Constant.swift
//  sagittarius-swift
//
//  Created by bonedeng on 5/6/16.
//  Copyright © 2016 xingdongyou. All rights reserved.
//

struct Constant {
    private static var Host = "https://dev-ios.pickupstar.com/";
    static func initUrl(url : String) ->String{
        return Host + url;
    }
}