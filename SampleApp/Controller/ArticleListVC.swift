//
//  ViewController.swift
//  SampleApp
//
//  Created by parvind bhatt on 12/02/19.
//  Copyright © 2019 parvind bhatt. All rights reserved.
//

import UIKit
import SwiftyJSON

class ArticleListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // #1 - The UITableViewDataSource and
        // UITableViewDelegate protocols are
        // adopted in extensions.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableView.automaticDimension
        
        self.getNotificationList { (isSucess, error) in
           
            if isSucess! {
            }else{
                
            }
        }
    }

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ArticleDetailVCSegue" {
            
            if let destinationViewController = segue.destination as? ArticleDetailVC
            {
                let indexPath = self.tableView.indexPathForSelectedRow!
                let index = indexPath.row
                destinationViewController.articleViewModel = articleViewModels[index]
            }
        }
        
    } // end func prepare
    
    
}


extension ArticleListVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ArticleDetailVCSegue", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
}

// MARK: - UITableView Data Source

extension ArticleListVC : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleViewModels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell") as? ArticleTableViewCell
        tableViewCell?.configureArticleTableCell(articleObj: articleViewModels[indexPath.row])
        
        return tableViewCell!
    }
    
} // end extension ViewController : UITableViewDataSource

extension ArticleListVC{
    
    func getNotificationList(completionHandler: @escaping (Bool?, NSError?) -> ()) {
        activitySpinner.startAnimating()

        APIManager.apiGet(serviceName: Constant.API.viewAllSection, parameters: nil) { (response:JSON?, error:NSError?) in
            self.activitySpinner.stopAnimating()

            if error != nil {
                return
            }
            guard let _ = response else {
                return
            }
            
            //debugPrint(response!)
            let status = response![Constant.ServerKey.status].stringValue
            if status == "OK"{
                let resultDic = response![Constant.ServerKey.result].arrayValue
                debugPrint(resultDic)

                for dictObj in resultDic {
                    let article = ArticleDataModel(title:dictObj["title"].stringValue, author: dictObj["createdAt"].stringValue, date: dictObj["published_date"].stringValue, titleDescription:dictObj["abstract"].stringValue,
                        imageLink:dictObj["url"].stringValue)
                    
                    let article_ViewModel = ArticleViewModel(articleDataModel: article)
                    articleViewModels.append(article_ViewModel)
                    debugPrint(article.imageLink)
                }
                
             
                completionHandler(true, error)
                //do next
            } else {
               
                
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
}
