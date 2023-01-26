//
//  CustomCollectionViewCell.swift
//  Emoji_Demo
//
//  Created by Nazmul on 23/01/2023.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var commonLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    static let catCellReuseIdentifier = "categoryCell"
    static let subCatCellResuseIdentifier = "subCategoryCell"
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.commonLabel.text = nil
    }
    
    func cellConfigForCategory(for cateName: String) -> Void {
        self.commonLabel.text = cateName
    }
    
    func cellConfigForEmoji(for emoji: String) -> Void {
        self.imageView.image = emoji.textToImage(size: 50)
    }
    
}
