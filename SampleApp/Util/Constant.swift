//
//  Constant.swift
//  SampleApp
//
//  Created by parvind bhatt on 12/02/19.
//  Copyright © 2019 parvind bhatt. All rights reserved.
//

import Foundation

//let KBaseURL="http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=h8AWSzKFhoW650Z0Ppk6SAgALodKQiKO"

let kAPIKey = "h8AWSzKFhoW650Z0Ppk6SAgALodKQiKO"

struct Constant {
    
    static let BASE_URL = Constant.apiBaseURL()

    
    static func apiBaseURL() -> String {
        return "http://api.nytimes.com/svc/mostpopular/v2/"
        
    }
    
    //MARK:- API Urls
    struct API {
        
        static let viewAllSection = Constant.API.apiURL("mostviewed/all-sections/1.json?api-key=h8AWSzKFhoW650Z0Ppk6SAgALodKQiKO")
        
        static func apiURL(_ methodName: String) -> String {
            return BASE_URL + methodName
        }
    }
    
    struct ServerKey {
        static let status = "status"
        static let result = "results"
    }
}


