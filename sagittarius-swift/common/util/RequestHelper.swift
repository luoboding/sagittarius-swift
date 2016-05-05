//
//  RequestHelper.swift
//  sagittarius-swift
//
//  Created by bonedeng on 4/17/16.
//  Copyright © 2016 xingdongyou. All rights reserved.
//

import UIKit

class RequestHelper : NSObject{
    override init() {
        super.init()
    }
    
    convenience init(url: String, params: AnyObject?, method: String, success: (data: AnyObject?, response: NSHTTPURLResponse)->Void, failure: (response: NSHTTPURLResponse)->Void) {
        self.init()
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
        httpRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        httpRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTaskWithRequest(httpRequest) { (data, response, error) -> Void in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                let statusCode = httpResponse.statusCode
                switch statusCode {
                    case 500:
                        failure(response: httpResponse)
                    case 200:
                        if let responseData = data {
                            do {
                                let anyObject = try NSJSONSerialization.JSONObjectWithData(responseData, options: .MutableContainers)
                                success(data: anyObject, response: httpResponse)
                                
                            } catch {
                                success(data: nil, response: httpResponse)
                            }
                            
                        } else {
                            success(data: nil, response: httpResponse)
                        }
                    
                    case 401:
                        failure(response: httpResponse)
                    default:
                        failure(response: httpResponse)
                }
                return;
            }
            
        }
        
        task.resume()
        
        
    }
}
