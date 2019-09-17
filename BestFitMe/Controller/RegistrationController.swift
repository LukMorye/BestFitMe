//
//  RegistrationController.swift
//  BestFitMe
//
//  Created by Титов Валентин on 16/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit
import RxSwift

class RegistrationController: ViewController,
RegistrationViewProtocol,
LicenseAgreementViewProtocol {

  /* UI Elements */
  @IBOutlet weak var topView: TopView!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var fieldsContainer: FieldsContainer!
  @IBOutlet weak var licenseContainer: LicenseContainer!
  @IBOutlet weak var buttonsContainer: ButtonsContainer!
  @IBOutlet weak var agreementView: AgreementView!
  @IBOutlet weak var completeRegistrationView: CompleteRegistrationView!
  /* Presenter */
  private var presenter: RegistrationPresenterProtocol!
  private var laPresenter: LicenseAgreementPresenterProtocol!
  
  //MARK: Implementation
  override func viewDidLoad() {
    super.viewDidLoad()
    fieldsContainer.nameField.becomeFirstResponder()
    subscribeKeyboardNotifications()
  }
  
  override func setupDI() {
    presenter = RegistrationPresenter(view: self,
                                      interactor: AccountInteractor(userDefaultsService: UserDefaultsService()))
    presenter.didStart()
    laPresenter = LicenseAgreementPresenter(view: self)
    laPresenter.didStart()
  }
  
  func initRegistrationView() {
    fieldsContainer.setDefaultFieldStates()
    let beginEditing = UIControl.Event.editingDidBegin
    fieldsContainer.nameField.rx.controlEvent(beginEditing)
      .subscribe({[weak self] (_) in
        self?.presenter.willFocusOnName()
      }).disposed(by: disposeBag)
    fieldsContainer.phoneField.rx.controlEvent(beginEditing)
      .subscribe({[weak self] (_) in
        self?.presenter.willFocusOnPhone()
      }).disposed(by: disposeBag)
    fieldsContainer.emailFIeld.rx.controlEvent(beginEditing)
      .subscribe({[weak self] (_) in
        self?.presenter.willFocusOnEmail()
      }).disposed(by: disposeBag)
    fieldsContainer.passwordField.rx.controlEvent(beginEditing)
      .subscribe({[weak self] (_) in
        self?.presenter.willFocusOnPassword()
      }).disposed(by: disposeBag)
    buttonsContainer.registrationButton.rx.tap
      .subscribe(onNext: {[weak self] (_) in
        self?.presenter
          .didTapRegistrateWith(name: self?.fieldsContainer.nameField.text,
                                phone: self?.fieldsContainer.phoneField.text,
                                email: self?.fieldsContainer.emailFIeld.text,
                                password: self?.fieldsContainer.passwordField.text,
                                isAgree: self?.licenseContainer.agreeButton.isSelected)
      }).disposed(by: disposeBag)
    buttonsContainer.authButton.rx.tap
      .subscribe(onNext: {[weak self] (_) in
        self?.presenter.didTapAuthorizeButton()
      }).disposed(by: disposeBag)
    completeRegistrationView.nextButton.rx.tap
      .subscribe(onNext: {[weak self] (_) in
        self?.presenter.didTapEndRegistrationButton()
      }).disposed(by: disposeBag)
  }
  
  func alignRegistrationElements() {
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
    buttonsContainer.registrationButton.changeHeight(newHeight: Constants.viewHeight)
    buttonsContainer.authButton.addPinEdge(.top,
                                           toEdge: .bottom,
                                           toView: buttonsContainer.registrationButton,
                                           inset: Constants.offset)
    completeRegistrationView.alignElementsFor(device: UIDevice.current.userInterfaceIdiom)
  }

  func setRegistrationPlaceholders() {
      completeRegistrationView.fill(title: "Registration complete title".localized(),
                                    details: "Registration complete message".localized(),
                                    nextTitle: "Continue".localized())
  }
  
  
  //MARK: Change fields presentation
  func setDefaultFocusOnAllFields() {
    animateColor(.nuance, for: fieldsContainer.nameField)
    animateColor(.nuance, for: fieldsContainer.phoneField)
    animateColor(.nuance, for: fieldsContainer.emailFIeld)
    animateColor(.nuance, for: fieldsContainer.passwordField)
  }
  
  func setFocusOnName() {
    animateColor(.primary, for: fieldsContainer.nameField)
  }
  func setFocusOnPhone() {
    animateColor(.primary, for: fieldsContainer.phoneField)
  }
  func setFocusOnEmail() {
    animateColor(.primary, for: fieldsContainer.emailFIeld)
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
  
  
  //MARK: Complete Registration View
  func setShownCompleteRegistrationView(_ isShown: Bool) {
    completeRegistrationView.shownWithDefaultAnimation(isShown,
                                                       duration: AnimationSpeed.speed3.rawValue)
  }
  
  
  //MARK: Progress
  func setShownProgress(_ isShown: Bool) {
    if isShown { topView.startProgress() }
    else { topView.stopProgress() }
  }

  
  //MARK: Navigation
  func navigateToLoginController() {
    performSegue(withIdentifier: SegueIdentifier.showLoginController.rawValue,
                 sender: self)
  }
  
  func navigateToOnboardingController() {
    performSegue(withIdentifier: SegueIdentifier.showOnboardingController.rawValue,
                 sender: self)
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
