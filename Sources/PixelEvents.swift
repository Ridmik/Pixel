//
//  PixelEvents.swift
//  Pixel
//
//  Created by Ankur on 6/7/21.
//  Copyright © 2021 muukii. All rights reserved.
//

import Foundation

public enum PixeslEvent: String {
    case eventOpenImageEditor = "open_image_editor"
    case eventOpenVideoEditor = "open_video_editor_view"
}

public enum YPImagePickerAction: String {
    case action
    case source
}

public extension String {
    static let actionUserOpenImageEditor = "user opens image editor"
    static let actionUserOpenVideoEditor = "user opens video editor"
}
