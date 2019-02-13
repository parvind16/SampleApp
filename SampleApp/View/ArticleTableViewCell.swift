//
//  ArticleTableViewCell.swift
//  SampleApp
//
//  Created by parvind bhatt on 12/02/19.
//  Copyright © 2019 parvind bhatt. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureArticleTableCell(articleObj:ArticleViewModel) {
        // this
        articleImageView.layer.cornerRadius = articleImageView.frame.height/2
        articleImageView.clipsToBounds = true
        articleImageView.backgroundColor = .green
        titleLabel.text = articleObj.articleDataModel.title 
        dateLabel.text = articleObj.articleDataModel.date
    }
}
