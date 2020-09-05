//
//  ViewController.swift
//  LoginValidation
//
//  Created by Jeongbae Kong on 2020/09/05.
//  Copyright © 2020 Jeongbae Kong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
  
  let viewModel = LoginViewModel()
  var disposeBag = DisposeBag()
  
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var nextButton: UIButton!
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  private func setup() {
    
    emailTextField.rx.text.orEmpty
      .bind(to: viewModel.emailText)
      .disposed(by: disposeBag)
    
    passwordTextField.rx.text.orEmpty
      .bind(to: viewModel.passwordText)
      .disposed(by: disposeBag)
    
    viewModel.validCheck
      .map { $0 }
      .bind(to: nextButton.rx.isEnabled)
      .disposed(by: disposeBag)
    
    viewModel.validCheck
      .subscribe(onNext: { [weak self] in
        guard let `self` = self else { return }
        self.nextButton.backgroundColor = $0 ? .red : .gray
        self.nextButton.tintColor = .white
        let buttonText = $0 ? "Button is enabled" : "Button is disabled"
        self.nextButton.setTitle(buttonText, for: .normal)
      })
    .disposed(by: disposeBag)
  }
}

