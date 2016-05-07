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
        let url = Constant.initUrl("api/v2/gateway/index");
        let request = RequestHelper(url: url, params: data, success: success, failure: failure)
        request.sendGetRequest()
    }
    
}
