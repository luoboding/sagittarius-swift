//
//  RequestHelper.swift
//  sagittarius-swift
//
//  Created by bonedeng on 4/17/16.
//  Copyright © 2016 xingdongyou. All rights reserved.
//

import UIKit

typealias SuccessedHttpRequestHandler = (data: AnyObject?, response: NSHTTPURLResponse)->Void
typealias FailureHttpRequestHandler = (response: NSHTTPURLResponse)->Void
class RequestHelper : NSObject{
    
    var successedHandler: SuccessedHttpRequestHandler!
    var failureHandler: FailureHttpRequestHandler!
    override init() {
        super.init()
    }
    
    convenience init(url: String, params: AnyObject?, method: String, success: SuccessedHttpRequestHandler, failure: FailureHttpRequestHandler) {
        self.init()
        successedHandler = success
        failureHandler = failure
        let session = NSURLSession.sharedSession()
        let httpRequest = NSMutableURLRequest(URL: NSURL(string:  url)!)
        httpRequest.HTTPMethod = method
        
        do {
            if let params = params {
                httpRequest.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
            }
        } catch {
            print("JSON serialization failed")
        }
        
        session.configuration.HTTPAdditionalHeaders = [
            "Accept"           :  "application/json",
            "Content-Type"     :  "application/json",
            "Accept-Language"  :  "zh",
            "Device-Type"      :  "IOS"
        ]
        
        let userDefault = NSUserDefaults.standardUserDefaults()
        let token = userDefault.stringForKey("token")
        if (token != nil) {
            session.configuration.HTTPAdditionalHeaders!["x-auth-token"] = token
        }
        let task = session.dataTaskWithRequest(httpRequest) { (data, response, error) -> Void in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                let statusCode = httpResponse.statusCode
                switch statusCode {
                    case 500:
                        self.handleServerAndNormalError(httpResponse)
                    case 200:
                        self.handleSuccess(data, response: httpResponse)
                    case 401:
                        self.handleUnauthorizedError(httpResponse)
                    default:
                        self.handleServerAndNormalError(httpResponse)
                }
                return;
            }
            
        }
        
        task.resume()
        
        
    }
    
    func handleSuccess(data: AnyObject?, response: NSHTTPURLResponse) {
        var result: AnyObject?
        if let responseData = data {
            do {
                result = try NSJSONSerialization.JSONObjectWithData(responseData as! NSData, options: .MutableContainers)
            } catch {
            }
        }
        self.successedHandler(data: result, response: response)
    }
    
    func handleServerAndNormalError (response: NSHTTPURLResponse)->Void {
        failureHandler(response: response)
    }
    
    func handleUnauthorizedError (response: NSHTTPURLResponse)->Void {
        failureHandler(response: response)
    }
}
