//
//  User.swift
//  tinder.RxSwift
//
//  Created by Rin on 2021/09/15.
//

import Foundation
import Firebase

final class User {

    var email: String
    var name: String
    var createdAt: Timestamp
    var age: String
    var residence: String
    var hobby: String
    var introduce: String


    init(dic: [String: Any]) {
        self.email = dic["email"] as? String ?? ""
        self.name = dic["name"] as? String ?? ""
        self.createdAt = dic["createdAt"] as? Timestamp ?? Timestamp()
        self.age = dic["age"] as? String ?? ""
        self.residence = dic["residence"] as? String ?? ""
        self.hobby = dic["hobby"] as? String ?? ""
        self.introduce = dic["introduce"] as? String ?? ""
    }
}
