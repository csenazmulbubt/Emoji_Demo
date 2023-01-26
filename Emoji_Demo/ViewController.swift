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
    
    private var viewModel: EmojiPickerViewModelProtocol! //= nil
    private var isFirst: Bool = false
    private var currentSelectedCatIndex: Int = 0
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //self.categoryCollectionView.scrollDirection = .horizontal
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !isFirst{
            isFirst = true
            let unicodeManager = UnicodeManager()
            viewModel = EmojiPickerViewModel(unicodeManager: unicodeManager)
            self.bindViewModel()
        }
    }
    
    private func bindViewModel() {
        guard let viewModel = self.viewModel else { return }
        viewModel.selectedEmoji.bind { [weak self] emoji in
            guard let _ = self else { return }
            
        }
        viewModel.selectedEmojiCategoryIndex.bind { [weak self] categoryIndex in
            guard let self = self else { return }
            self.currentSelectedCatIndex = categoryIndex
            self.subCategoryCollectionView.reloadData()
        }
    }
    
}

//MARK: - UICollectionViewDelegate , UICollectionViewDataSource
extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    // CollectionView Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case categoryCollectionView:
            return viewModel.numberOfSections()
        default:
            return viewModel.numberOfItems(in: currentSelectedCatIndex)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case self.categoryCollectionView:
            let catCell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.catCellReuseIdentifier, for: indexPath) as? CustomCollectionViewCell
            
            catCell?.cellConfig(for: viewModel.categoryName(for: indexPath.item))
            return catCell ?? UICollectionViewCell()
        default:
            let subCatcell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.subCatCellResuseIdentifier, for: indexPath) as? CustomCollectionViewCell
            let actualIndexPath = IndexPath(item: indexPath.item, section: currentSelectedCatIndex)
            subCatcell?.cellConfig(for: viewModel.emoji(at: actualIndexPath))
            return subCatcell ?? UICollectionViewCell()
        }
    }
    
    // CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView {
        case self.categoryCollectionView:
            self.viewModel.selectedEmojiCategoryIndex.value = indexPath.item
            break
        default:
            let actualIndexPath = IndexPath(item: indexPath.item, section: currentSelectedCatIndex)
            self.viewModel.selectedEmoji.value = viewModel.emoji(at: actualIndexPath)
            break
        }
    }
    
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case self.categoryCollectionView:
            let height = categoryCollectionView.bounds.height
            let categoryName = viewModel.categoryName(for: indexPath.item)
            let width = categoryName.widthOfString(usingFont: UIFont.systemFont(ofSize: 11))
            let padding = 16.0
            return CGSize(width: width + padding, height: height)
        default:
            let sideInsets = collectionView.contentInset.right + collectionView.contentInset.left
            let contentSize = collectionView.bounds.width - sideInsets
            return CGSize(width: contentSize / 8, height: contentSize / 8)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case self.categoryCollectionView:
            return 16.0
        default:
            return 8.0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case self.categoryCollectionView:
            return 16.0
        default:
            return 8.0
        }
    }
    
    
}

extension String{
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}
