//
//  BottomControlView.swift
//  tinder.RxSwift
//
//  Created by Rin on 2021/09/13.
//

import UIKit

final class BottomControlView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .purple

        let view1 = BottomButtonView(frame: .zero, width: 50)
        view1.backgroundColor = .orange

        let view2 = BottomButtonView(frame: .zero, width: 60)
        view2.backgroundColor = .green

        let view3 = BottomButtonView(frame: .zero, width: 50)
        view3.backgroundColor = .white

        let view4 = BottomButtonView(frame: .zero, width: 60)
        view4.backgroundColor = .green

        let view5 = BottomButtonView(frame: .zero, width: 50)
        view5.backgroundColor = .orange

        let basestackView = UIStackView(arrangedSubviews: [view1, view2, view3, view4, view5])
        basestackView.axis = .horizontal
        basestackView.distribution = .fillEqually
        basestackView.spacing = 10
        basestackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(basestackView)

        [basestackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
         basestackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
         basestackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
         basestackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),

        ].forEach { $0.isActive = true }

    }

    required init?(coder: NSCoder) {
        fatalError("init has been implemented")
    }

}

class BottomButtonView: UIView {

    var button: UIButton?

    init(frame: CGRect, width: CGFloat) {
        super.init(frame: frame)
        button = UIButton(type: .system)
        button?.setTitle("tap", for: .normal)
        button?.translatesAutoresizingMaskIntoConstraints = false
        button?.backgroundColor = .white
        button?.layer.cornerRadius = width / 2

        button?.layer.shadowOffset = .init(width: 1.5, height: 2)
        button?.layer.shadowColor = UIColor.black.cgColor
        button?.layer.shadowOpacity = 0.3
        button?.layer.shadowRadius = 15

        guard let button = button else { return }
        addSubview(button)

        [button.centerYAnchor.constraint(equalTo: centerYAnchor),
        button.centerXAnchor.constraint(equalTo: centerXAnchor),
        button.widthAnchor.constraint(equalToConstant: width),
        button.heightAnchor.constraint(equalToConstant: width)].forEach { $0.isActive = true }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
