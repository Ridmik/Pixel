//
//  ImagesEditViewModel.swift
//  Demo
//
//  Created by Mufakkharul Islam Nayem on 20/12/20.
//  Copyright © 2020 muukii. All rights reserved.
//

import UIKit
import PixelEngine

class ImagesEditViewModel {
  
  private let view: UIView
  private let imageSources: [ImageSourceType]
  
  init(view: UIView) {
    self.view = view
    self.imageSources = [ StaticImageSource(source: #imageLiteral(resourceName: "Sample1")), StaticImageSource(source: #imageLiteral(resourceName: "Sample2")), StaticImageSource(source: #imageLiteral(resourceName: "Sample3")), StaticImageSource(source: #imageLiteral(resourceName: "Sample4")), StaticImageSource(source: #imageLiteral(resourceName: "Sample5")) ]
  }
  
  lazy var editingStacks: [EditingStack] = {
    return imageSources.map { EditingStack(source: $0, previewSize: .init(width: view.bounds.width, height: view.bounds.height)) }
  }()
  
  var images: [UIImage] {
    let images = editingStacks.map { $0.makeRenderer().render() }
    return images
  }
  
}
