//
//  LoginController.swift
//  BestFitMe
//
//  Created by Титов Валентин on 16/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit

class SignInController: ViewController,
SignInViewProtocol,
LicenseAgreementViewProtocol {
  
  /* UI Elements */
  @IBOutlet weak var topView: TopView!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var fieldsContainer: SignInFieldsContainer!
  @IBOutlet weak var licenseContainer: LicenseContainer!
  @IBOutlet weak var buttonsContainer: SignInButtonsContainer!
  @IBOutlet weak var agreementView: AgreementView!
  /* Presenters */
  private var presenter: SignInPresenterProtocol!
  private var laPresenter: LicenseAgreementPresenterProtocol!
  
  
  //MARK: Implementation
  override func viewDidLoad() {
    super.viewDidLoad()
    subscribeKeyboardNotifications()
  }
  
  override func setupDI() {
    presenter = SignInPresenter(view: self,
                                interactor: AccountInteractor(userDefaultsService: UserDefaultsService()))
    presenter.didStart()
    laPresenter = LicenseAgreementPresenter(view: self)
    laPresenter.didStart()
  }
  
  func initSignInView() {
    fieldsContainer.setDefaultFieldStates()
    let beginEditing = UIControl.Event.editingDidBegin
    
    fieldsContainer.emailField.rx.controlEvent(beginEditing)
      .subscribe({[weak self] (_) in
        self?.presenter.willFocusOnEmail()
      }).disposed(by: disposeBag)
    fieldsContainer.passwordField.rx.controlEvent(beginEditing)
      .subscribe({[weak self] (_) in
        self?.presenter.willFocusOnPassword()
      }).disposed(by: disposeBag)
    buttonsContainer.signInButton.rx.tap
      .subscribe(onNext: {[weak self] (_) in
        self?.presenter
          .didTapSignInWith(email: self?.fieldsContainer.emailField.text,
                            password: self?.fieldsContainer.passwordField.text,
                            isAgree: self?.licenseContainer.agreeButton.isSelected)
      }).disposed(by: disposeBag)
    buttonsContainer.signUpButton.rx.tap
      .subscribe(onNext: {[weak self] (_) in
        self?.presenter.didTapSignUpButton()
      }).disposed(by: disposeBag)
  }
  
  func alignSignInElements() {
    scrollView.leadPinToHalfRow()
    scrollView.trailPinToHalfRow()
    licenseContainer.addPinEdge(.top,
                                toEdge: .bottom,
                                toView: fieldsContainer,
                                inset: Constants.offset)
    licenseContainer.changeHeight(newHeight: LicenseContainer.kLicenseHeight)
    buttonsContainer.addPinEdge(.top,
                                toEdge: .bottom,
                                toView: licenseContainer,
                                inset: Constants.rowWidth)
    buttonsContainer.signInButton.changeHeight(newHeight: Constants.viewHeight)
    buttonsContainer.signUpButton.addPinEdge(.top,
                                             toEdge: .bottom,
                                             toView: buttonsContainer.signInButton,
                                             inset: Constants.offset)
  }
  
  func setSignInPlaceholders() {
    buttonsContainer.fill(authTitle: "Enter".localized(),
                          regTitle: "Sign Up".localized())
  }
  
  
  //MARK: Change fields presentation
  func setDefaultFocusOnAllFields() {
    animateColor(.nuance, for: fieldsContainer.emailField)
    animateColor(.nuance, for: fieldsContainer.passwordField)
  }
  
  func setFocusOnEmail() {
    animateColor(.primary, for: fieldsContainer.emailField)
  }
  
  func setFocusOnPassword() {
    animateColor(.primary, for: fieldsContainer.passwordField)
  }
  
  private func animateColor(_ color: UIColor,
                            for field: AppField) {
    field.border.animateTo(color: color,
                           duration: AnimationSpeed.speed3.rawValue)
  }
  
  func wrongParamMessage(with message: String?) {
    topView.fillError(message: message)
  }
  
  func setShownProgress(_ isShown: Bool) {
    if isShown { topView.startProgress() }
    else { topView.stopProgress() }
  }
  
  
  //MARK: Navigation
  func navigateToRegistrationController() {
    navigationController?.popViewController(animated: true)
  }
  
  func navigateToOnboardingController() {
    performSegue(withIdentifier: SegueIdentifier.showOnboardingController.rawValue,
                 sender: self)
  }
  
  
//MARK: License agreement view protocol
  func initLicenseAgreementViewElements() {
    let agreeCheckbox: UIButton = licenseContainer.agreeButton
    agreeCheckbox.rx.tap
      .subscribe(onNext: {[unowned self] (_) in
        self.laPresenter.didTapAgreeCheckbox(isSelected: agreeCheckbox.isSelected)
      }).disposed(by: disposeBag)
    licenseContainer.licenseButton.rx.tap
      .subscribe(onNext: {[unowned self] (_) in
        self.laPresenter.didTapAgreementButton()
      }).disposed(by: disposeBag)
    agreementView.closeButton.rx.tap
      .subscribe(onNext: {[unowned self] (_) in
        self.laPresenter.didTapCloseAgreementButton()
      }).disposed(by: disposeBag)
  }
  
  func setShownLicenseAgreementView(isShown: Bool) {
    agreementView.shownWithDefaultAnimation(isShown,
                                            duration: AnimationSpeed.speed3.rawValue)
  }
  
  func setLicenseAgreementViewPlaceholders() {
    agreementView.fillTitle("License agreement title".localized())
    agreementView.fillTextPlaceholder("License agreement load details".localized())
    licenseContainer.fill(agree: "I agree with terms".localized(),
                          license: "License agreement".localized())
  }
  
  func alignLicenseAgreementViewElements() {
    agreementView.alignViewElements()
  }
  
  func setAgreementText(_ text: String) {
    agreementView.fillText(text)
  }
  
  func setAgreeCheckboxSelected(_ isSelected: Bool) {
    licenseContainer.agreeButton.isSelected = isSelected
  }
  
  
  //MARK: Keyboard Notification
  @objc override func keyboardWillShow(notification: NSNotification) {
    var userInfo = notification.userInfo!
    let keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
    presenter.willShowKeyboard(with: view.convert(keyboardFrame, from: nil),
                               contentInset: scrollView.contentInset)
  }
  
  func hideKeyboard() {
    view.endEditing(true)
  }
  
  @objc override func keyboardWillHide() {
    presenter.willHideKeyBoard()
  }
  
  func changeScrollViewContent(inset: UIEdgeInsets) {
    scrollView.contentInset = inset
  }
  
}
