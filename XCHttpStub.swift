
//
// XCTestHttpStub.swift
//  SampleApp
//
//  Created by parvind bhatt on 12/02/19.
//  Copyright © 2019 parvind bhatt. All rights reserved.
//

import Foundation
import OHHTTPStubs

enum XCHTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
    case HEAD = "HEAD"
}

class XCHttpStub {
    
    static func start() {
        OHHTTPStubs.setEnabled(true)
    }
    
    static func stop() {
        OHHTTPStubs.setEnabled(false)
    }
    
    static func clear() {
        OHHTTPStubs.removeAllStubs()
    }
    
    static func request(withURL URL: String, withStatusCode statusCode: Int, withHTTPMethod httpMethod: XCHTTPMethod?) {
        
    }
    
    static func request(withURL URL: String, withResponseData responseData: NSData, withHTTPMethod httpMethod: XCHTTPMethod?) {
        
    }
    
    static func request(withURL URL: String, withResponseFile responseFile: String) {
        
    }
    
    static func request(withPathRegex path: String, withResponseFile responseFile: String) {
        // Swift
        stub(condition: isHost("api.nytimes.com")) { _ in
            // Stub it with our "wsresponse.json" stub file (which is in same bundle as self)
            let stubPath = FilePath(responseFile).path
            return fixture(filePath: stubPath, headers: ["Content-Type":"application/json"])
        }
    }
    
    static func request(withPathRegex path: String, withHttpMethod method: XCHTTPMethod, withResponseFile responseFile: String) {
        stub(condition: isPathRegex(path, withHttpMethod: method.rawValue)) { request in
            
            print("Request URL: " + request.url!.absoluteString)
            print("Response file name: " + responseFile)
            
            return OHHTTPStubsResponse(fileAtPath: FilePath(responseFile).path, statusCode: 200, headers: [ "Content-Type": "application/json;charset=UTF-8" ])
        }
    }
    
    static func request(withPathRegex path: String, withResponseJSON responseJSON: String) {
        stub(condition: isPathRegex(path)) { request in
            guard let responseData = responseJSON.data(using: .utf8) else {
                return OHHTTPStubsResponse()
            }
            
            return OHHTTPStubsResponse(
                data: responseData,
                statusCode: 200,
                headers: [ "Content-Type": "application/json" ]
            )
        }
    }
    
    static func request(withPathRegex path: String, withHttpMethod method: XCHTTPMethod, withResponseJSON responseJSON: String) {
        stub(condition: isPathRegex(path, withHttpMethod: method.rawValue)) { request in
            guard let responseData = responseJSON.data(using: .utf8) else {
                return OHHTTPStubsResponse()
            }
            
            return OHHTTPStubsResponse(
                data: responseData,
                statusCode: 200,
                headers: [ "Content-Type": "application/json" ]
            )
        }
    }
    
}

class FilePath {
    var fileName: String
    
    var path: String {
        
        let applicationDocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
        
        if let filePath = applicationDocumentsDirectory?.appendingPathComponent(fileName), FileManager.default.fileExists(atPath: filePath.absoluteString) {
            return filePath.absoluteString
        }
        
        let bundel = Bundle(for: type(of: self))
        
        if let filePath = bundel.path(forResource: fileName, ofType: nil), FileManager.default.fileExists(atPath: filePath) {
            return filePath
        }
        
        return fileName
        
    }
    
    init(_ fileName: String) {
        self.fileName = fileName
    }
}


/**
 * Matcher for testing an `NSURLRequest`'s **path**.
 *
 * - Parameter path: The path to match
 *
 * - Returns: a matcher (OHHTTPStubsTestBlock) that succeeds only if the request
 *            has exactly the given path
 *
 * - Note: URL paths are usually absolute and thus starts with a '/' (which you
 *         should include in the `path` parameter unless you're testing relative URLs)
 */
public func isPathRegex(_ pathRegex: String) -> OHHTTPStubsTestBlock {
    return { req in Regex(pathRegex).test(input:(req.url as NSURL?)?.path) } // Need to cast to NSURL because URL.path does not behave like NSURL.path in Swift 3.0. URL.path does not stop at the first ';' and returns the entire string.
}

public func isPathRegex(_ pathRegex: String, withHttpMethod method: String) -> OHHTTPStubsTestBlock {
    return { req in
        if Regex(pathRegex).test(input:(req.url as NSURL?)?.path) && req.httpMethod == method {
            return true
        } else {
            return false
        }
    }
}

/**
 * Helper to return a `OHHTTPStubsResponse` given a fixture path, status code and optional headers.
 *
 * - Parameter filePath: the path of the file fixture to use for the response
 * - Parameter status: the status code to use for the response
 * - Parameter headers: the HTTP headers to use for the response
 *
 * - Returns: The `OHHTTPStubsResponse` instance that will stub with the given status code
 *            & headers, and use the file content as the response body.
 */
//public func fixture(JSONObject: String, status: Int32 = 200, headers: [NSObject: AnyObject]?) -> OHHTTPStubsResponse {
//    return OHHTTPStubsResponse(JSONObject
//}

class Regex {
    let pattern: String
    
    init(_ pattern: String) {
        self.pattern = pattern
    }
    
    func test(input: String?) -> Bool {
        guard let testString = input else {
            return false
        }
        print("Regex: " + pattern)
        print("Input: " + testString)
        var matchFound = false
        if let matches = testString.range(of: pattern, options: .regularExpression) {
            matchFound = matches.isEmpty != true
        }
        return matchFound
    }
}
