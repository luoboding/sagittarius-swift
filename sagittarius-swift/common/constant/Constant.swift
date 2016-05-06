//
//  Constant.swift
//  sagittarius-swift
//
//  Created by bonedeng on 5/6/16.
//  Copyright © 2016 xingdongyou. All rights reserved.
//
import UIKit
struct Constant {
    private static let Host = "https://dev-ios.pickupstar.com/";
    static let kWithScaleSize = CGRectGetWidth(UIScreen.mainScreen().bounds) / 375.0
    static let kHeightScaleSize = CGRectGetHeight(UIScreen.mainScreen().bounds) / 667.0
    static let kLoadingString = "加载中..."
    static let kNetworkErrorLoadingString = "当前网络异常，请检查后重试..."
    static let KServerErrorLoadingString = "数据加载失败，请稍后重试..."
    
    static func initUrl(url : String) ->String{
        return Host + url;
    }
    
    enum contestStatus : Int {
        case Prepared = 1801;
        case OnGoing = 1802;
        case Finished = 1803;
        case Cancelled = 1804;
    }
}