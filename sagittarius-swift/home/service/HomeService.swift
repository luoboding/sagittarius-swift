//
//  HomeService.swift
//  sagittarius-swift
//
//  Created by bonedeng on 5/5/16.
//  Copyright © 2016 xingdongyou. All rights reserved.
//

import UIKit

class HomeService: NSObject {
    func getDataWith(data: AnyObject?, success: (data: AnyObject?, response: NSHTTPURLResponse)->Void, failure: (response: NSHTTPURLResponse)->Void) ->Void {
        let url = "https://dev-ios.pickupstar.com/api/v2/gateway/index";
        RequestHelper(url: url, params: data, method: "GET", success: { (data, response) -> Void in
                success(data:  data, response: response)
            }, failure: { (response) -> Void in
                failure(response: response)
        })
    }
    
}
