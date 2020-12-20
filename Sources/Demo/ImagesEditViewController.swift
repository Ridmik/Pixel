//
//  ImagesEditViewController.swift
//  Demo
//
//  Created by Mufakkharul Islam Nayem on 20/12/20.
//  Copyright © 2020 muukii. All rights reserved.
//

import UIKit
import PixelEditor
import PixelEngine

class ImagesEditViewController: UIViewController {
  
  @IBOutlet private weak var galleryContainerView: UIView!
  @IBOutlet private weak var filterContainerView: UIView!
  
  private lazy var viewModel: ImagesEditViewModel = {
    let viewModel = ImagesEditViewModel(view: view)
    return viewModel
  }()
  
  private lazy var gallery: ImageGalleryView = {
    let gallery = ImageGalleryView(images: viewModel.images)
    return gallery
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addGalleryView()
    addFiltersView()
  }
  
  private func addGalleryView() {
    
    galleryContainerView.addSubview(gallery)
    
    gallery.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      gallery.leadingAnchor.constraint(equalTo: galleryContainerView.leadingAnchor),
      gallery.trailingAnchor.constraint(equalTo: galleryContainerView.trailingAnchor),
      gallery.topAnchor.constraint(equalTo: galleryContainerView.topAnchor),
      gallery.bottomAnchor.constraint(equalTo: galleryContainerView.bottomAnchor)
    ])
    
    gallery.callbacks.didSelect = { [unowned self] gallery, index in
      let editingStack = self.viewModel.editingStacks[index]
      let pixelEditor = PixelEditViewController(editingStack: editingStack)
      
      pixelEditor.callbacks.didCancelEditing = { editor in
        editor.dismiss(animated: true)
      }
      
      pixelEditor.callbacks.didEndEditing = { editor, editingStack in
        self.updateCurrentImage(at: index, from: editingStack)
        editor.dismiss(animated: true)
      }
      
      let navigationController = UINavigationController(rootViewController: pixelEditor)
      navigationController.modalPresentationStyle = .fullScreen
      self.present(navigationController, animated: true)
    }
    
  }
  
  private func addFiltersView() {
    guard let firstEditingStack = viewModel.editingStacks.first else { return }
    
    let context = PixelEditContext(options: .current)
    context.didReceiveAction = { [weak self] action in
      switch action {
      case .setFilter(let closure):
        self?.viewModel.editingStacks.enumerated().forEach { [weak self] editingStack in
          editingStack.element.callbacks.didChangeCurrentEdit = { stack, edit in
            self?.updateCurrentImage(at: editingStack.offset, from: stack)
          }
          editingStack.element.set(filters: closure)
        }
      case .commit:
        self?.viewModel.editingStacks.forEach { editingStack in
          editingStack.commit()
        }
      default:
        break
      }
    }
    
    let colorCubeControl = ColorCubeControl(context: context, originalImage: firstEditingStack.cubeFilterPreviewSourceImage!, filters: firstEditingStack.previewColorCubeFilters)
    
    filterContainerView.addSubview(colorCubeControl)
    colorCubeControl.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      colorCubeControl.leadingAnchor.constraint(equalTo: filterContainerView.leadingAnchor),
      colorCubeControl.trailingAnchor.constraint(equalTo: filterContainerView.trailingAnchor),
      colorCubeControl.topAnchor.constraint(equalTo: filterContainerView.topAnchor),
      colorCubeControl.bottomAnchor.constraint(equalTo: filterContainerView.bottomAnchor)
    ])
  }
  
  private func updateCurrentImage(at index: Int, from stack: EditingStack) {
    let finalEditedImage = stack.makeRenderer().render()
    
    DispatchQueue.main.async {
      self.gallery.reload(at: index, with: finalEditedImage)
    }
  }
  
}
