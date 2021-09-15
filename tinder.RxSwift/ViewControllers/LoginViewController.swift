//
//  LoginViewController.swift
//  tinder.RxSwift
//
//  Created by Rin on 2021/09/15.
//

import UIKit
import RxSwift
import FirebaseAuth
import PKHUD

final class LoginViewController: UIViewController {

    private let disposeBag = DisposeBag()

    //MARK: - UIViews
    private let titleLabel = RegisterTitleLabel(text: "Login")
    private let emailTextField = RegisterTextField(frame: .zero, placeHolder: "email", fontSize: 14)
    private let passwordTextField = RegisterTextField(frame: .zero, placeHolder: "passward", fontSize: 14)
    private let loginButton = RegisterButton(text: "login")
    private let dontHaveAccountButton = UIButton(type: .system).createAboutAccountButton(text: "アカウントをお持ちでない方はこちら")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientLayout()
        setupLayout()
        setupBindings()
    }

    private func setupLayout() {
        passwordTextField.isSecureTextEntry = true
        let baseStackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        baseStackView.axis = .vertical
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 20

        view.addSubview(baseStackView)
        view.addSubview(titleLabel)
        view.addSubview(dontHaveAccountButton)

        emailTextField.anchor(height: 45)
        baseStackView.anchor(left: view.leftAnchor, right: view.rightAnchor, centerY: view.centerYAnchor, leftPadding: 40, rightPadding: 40)
        titleLabel.anchor(bottom: baseStackView.topAnchor, centerX: view.centerXAnchor, bottomPadding: 20)
        dontHaveAccountButton.anchor(top: baseStackView.bottomAnchor, centerX: view.centerXAnchor, topPadding: 20)
    }

    private func setupGradientLayout() {
        let layer = CAGradientLayer()
        let startColor = UIColor.rgb(red: 227, green: 48, blue: 78).cgColor
        let endColor = UIColor.rgb(red: 245, green: 200, blue: 100).cgColor

        layer.colors = [startColor, endColor]
        layer.locations = [0.0, 1.3]
        layer.frame = view.bounds
        view.layer.addSublayer(layer)
    }

    private func setupBindings() {
        dontHaveAccountButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)

        loginButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.login()
            }
            .disposed(by: disposeBag)
    }

    private func login() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""

        HUD.show(.progress)

        Auth.loginWithFireAuth(email: email, password: password) { success in
            HUD.hide()
            if success {
                self.dismiss(animated: true, completion: nil)
            } else {
                print("ログインの失敗")
            }
        }
    }
}
