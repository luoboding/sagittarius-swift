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
    var httpRequest : NSMutableURLRequest!
    var task : NSURLSessionDataTask!
    var session : NSURLSession!
    
    override init() {
        super.init()
    }
    
    convenience init(url: String, params: AnyObject?, success: SuccessedHttpRequestHandler, failure: FailureHttpRequestHandler) {
        self.init()
        successedHandler = success
        failureHandler = failure
        session = NSURLSession.sharedSession()
        httpRequest = NSMutableURLRequest(URL: NSURL(string:  url)!)
        
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
    }
    
    func configTask() {
        print("start here")
        task = session.dataTaskWithRequest(httpRequest) { (data, response, error) -> Void in
            if let httpResponse = response as? NSHTTPURLResponse {
                let statusCode = httpResponse.statusCode
                print("status code is \(statusCode)")
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
    }
    
    func sendPostRequest() {
        httpRequest.HTTPMethod = "POST"
        configTask()
        task.resume()
    }
    
    func sendGetRequest() {
        httpRequest.HTTPMethod = "GET"
        configTask()
        task.resume()
    }
    
    func sendPutRequest() {
        httpRequest.HTTPMethod = "PUT"
        configTask()
        task.resume()
    }
    
    func sendDeleteRequest() {
        httpRequest.HTTPMethod = "DELETE"
        configTask()
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
        dispatch_async(dispatch_get_main_queue(),{ ()->() in
            self.successedHandler(data: result, response: response)
        })
        
    }
    
    func handleServerAndNormalError (response: NSHTTPURLResponse)->Void {
        dispatch_async(dispatch_get_main_queue(),{ ()->() in
            self.failureHandler(response: response)
        })
        
    }
    
    func handleUnauthorizedError (response: NSHTTPURLResponse)->Void {
        dispatch_async(dispatch_get_main_queue(),{ ()->() in
            self.failureHandler(response: response)
        })
    }
}
