//
//  ArticleDetailVC.swift
//  SampleApp
//
//  Created by parvind bhatt on 12/02/19.
//  Copyright © 2019 parvind bhatt. All rights reserved.
//

import UIKit

class ArticleDetailVC: UIViewController {

    var articleViewModel: ArticleViewModel?
    
   // @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configView()
    }
    
    func configView() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        descriptionTextView.text = articleViewModel?.articleDataModel.titleDescription
       
        imageView.alpha = 0.0

        // #1 - Define a closure (completion block) INSTANCE for updating a UIImageView
        // once an image downloads.
        let imageCompletionClosure = { ( imageData: NSData ) -> Void in
            
            // #2 - Download occurs on background thread, but UI update
            // MUST occur on the main thread.
            DispatchQueue.main.async {
                
                // #3 - Animate the appearance of the Messier image.
                UIView.animate(withDuration: 1.0, animations: {
                    self.imageView.alpha = 1.0
                    self.imageView?.image = UIImage(data: imageData as Data)
                    self.view.setNeedsDisplay()
                })
                
                // #4 - Stop and hide the activity spinner as the
                // image has finished downloading
                self.activitySpinner.stopAnimating()
                
            } // end DispatchQueue.main.async
            
        } // end let imageCompletionClosure...
        
        // #5 - Start and show the activity spinner as the
        // image is about to start downloading in background.
        activitySpinner.startAnimating()
        
        articleViewModel?.download(completionHanlder: imageCompletionClosure)

    }
    
    
}
