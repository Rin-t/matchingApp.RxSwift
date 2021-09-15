//
//  ProfileImageView.swift
//  tinder.RxSwift
//
//  Created by Rin on 2021/09/15.
//

import UIKit

final class ProfileImageView: UIImageView {

    init() {
        super.init(frame: .zero)
        self.image = UIImage(named: "setting")
        self.contentMode = .scaleToFill
        self.layer.cornerRadius = 90
        self.clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
