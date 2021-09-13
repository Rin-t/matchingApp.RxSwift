//
//  BottomControlView.swift
//  tinder.RxSwift
//
//  Created by Rin on 2021/09/13.
//

import UIKit

final class BottomControlView: UIView {

    let reloadView = BottomButtonView(frame: .zero, width: 50, imageName: "reload")
    let nopeView = BottomButtonView(frame: .zero, width: 60, imageName: "nope")
    let superlikeView = BottomButtonView(frame: .zero, width: 50, imageName: "superlike")
    let likeView = BottomButtonView(frame: .zero, width: 60, imageName: "like")
    let boostView = BottomButtonView(frame: .zero, width: 50, imageName: "boost")


    override init(frame: CGRect) {
        super.init(frame: frame)
        let basestackView = UIStackView(arrangedSubviews: [reloadView, nopeView, superlikeView, likeView, boostView])
        basestackView.axis = .horizontal
        basestackView.distribution = .fillEqually
        basestackView.spacing = 10
        basestackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(basestackView)
        basestackView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, leftPadding: 10, rightPadding: 10)

//        [basestackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
//         basestackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
//         basestackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
//         basestackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
//
//        ].forEach { $0.isActive = true }

    }

    required init?(coder: NSCoder) {
        fatalError("init has been implemented")
    }

}

final class BottomButtonView: UIView {

    var button: BottomButton?

    init(frame: CGRect, width: CGFloat, imageName: String) {
        super.init(frame: frame)
        button = BottomButton(type: .custom)
        button?.setImage(UIImage(named: imageName)?.resize(size: .init(width: width * 0.4, height: width * 0.4)), for: .normal)
        button?.translatesAutoresizingMaskIntoConstraints = false
        button?.backgroundColor = .white
        button?.layer.cornerRadius = width / 2

        button?.layer.shadowOffset = .init(width: 1.5, height: 2)
        button?.layer.shadowColor = UIColor.black.cgColor
        button?.layer.shadowOpacity = 0.3
        button?.layer.shadowRadius = 15

        guard let button = button else { return }
        addSubview(button)

        button.anchor(centerY: centerYAnchor, centerX: centerXAnchor, width: width, height: width)

//        [button.centerYAnchor.constraint(equalTo: centerYAnchor),
//        button.centerXAnchor.constraint(equalTo: centerXAnchor),
//        button.widthAnchor.constraint(equalToConstant: width),
//        button.heightAnchor.constraint(equalToConstant: width)].forEach { $0.isActive = true }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BottomButton: UIButton {

    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.7, options: []) {
                    self.transform = .init(scaleX: 0.8, y: 0.8)
                    self.layoutIfNeeded()
                }
            } else {
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.7, options: []) {
                    self.transform = .identity
                    self.layoutIfNeeded()
                }
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
