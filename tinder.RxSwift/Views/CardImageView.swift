//
//  CardImageView.swift
//  tinder.RxSwift
//
//  Created by Rin on 2021/09/14.
//

import UIKit

final class CardImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        layer.cornerRadius = 10
        contentMode = .scaleAspectFill
        image = UIImage(named: "test")
        clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
