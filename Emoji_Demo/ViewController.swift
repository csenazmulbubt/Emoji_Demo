//
//  ViewController.swift
//  Emoji_Demo
//
//  Created by Nazmul on 23/01/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var subCategoryCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
}

//MARK: - UICollectionViewDelegate , UICollectionViewDataSource
extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    // CollectionView Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case categoryCollectionView:
            return 15
        default:
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case self.categoryCollectionView:
            let catCell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.catCellReuseIdentifier, for: indexPath) as? CustomCollectionViewCell
            
            return catCell ?? UICollectionViewCell()
        default:
            let subCatcell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.catCellReuseIdentifier, for: indexPath) as? CustomCollectionViewCell
            return subCatcell ?? UICollectionViewCell()
        }
    }
    
    // CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    
}

