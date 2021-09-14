//
//  UIColor-Extension.swift
//  tinder.RxSwift
//
//  Created by Rin on 2021/09/14.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        .init(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
}
