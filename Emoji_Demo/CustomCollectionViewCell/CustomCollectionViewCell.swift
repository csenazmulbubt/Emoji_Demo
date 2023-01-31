//
//  CustomCollectionViewCell.swift
//  Emoji_Demo
//
//  Created by Nazmul on 23/01/2023.
//

import UIKit
import Foundation

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
        
        if self.reuseIdentifier == CustomCollectionViewCell.subCatCellResuseIdentifier {
            autoreleasepool {
                self.commonLabel.text = cateName
            }
        }
        else{
            self.commonLabel.text = cateName
        }
    }
    
    func cellConfigForEmoji(for emoji: String) -> Void {
        self.imageView.image = emoji.textToImage(size: 70)
    }
    
}


extension String {
    var encodeEmoji: String{
        if let encodeStr = NSString(cString: self.cString(using: .nonLossyASCII)!, encoding: String.Encoding.utf8.rawValue){
            return encodeStr as String
        }
        return self
    }
    
    var decodeEmoji: String{
        let data = self.data(using: String.Encoding.utf8);
        let decodedStr = NSString(data: data!, encoding: String.Encoding.nonLossyASCII.rawValue)
        if let str = decodedStr{
            return str as String
        }
        return self
    }
}
