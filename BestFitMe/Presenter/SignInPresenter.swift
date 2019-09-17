//
//  LoginPresenter.swift
//  BestFitMe
//
//  Created by Титов Валентин on 16/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit

protocol SignInPresenterProtocol {
  func didStart()
  func willShowKeyboard(with frame: CGRect,
                        contentInset: UIEdgeInsets)
  func willHideKeyBoard()
  func willFocusOnEmail()
  func willFocusOnPassword()
  func didTapSignInWith(email: String?,
                        password: String?,
                        isAgree: Bool?)
  func didTapSignUpButton()
  
}

protocol SignInViewProtocol: class {
  func initSignInView()
  func alignSignInElements()
  func setSignInPlaceholders()
  func setDefaultFocusOnAllFields()
  func setFocusOnEmail()
  func setFocusOnPassword()
  func changeScrollViewContent(inset: UIEdgeInsets)
  func wrongParamMessage(with message: String?)
  func setShownProgress(_ isShown: Bool)
  func navigateToRegistrationController()
  func navigateToOnboardingController()
}

class SignInPresenter: Presenter, SignInPresenterProtocol {

  /* View */
  private unowned let view: SignInViewProtocol
  /* Interactor */
  private let interactor: AccountInteractor
  
  
  //MARK: Implementation
  init(view: SignInViewProtocol,
       interactor: AccountInteractor) {
    self.view = view
    self.interactor = interactor
    super.init()
    self.subscribeAccountInteractor()
  }
  
  func didStart() {
    view.initSignInView()
    view.alignSignInElements()
    view.setSignInPlaceholders()
  }
  
  func willFocusOnEmail() {
    view.setDefaultFocusOnAllFields()
    view.setFocusOnEmail()
  }
  
  func willFocusOnPassword() {
    view.setDefaultFocusOnAllFields()
    view.setFocusOnPassword()
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
  
  func didTapSignInWith(email: String?,
                        password: String?,
                        isAgree:Bool?) {
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
    interactor.authorization(email: login,
                             password: pass)
  }
  
  func didTapSignUpButton() {
    view.navigateToRegistrationController()
  }
  
  //MARK: Account Interactor
  private func subscribeAccountInteractor() {
    interactor.authSubject.subscribe(onNext: {[weak self] in
      self?.view.navigateToOnboardingController()
    }).disposed(by: disposeBag)
    interactor.errorSubject.subscribe(onNext: {[weak self] (error) in
      self?.handleAccountInteractor(error: error)
    }).disposed(by: disposeBag)
  }
  
  private func handleAccountInteractor(error: AccountInteractorError) {
    switch error {
    case .userNotFound: view.wrongParamMessage(with: "User not found".localized())
    case .authorization: view.wrongParamMessage(with: "Authorization error".localized())
    default: view.wrongParamMessage(with: "Unknown error".localized())
    }
    view.setShownProgress(false)
  }
  
}
