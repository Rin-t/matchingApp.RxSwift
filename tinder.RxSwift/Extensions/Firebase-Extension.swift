//
//  Firebase-Extension.swift
//  tinder.RxSwift
//
//  Created by Rin on 2021/09/15.
//

import Firebase

extension Auth {
    static func createUserToFireAuth(email: String?, password: String?, name: String?, completion: @escaping (Bool) -> ()) {
        guard let email = email else { return }
        guard let password = password else { return }
        Auth.auth().createUser(withEmail: email, password: password) { auth, err in
            if let err = err {
                print("auth情報の作成に失敗", err)
                return
            }
            guard let uid = auth?.user.uid else { return }
            print("auth情報の保存に成功", uid)

            Firestore.setUserDataToFireStore(email: email, uid: uid, name: name) { success in
                completion(success)
            }
        }
    }
}


extension Firestore {
    static func setUserDataToFireStore(email: String, uid: String, name: String?, completion: @escaping (Bool) -> ()) {
        guard let name = name else { return }
        let document = [
            "name": name,
            "email": email,
            "createdAt": Timestamp()
        ] as [String : Any]

        Firestore.firestore().collection("users").document(uid).setData(document) { err in
            if let err = err {
                print("ユーザー情報のfirestore保存の失敗", err)
                return
            }
            completion(true)
            print("ユーザー情報のfirestore保存の成功")
        }
    }
}
