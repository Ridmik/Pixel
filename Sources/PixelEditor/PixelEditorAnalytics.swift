//
//  PixelEngineAnalytics.swift
//  PixelEditor
//
//  Created by Ankur on 6/7/21.
//  Copyright © 2021 muukii. All rights reserved.
//

import Foundation

public enum PixelEditorEvent: String {
    case eventOpenImageEditor = "open_image_editor"
    case eventOpenVideoEditor = "open_video_editor_view"
    case eventTapOnImageFilterButton  = "tap_on_image_filter_button"
    case eventTapOnImageEditButton = "tap_on_image_edit_button"
}

public enum PixeslEditorAction: String {
    case action
    case source
}

public extension String {
//    static let actionUserOpenImageEditor = "user opens image editor"
//    static let actionUserOpenVideoEditor = "user opens video editor"
    static let actionTappedFilter = "user tapped on filter action"
    static let actionTappedOnImageEditButton = "user tapped on image edit action"
}
