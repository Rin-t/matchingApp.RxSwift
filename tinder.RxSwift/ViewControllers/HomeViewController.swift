//
//  ViewController.swift
//  tinder.RxSwift
//
//  Created by Rin on 2021/09/13.
//

import UIKit
import RxSwift
import FirebaseAuth
import FirebaseFirestore
import PKHUD

class HomeViewController: UIViewController {

    private let disposeBag = DisposeBag()
    private var user: User?
    // 自分以外のユーザー
    private var users = [User]()

    let topControlView = TopControlView()
    let cardView = UIView()
    let bottomControlView = BottomControlView()

    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ログアウト", for: .normal)
        return button
    }()

    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let uid = Auth.auth().currentUser?.uid else { return }

        HUD.show(.progress)
        Firestore.fetchUserFromFirestore(uid: uid) { user in
            if let user = user {
                self.user = user
            }
        }

        fetchUsers()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser?.uid == nil {
            let registerViewController = RegisterViewController()
            let nav = UINavigationController(rootViewController: registerViewController)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        }
    }


    //MARK: - Methods

    private func fetchUsers() {
        Firestore.fetchUsers { users in
            self.users = users

            self.users.forEach { user in
                let card = CardView(user: user)
                self.cardView.addSubview(card)
                card.anchor(top: self.cardView.topAnchor, bottom: self.cardView.bottomAnchor, left: self.cardView.leftAnchor, right: self.cardView.rightAnchor)
            }
            HUD.hide()
            print("自分以外のユーザーの情報の取得に成功", users)
        }
    }

    private func setupLayout() {
        view.backgroundColor = .white

        let stackView = UIStackView(arrangedSubviews: [topControlView, cardView, bottomControlView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical

        self.view.addSubview(logoutButton)
        self.view.addSubview(stackView)

        [
            topControlView.heightAnchor.constraint(equalToConstant: 100),
            bottomControlView.heightAnchor.constraint(equalToConstant: 120),

            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ].forEach { $0.isActive = true }

        logoutButton.anchor(bottom: view.bottomAnchor, left: view.leftAnchor, bottomPadding: 10, leftPadding: 10)
        logoutButton.addTarget(self, action: #selector(tappedLogoutButton), for: .touchUpInside)
    }

    @objc private func tappedLogoutButton() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let registerViewController = RegisterViewController()
                let nav = UINavigationController(rootViewController: registerViewController)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
        } catch {
            print("signOutの失敗: ", error)
        }
    }

    private func setupBindings() {
        topControlView.profileButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                let profile = ProfileViewController()
                self?.present(profile, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)


    }

}

