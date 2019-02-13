//
// APIManager.swift
//  SampleApp
//
//  Created by parvind bhatt on 12/02/19.
//  Copyright © 2019 parvind bhatt. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

//let KBaseURL="http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=h8AWSzKFhoW650Z0Ppk6SAgALodKQiKO"

class APIManager: NSObject {

    class func apiGet(serviceName:String,parameters: [String:Any]?, completionHandler: @escaping (JSON?, NSError?) -> ()) {
        
        Alamofire.request(serviceName, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    let json = JSON(data)
                    completionHandler(json,nil)
                }
                break
                
            case .failure(_):
                completionHandler(nil,response.result.error as NSError?)
                break
                
            }
        }
    }
}
