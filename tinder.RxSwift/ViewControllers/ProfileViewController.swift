//
//  ProfileViewController.swift
//  tinder.RxSwift
//
//  Created by Rin on 2021/09/15.
//

import UIKit
import RxSwift
import FirebaseFirestore
import FirebaseStorage

final class ProfileViewController: UIViewController {

    private let disposeBag = DisposeBag()

    var user: User?
    private let cellId = "cellId"

    private var name = ""
    private var age = ""
    private var email = ""
    private var hobby = ""
    private var residence = ""
    private var introduce = ""
    private var hasChangedImage = false

    //MARK: - UIviews
    let saveButton = UIButton(type: .system).createProfileTopButton(title: "保存")
    let logoutButton = UIButton(type: .system).createProfileTopButton(title: "ログアウト")
    let profileImageView = ProfileImageView()
    let nameLabel = ProfileLabel()
    let profileEditButton = UIButton(type: .system).createProfileEditButton()

    lazy var infoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .white
        cv.register(InfoCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        setupBindings()
    }

    private func setupBindings() {
        saveButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                guard let self = self else { return }
                let dic = [
                    "name": self.name,
                    "age": self.age,
                    "email": self.email,
                    "residence": self.residence,
                    "hobby": self.hobby,
                    "introduce": self.introduce
                ]

                if self.hasChangedImage {
                    guard let image = self.profileImageView.image else { return }
                    Storage.addProfileImageToStrage(image: image, dic: dic) {

                    }
                } else {
                    Firestore.updateUserInfo(dic: dic) {
                        print("変更完了")
                    }
                }
            }
            .disposed(by: disposeBag)

        profileEditButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                let pickerView = UIImagePickerController()
                pickerView.delegate = self
                self?.present(pickerView, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)


    }

    private func setupLayout() {
        view.backgroundColor = .white
        nameLabel.text = "test test"

        // viewの配置を設定
        view.addSubview(logoutButton)
        view.addSubview(saveButton)
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(profileEditButton)
        view.addSubview(infoCollectionView)

        logoutButton.anchor(top: view.topAnchor, right: view.rightAnchor, topPadding: 20, rightPadding: 15)
        saveButton.anchor(top: view.topAnchor, left: view.leftAnchor, topPadding: 20, leftPadding: 15)
        profileImageView.anchor(top: view.topAnchor, centerX: view.centerXAnchor, width: 180, height: 180, topPadding: 60)
        nameLabel.anchor(top: profileImageView.bottomAnchor, centerX: view.centerXAnchor, topPadding: 20)
        profileEditButton.anchor(top: profileImageView.topAnchor, right: profileImageView.rightAnchor, width: 60, height: 60)
        infoCollectionView.anchor(top: nameLabel.bottomAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, topPadding: 20)

        //ユーザー情報を設定
        nameLabel.text = user?.name
    }
}

//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            profileImageView.image = image
        }
        hasChangedImage = true
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = infoCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! InfoCollectionViewCell
        cell.user = self.user
        setupCellBindings(cell: cell)
        return cell
    }

    private func setupCellBindings(cell: InfoCollectionViewCell) {

        cell.nameTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.name = text ?? ""
            }
            .disposed(by: disposeBag)

        cell.ageTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.age = text ?? ""
            }
            .disposed(by: disposeBag)

        cell.emailTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.email = text ?? ""
            }
            .disposed(by: disposeBag)

        cell.residenceTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.residence = text ?? ""
            }
            .disposed(by: disposeBag)

        cell.hobbyTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.hobby = text ?? ""
            }
            .disposed(by: disposeBag)

        cell.introduceTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                self?.introduce = text ?? ""
            }
            .disposed(by: disposeBag)
    }
}



