//
//  LoginViewModel.swift
//  LoginValidation
//
//  Created by Jeongbae Kong on 2020/09/05.
//  Copyright © 2020 Jeongbae Kong. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
  
  var emailText = BehaviorRelay<String>(value: "")
  var passwordText = BehaviorRelay<String>(value: "")
  
  func isValidEmail(email: String) -> Bool {
      let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

      let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
      return emailPred.evaluate(with: email)
  }
  
  
  
  var validCheck: Observable<Bool> {
    let check = Observable.combineLatest(
      emailText.asObservable(),
      passwordText.asObservable()
    )
    
    let isEnableNext = check.map { email, password in
      self.isValidEmail(email: email) && email.count > 3 && password.count > 3
    }
    
    return isEnableNext
  }
}
