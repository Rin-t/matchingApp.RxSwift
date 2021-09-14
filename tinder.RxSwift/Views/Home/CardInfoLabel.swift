//
//  CardInfoLabel.swift
//  tinder.RxSwift
//
//  Created by Rin on 2021/09/14.
//

import UIKit

final class CardInfoLabel: UILabel {

    init(labelText: String, labelColor: UIColor) {
        super.init(frame: .zero)

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
    init(labelText: String, labelFont: UIFont) {
        super.init(frame: .zero)

        font = labelFont
        textColor = .white
        text = labelText
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
