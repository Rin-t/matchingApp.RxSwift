//
//  RegisterTitleLabel.swift
//  tinder.RxSwift
//
//  Created by Rin on 2021/09/14.
//

import UIKit

class RegisterTitleLabel: UILabel {

    init(text: String) {
        super.init(frame: .zero)
        self.text = text
        self.font = .boldSystemFont(ofSize: 80)
        self.textColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
