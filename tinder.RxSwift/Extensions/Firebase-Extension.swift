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

    static func loginWithFireAuth(email: String, password: String, completioin: @escaping (Bool) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { res, err in
            if let err = err {
                print("loginに失敗", err)
                completioin(false)
                return
            }
            print("loginに成功")
            completioin(true)
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

    static func fetchUserFromFirestore(uid: String, completion: @escaping (User?) -> ()) {
        Firestore.firestore().collection("users").document(uid).addSnapshotListener { res, err in
        //Firestore.firestore().collection("users").document(uid).getDocument { res, err in
            if let err = err {
                print("ユーザー情報の取得に失敗: ", err)
                completion(nil)
                return
            }

            guard let data = res?.data() else { return }
            let user = User(dic: data)
            completion(user)
        }
    }

    // firebaseから自分以外のユーザーの情報を取得
    static func fetchUsers(completion: @escaping ([User]) -> ()) {

       Firestore.firestore().collection("users").getDocuments { res, err in
            if let err = err {
                print("ユーザー情報の取得に失敗: ", err)
                return
            }

            let users = res?.documents.map({ snapshot -> User in
                let dic = snapshot.data()
                let user = User(dic: dic)
                return user
            })

            completion(users ?? [User]())
         }
    }

    static func updateUserInfo(dic: [String: Any], completion: @escaping () -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(uid).updateData(dic) { err in
            if let err = err {
                print("ユーザーデータのアップデート失敗: ", err)
            }
            completion()
            print("ユーザー情報のアップデートに成功")
        }
    }
}
