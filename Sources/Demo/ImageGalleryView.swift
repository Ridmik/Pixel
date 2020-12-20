//
//  ImageGalleryView.swift
//  Demo
//
//  Created by Mufakkharul Islam Nayem on 20/12/20.
//  Copyright © 2020 muukii. All rights reserved.
//

import UIKit

class ImageGalleryView: UIView {
    
    private(set) var images: [UIImage]
    
    class Callbacks {
        var didSelect: (ImageGalleryView, Int) -> Void = { _, _ in }
    }
    
    let callbacks = Callbacks()
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: GalleryCollectionViewFlowLayout())
    
    init(images: [UIImage]) {
        self.images = images
        super.init(frame: .zero)
        addCollectionView()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reload(at index: Int, with image: UIImage) {
        images[index] = image
        collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
    }
    
    private func addCollectionView() {
        
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
      collectionView.register(UINib(nibName: "ImageGalleryCell", bundle: .main), forCellWithReuseIdentifier: "ImageGalleryCell")
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    class GalleryCollectionViewFlowLayout: UICollectionViewFlowLayout {
        
        override init() {
            super.init()
            scrollDirection = .horizontal
            let sideMargin: CGFloat = 24
            let spacing: CGFloat = 12
            let overlapppingNextPhoto: CGFloat = 37
            minimumLineSpacing = spacing
            minimumInteritemSpacing = spacing
            let size = UIScreen.main.bounds.width - (sideMargin + overlapppingNextPhoto)
            itemSize = CGSize(width: size, height: size)
            sectionInset = UIEdgeInsets(top: 0, left: sideMargin, bottom: 0, right: sideMargin)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // This makes so that Scrolling the collection view always stops with a centered image.
        // This is heavily inpired form :
        // https://stackoverflow.com/questions/13492037/targetcontentoffsetforproposedcontentoffsetwithscrollingvelocity-without-subcla
        override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
            
            let spacing: CGFloat = 12
            let overlapppingNextPhoto: CGFloat = 37
            var offsetAdjustment = CGFloat.greatestFiniteMagnitude// MAXFLOAT
            let horizontalOffset = proposedContentOffset.x + spacing + overlapppingNextPhoto/2 // + 5
            
            guard let collectionView = collectionView else {
                return proposedContentOffset
            }
            let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
            guard let array = super.layoutAttributesForElements(in: targetRect) else {
                return proposedContentOffset
            }
            
            for layoutAttributes in array {
                let itemOffset = layoutAttributes.frame.origin.x
                if abs(itemOffset - horizontalOffset) < abs(offsetAdjustment) {
                    offsetAdjustment = itemOffset - horizontalOffset
                }
            }
            return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
        }
    }
    
}

extension ImageGalleryView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ImageGalleryCell.dequeue(fromCollectionView: collectionView, atIndex: indexPath)
        
        let image = images[indexPath.row]
        cell.imageView.image = image
        
        return cell
    }
    
}

extension ImageGalleryView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        callbacks.didSelect(self, indexPath.row)
    }
    
}
