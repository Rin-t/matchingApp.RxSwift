//
//  CardInfoLabel.swift
//  tinder.RxSwift
//
//  Created by Rin on 2021/09/14.
//

import UIKit

final class CardInfoLabel: UILabel {

    init(frame: CGRect, labelText: String, labelColor: UIColor) {
        super.init(frame: frame)

        font = .systemFont(ofSize: 45)
        text = labelText
        textColor = labelColor
        layer.borderWidth = 3
        layer.borderColor = labelColor.cgColor
        layer.cornerRadius = 10
        alpha = 0
        textAlignment = .center
    }

    // その他のラベル
    init(frame: CGRect, labelText: String, labelFont: UIFont) {
        super.init(frame: frame)

        font = labelFont
        textColor = .white
        text = labelText
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
