//
//  ImageGalleryCell.swift
//  Demo
//
//  Created by Mufakkharul Islam Nayem on 20/12/20.
//  Copyright © 2020 muukii. All rights reserved.
//

import UIKit

class ImageGalleryCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet private weak var editIcon: RoundedCornerView!
    @IBOutlet private weak var editSquare: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clipsToBounds = false
        updateLayer()
    }
    
    static func dequeue(fromCollectionView collectionView: UICollectionView, atIndex index: IndexPath) -> ImageGalleryCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageGalleryCell", for: index) as? ImageGalleryCell else {
            fatalError("*** Failed to dequeue \(String(describing: self)) ***")
        }
        return cell
    }
    
    func setEditable(_ editable: Bool) {
        self.editIcon.isHidden = !editable
        self.editSquare.isHidden = !editable
    }
    
    private func updateLayer() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 4, height: 7)
        layer.shadowRadius = 5
        layer.backgroundColor = UIColor.clear.cgColor

        editSquare.layer.borderWidth = 1
        editSquare.layer.borderColor = UIColor.black.cgColor
    }
    
    public override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            if self.isHighlighted {
                                self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                                self.alpha = 0.8
                            } else {
                                self.transform = .identity
                                self.alpha = 1
                            }
            }, completion: nil)
        }
    }
}
