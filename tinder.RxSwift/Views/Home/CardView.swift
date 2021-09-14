//
//  CardView.swift
//  tinder.RxSwift
//
//  Created by Rin on 2021/09/14.
//

import UIKit

final class CardView: UIView {

    private let gradientLayer = CAGradientLayer()

    //MARK: - UIView
    private let cardImageView = CardImageView()
    private let infoButton = UIButton(type: .system).createCardInfoButton()
    private let nameLabel = CardInfoLabel(labelText: "Taro, 22", labelFont: .systemFont(ofSize: 40, weight: .heavy))
    private let residentLabel = CardInfoLabel(labelText: "日本、愛知", labelFont: .systemFont(ofSize: 20, weight: .regular))
    private let hobbyLabel = CardInfoLabel(labelText: "ランニング", labelFont: .systemFont(ofSize: 25, weight: .regular))
    private let introductionLabel = CardInfoLabel(labelText: "走り回るのが大好きです", labelFont: .systemFont(ofSize: 25, weight: .regular))
    private let goodLabel = CardInfoLabel(labelText: "GOOD", labelColor: UIColor.rgb(red: 137, green: 223, blue: 86))
    private let nopeLabel = CardInfoLabel(labelText: "NOPE", labelColor: UIColor.rgb(red: 222, green: 110, blue: 110))


    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLayout()
        setupGradientLayer()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panCardView))
        self.addGestureRecognizer(panGesture)
    }

    private func setupGradientLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.3, 1.1]
        cardImageView.layer.addSublayer(gradientLayer)
    }

    override func layoutSubviews() {
        gradientLayer.frame = self.bounds
    }

    // cardのアニメーション
    @objc private func panCardView(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)

        if gesture.state == .changed {
            handlePanChange(translation: translation)
        } else if gesture.state == .ended {
            handlePanEnded()
        }
    }

    // 画像の移動
    private func handlePanChange(translation: CGPoint) {
        let degree: CGFloat = translation.x / 20
        let angle = degree * .pi / 100
        let rotateTranslation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotateTranslation.translatedBy(x: translation.x, y: translation.y)

        // 傾き(translation.x)が＋ーそれぞれ100のときにラベルを最も濃くする
        let ratio: CGFloat = 1 / 100
        // 右に動くと＋、左に動くとー
        let ratioValue = ratio * translation.x

        if translation.x > 0 {
            self.goodLabel.alpha = ratioValue
        } else if translation.x < 0 {
            self.nopeLabel.alpha = -ratioValue
        }
    }

    private func handlePanEnded() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: []) {
            self.transform = .identity
            self.layoutIfNeeded()
            self.goodLabel.alpha = 0
            self.nopeLabel.alpha = 0
        }

    }

    private func setupLayout() {
        let infoVerticalStackView = UIStackView(arrangedSubviews: [residentLabel, hobbyLabel, introductionLabel])
        infoVerticalStackView.axis = .vertical

        let baseStackView = UIStackView(arrangedSubviews: [infoVerticalStackView, infoButton])
        baseStackView.axis = .horizontal

        addSubview(cardImageView)
        addSubview(nameLabel)
        addSubview(baseStackView)
        addSubview(goodLabel)
        addSubview(nopeLabel)

        cardImageView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, leftPadding: 10, rightPadding: 10)
        baseStackView.anchor(bottom: cardImageView.bottomAnchor, left: cardImageView.leftAnchor, right: cardImageView.rightAnchor, bottomPadding: 20, leftPadding: 20, rightPadding: 20)
        infoButton.anchor(width: 40)
        nameLabel.anchor(bottom: baseStackView.topAnchor, left: cardImageView.leftAnchor, bottomPadding: 10, leftPadding: 20)
        goodLabel.anchor(top: cardImageView.topAnchor, left: cardImageView.leftAnchor, width: 140, height: 55, topPadding: 20, leftPadding: 20)
        nopeLabel.anchor(top: cardImageView.topAnchor, right: cardImageView.rightAnchor, width: 140, height: 55, topPadding: 20, rightPadding: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
