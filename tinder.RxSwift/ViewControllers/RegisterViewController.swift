//
//  RegisterViewController.swift
//  tinder.RxSwift
//
//  Created by Rin on 2021/09/14.
//

import UIKit
import RxSwift
import FirebaseAuth

class RegisterViewController: UIViewController {

    private let disposeBag = DisposeBag()

    //MARK: - UIViews
    private let titleLabel = RegisterTitleLabel()
    private let nameTextField = RegisterTextField(frame: .zero, placeHolder: "名前", fontSize: 14)
    private let emailTextField = RegisterTextField(frame: .zero, placeHolder: "email", fontSize: 14)
    private let passwordTextField = RegisterTextField(frame: .zero, placeHolder: "passward", fontSize: 14)
    private let registerButton = RegisterButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientLayout()
        setupLayout()
        setupBindings()
    }

    //MARK: - methods
    private func setupGradientLayout() {
        let layer = CAGradientLayer()
        let startColor = UIColor.rgb(red: 227, green: 48, blue: 78).cgColor
        let endColor = UIColor.rgb(red: 245, green: 200, blue: 100).cgColor

        layer.colors = [startColor, endColor]
        layer.locations = [0.0, 1.3]
        layer.frame = view.bounds
        view.layer.addSublayer(layer)
    }

    private func setupLayout() {
        let baseStackView = UIStackView(arrangedSubviews: [nameTextField, emailTextField, passwordTextField, registerButton])
        baseStackView.axis = .vertical
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 20

        view.addSubview(baseStackView)
        view.addSubview(titleLabel)

        nameTextField.anchor(height: 40)
        baseStackView.anchor(left: view.leftAnchor, right: view.rightAnchor, centerY: view.centerYAnchor, leftPadding: 40, rightPadding: 40)
        titleLabel.anchor(bottom: baseStackView.topAnchor, centerX: view.centerXAnchor, bottomPadding: 20)
    }

    private func setupBindings() {

        nameTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                // textのハンドル
            }
            .disposed(by: disposeBag)

        emailTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                // textのハンドル
            }
            .disposed(by: disposeBag)

        passwordTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                // textのハンドル
            }
            .disposed(by: disposeBag)

        registerButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                //
                self?.createUserToFireAuth()
            }
            .disposed(by: disposeBag)

    }

    private func createUserToFireAuth() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        Auth.auth().createUser(withEmail: email, password: password) { auth, err in
            if let err = err {
                print("auth情報の作成に失敗", err)
                return
            }
            guard let uid = auth?.user.uid else { return }
            print("auth情報の保存に成功", uid)
        }
    }
}
