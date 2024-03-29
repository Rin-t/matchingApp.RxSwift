//
//  RegisterViewController.swift
//  tinder.RxSwift
//
//  Created by Rin on 2021/09/14.
//

import UIKit
import RxSwift
import FirebaseAuth
import FirebaseFirestore
import PKHUD

class RegisterViewController: UIViewController {

    private let disposeBag = DisposeBag()
    private let viewModel = RegisterViewModel()

    //MARK: - UIViews
    private let titleLabel = RegisterTitleLabel(text: "Tinder")
    private let nameTextField = RegisterTextField(frame: .zero, placeHolder: "名前", fontSize: 14)
    private let emailTextField = RegisterTextField(frame: .zero, placeHolder: "email", fontSize: 14)
    private let passwordTextField = RegisterTextField(frame: .zero, placeHolder: "passward", fontSize: 14)
    private let registerButton = RegisterButton(text: "登録")
    private let alreadyRegisterdButton = UIButton(type: .system).createAboutAccountButton(text: "アカウントをお持ちの方はこちら")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientLayout()
        setupLayout()
        setupBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
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
        passwordTextField.isSecureTextEntry = true
        let baseStackView = UIStackView(arrangedSubviews: [nameTextField, emailTextField, passwordTextField, registerButton])
        baseStackView.axis = .vertical
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 20

        view.addSubview(baseStackView)
        view.addSubview(titleLabel)
        view.addSubview(alreadyRegisterdButton)

        nameTextField.anchor(height: 40)
        baseStackView.anchor(left: view.leftAnchor, right: view.rightAnchor, centerY: view.centerYAnchor, leftPadding: 40, rightPadding: 40)
        titleLabel.anchor(bottom: baseStackView.topAnchor, centerX: view.centerXAnchor, bottomPadding: 20)
        alreadyRegisterdButton.anchor(top: baseStackView.bottomAnchor, centerX: view.centerXAnchor, topPadding: 20)
    }

    private func setupBindings() {

        nameTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.viewModel.nameTextInput.onNext(text ?? "")
            }
            .disposed(by: disposeBag)

        emailTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.viewModel.emailTextInput.onNext(text ?? "")
            }
            .disposed(by: disposeBag)

        passwordTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.viewModel.passwordTextInput.onNext(text ?? "")
            }
            .disposed(by: disposeBag)

        // buttonのbinding
        registerButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.createUser()
            }
            .disposed(by: disposeBag)

        alreadyRegisterdButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                let login = LoginViewController()
                self?.navigationController?.pushViewController(login, animated: true)
            }
            .disposed(by: disposeBag)

        // viewmodelのBinding
        viewModel.validRegisterDriver
            .drive { validAll in
                self.registerButton.isEnabled = validAll
                self.registerButton.backgroundColor = validAll ? .rgb(red: 227, green: 48, blue: 78) : .init(white: 0.7, alpha: 1)
            }
            .disposed(by: disposeBag)
    }

    private func createUser() {
        let email = emailTextField.text
        let password = passwordTextField.text
        let name = nameTextField.text

        HUD.show(.progress)
        Auth.createUserToFireAuth(email: email, password: password, name: name) { success in
            HUD.hide()
            if success {
                print("処理完了")
                self.dismiss(animated: true, completion: nil)
            } else {
                print("処理失敗")
            }
        }
    }
}
