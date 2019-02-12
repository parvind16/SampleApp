//
//  ViewModel.swift
//  SampleApp
//
//  Created by parvind bhatt on 12/02/19.
//  Copyright © 2019 parvind bhatt. All rights reserved.
//

import Foundation
import UIKit

var articleViewModels: [ArticleViewModel] = []
public typealias ImageDownloadCompletionClosure = (_ imageData: NSData ) -> Void

class ArticleViewModel
{

    let articleDataModel: ArticleDataModel
    private var imageURL: URL

    init(articleDataModel: ArticleDataModel)
    {
        self.articleDataModel = articleDataModel
        imageURL =  URL(string: articleDataModel.imageLink)!
    }
    
    public var formalName: String {
        return "Title: " + articleDataModel.title
    }
    
    func download(completionHanlder: @escaping ImageDownloadCompletionClosure)
    {
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = URLRequest(url:imageURL)
        
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            
            if let tempLocalUrl = tempLocalUrl, error == nil {
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    let rawImageData = NSData(contentsOf: tempLocalUrl)
                    completionHanlder(rawImageData!)
                    print("Successfully downloaded. Status code: \(statusCode)")
                }
            } else {
                print("Error took place while downloading a file. Error description: \(String(describing: error?.localizedDescription))")
            }
        } // end let task
        
        task.resume()
        
    } // end func download
    
}
