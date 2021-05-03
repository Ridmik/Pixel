//
// Copyright (c) 2018 Muukii <muukii.app@gmail.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

public struct Style {

  public static let `default` = Style()

  public struct Control {

    public var backgroundColor: UIColor

    public init() {
      if #available(iOSApplicationExtension 12.0, *) {
        switch UIScreen.main.traitCollection.userInterfaceStyle {
        case .light:
          backgroundColor = .white
        case .dark:
          backgroundColor = .black
        case .unspecified:
          if #available(iOSApplicationExtension 13.0, *) {
            backgroundColor = .systemBackground
          } else {
            backgroundColor = .white
          }
        }
      } else {
        backgroundColor = .white
      }
    }
  }

  public var control = Control()
  
  public var black: UIColor

  public init() {
    if #available(iOSApplicationExtension 12.0, *) {
      switch UIScreen.main.traitCollection.userInterfaceStyle {
      case .light:
        black = .black
      case .dark:
        black = .white
      case .unspecified:
        if #available(iOSApplicationExtension 13.0, *) {
          black = .label
        } else {
          black = .black
        }
      }
    } else {
      black = .black
    }
  }

}
