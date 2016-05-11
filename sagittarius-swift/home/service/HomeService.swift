//
//  HomeService.swift
//  sagittarius-swift
//
//  Created by bonedeng on 5/5/16.
//  Copyright © 2016 xingdongyou. All rights reserved.
//

import UIKit

class HomeService : NSObject {
    
    static var onceToken: dispatch_once_t = 0
    static var instance : HomeService? = nil
    
    class var sharedInstance : HomeService {
        dispatch_once(&onceToken) {
            instance = HomeService()
        }
        return instance!
    }
    
    func getDataWith(data: AnyObject?, success: SuccessedHttpRequestHandler, failure: FailureHttpRequestHandler) ->Void {
        let url = Constant.initUrl("v2/gateway/index")
        let request = RequestHelper(url: url, params: data, success: success, failure: failure)
        request.sendGetRequest()
    }
    
    func getCarousel(success: SuccessedHttpRequestHandler, failure: FailureHttpRequestHandler) {
        let url = Constant.initUrl("imageSliders")
        let request = RequestHelper(url: url, params: nil, success: success, failure: failure)
        request.sendGetRequest()
    }
    
}
