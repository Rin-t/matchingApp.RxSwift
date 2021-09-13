//
//  TopControlView.swift
//  tinder.RxSwift
//
//  Created by Rin on 2021/09/13.
//

import UIKit
import RxCocoa
import RxSwift

class TopControlView: UIView {

    private let disposeBag = DisposeBag()

    let tinderButton = createTopButton(imageName: "tinder-selected", unselectedImageName: "tinder-unselected")
    let goodButton = createTopButton(imageName: "good-selected", unselectedImageName: "good-unselected")
    let commentButton = createTopButton(imageName: "comment-selected", unselectedImageName: "comment-unselected")
    let profileButton = createTopButton(imageName: "profile-selected", unselectedImageName: "profile-unselected")

    static private func createTopButton(imageName: String, unselectedImageName: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: imageName), for: .selected)
        button.setImage(UIImage(named: unselectedImageName), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
        setupLayout()
        setupBindings()

    }

    private func setupLayout() {
        let basestackView = UIStackView(arrangedSubviews: [tinderButton, goodButton, commentButton, profileButton])
        basestackView.axis = .horizontal
        basestackView.distribution = .fillEqually
        basestackView.spacing = 45
        basestackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(basestackView)

        [basestackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
         basestackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
         basestackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 40),
         basestackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -40),
        ].forEach { $0.isActive = true }

        tinderButton.isSelected = true
    }

    private func setupBindings() {

        tinderButton.rx.tap
            .subscribe { _ in
                self.handleSelectedButton(selectedButton: self.tinderButton)
            }
            .disposed(by: disposeBag)

        goodButton.rx.tap
            .subscribe { _ in
                self.handleSelectedButton(selectedButton: self.goodButton)
            }
            .disposed(by: disposeBag)

        commentButton.rx.tap
            .subscribe { _ in
                self.handleSelectedButton(selectedButton: self.commentButton)
            }
            .disposed(by: disposeBag)

        profileButton.rx.tap
            .subscribe { _ in
                self.handleSelectedButton(selectedButton: self.profileButton)
            }
            .disposed(by: disposeBag)
    }

    private func handleSelectedButton(selectedButton: UIButton) {
        let buttons = [tinderButton, goodButton, commentButton, profileButton]

        buttons.forEach { button in
            if button == selectedButton {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
