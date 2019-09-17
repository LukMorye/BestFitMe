//
//  RegistrationPresenter.swift
//  BestFitMe
//
//  Created by Титов Валентин on 16/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit

protocol RegistrationPresenterProtocol {
  func didStart()
  func willShowKeyboard(with frame: CGRect,
                        contentInset: UIEdgeInsets)
  func willHideKeyBoard()
  func willFocusOnName()
  func willFocusOnPhone()
  func willFocusOnEmail()
  func willFocusOnPassword()
  func didTapRegistrateWith(name: String?,
                            phone: String?,
                            email: String?,
                            password: String?,
                            isAgree:Bool?)
  func didTapEndRegistrationButton()
  func didTapAuthorizeButton()
}

protocol RegistrationViewProtocol: class {
  func initRegistrationView()
  func alignRegistrationElements()
  func setRegistrationPlaceholders()
  func setDefaultFocusOnAllFields()
  func setFocusOnName()
  func setFocusOnPhone()
  func setFocusOnEmail()
  func setFocusOnPassword()
  func changeScrollViewContent(inset: UIEdgeInsets)
  func wrongParamMessage(with message: String?)
  func setShownProgress(_ isShown: Bool)
  func setShownCompleteRegistrationView(_ isShown: Bool)
  func navigateToLoginController()
  func navigateToOnboardingController()
}


class RegistrationPresenter: Presenter, RegistrationPresenterProtocol {
  /* View */
  private unowned let view: RegistrationViewProtocol
  /* Interactor */
  private let interactor: AccountInteractor
  
  
  //MARK: Implementation
  init(view: RegistrationViewProtocol,
       interactor: AccountInteractor) {
    self.view = view
    self.interactor = interactor
    super.init()
    subscribeAccountInteractor()
  }
  
  func didStart() {
    view.initRegistrationView()
    view.alignRegistrationElements()
    view.setRegistrationPlaceholders()
  }
  
  
  //MARK: Handle Fields events
  func willFocusOnName() {
    view.setDefaultFocusOnAllFields()
    view.setFocusOnName()
  }
  
  func willFocusOnPhone() {
    view.setDefaultFocusOnAllFields()
    view.setFocusOnPhone()
  }
  
  func willFocusOnEmail() {
    view.setDefaultFocusOnAllFields()
    view.setFocusOnEmail()
  }
  
  func willFocusOnPassword() {
    view.setDefaultFocusOnAllFields()
    view.setFocusOnPassword()
  }
  
  
  //MARK: Handle buttons events
  func didTapRegistrateWith(name: String?,
                            phone: String?,
                            email: String?,
                            password: String?,
                            isAgree:Bool?) {
    if String.isEmpty(text: name) {
      view.wrongParamMessage(with: "Name empty".localized())
      return
    }
    if String.isEmpty(text: phone) {
      view.wrongParamMessage(with: "Phone empty".localized())
      return
    }
    guard let login: String = email, login.isValidEmail() else {
      view.wrongParamMessage(with: "Email is not valid".localized())
      return
    }
    guard let pass: String = password, pass.count >= Constants.kPasswordMinLength  else {
      view.wrongParamMessage(with: "Password is too short".localized())
      return
    }
    guard let agree: Bool = isAgree, agree == true else {
      view.wrongParamMessage(with: "Should agree message".localized())
      return
    }
    if !hasConnectivity() {
      view.wrongParamMessage(with: "Need connection".localized())
      return
    }
    view.wrongParamMessage(with: nil)
    view.setShownProgress(true)
    interactor.registrateUser(with: name!,
                              phone: phone!,
                              email: login,
                              password: pass)
  }
  
  func didTapAuthorizeButton() {
    view.navigateToLoginController()
  }
  
  func didTapEndRegistrationButton() {
    view.navigateToOnboardingController()
  }
  
  
  //MARK: Keyboard events
  func willShowKeyboard(with frame: CGRect,
                        contentInset: UIEdgeInsets) {
    var inset: UIEdgeInsets = contentInset
    inset.bottom = frame.size.height
    view.changeScrollViewContent(inset: inset)
  }
  
  func willHideKeyBoard() {
    view.changeScrollViewContent(inset: .zero)
  }
  
  //MARK: Auth interactor
  private func subscribeAccountInteractor() {
    interactor.authSubject.subscribe(onNext: {[weak self] in
      DispatchQueue.main.async { self?.view.setShownCompleteRegistrationView(true) }
    }).disposed(by: disposeBag)
    interactor.errorSubject.subscribe(onNext: {[weak self] (error) in
      DispatchQueue.main.async { self?.handleAccountInteractor(error: error) }
    }).disposed(by: disposeBag)
  }
  
  private func handleAccountInteractor(error: AccountInteractorError) {
    switch error {
    case .existAccount: view.wrongParamMessage(with: "Account already exist".localized())
    case .registration: view.wrongParamMessage(with: "Registration error".localized())
    default: view.wrongParamMessage(with: "Unknown error".localized())
    }
  }
  
}
