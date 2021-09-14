//
//  RegisterTextField.swift
//  tinder.RxSwift
//
//  Created by Rin on 2021/09/14.
//

import UIKit

class RegisterTextField: UITextField {

    init(frame: CGRect, placeHolder: String, fontSize: CGFloat) {
        super.init(frame: frame)
        placeholder = placeHolder
        borderStyle = .roundedRect
        font = .systemFont(ofSize: fontSize)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
