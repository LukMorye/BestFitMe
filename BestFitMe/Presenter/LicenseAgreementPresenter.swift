//
//  LicenseAgreementPresenter.swift
//  BestFitMe
//
//  Created by Титов Валентин on 18/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit
import RxSwift

protocol LicenseAgreementPresenterProtocol {
  func didStart()
  func didTapAgreeCheckbox(isSelected: Bool)
  func didTapAgreementButton()
  func didTapCloseAgreementButton()
}

protocol LicenseAgreementViewProtocol: class {
  func initLicenseAgreementViewElements()
  func setLicenseAgreementViewPlaceholders()
  func alignLicenseAgreementViewElements()
  func setAgreeCheckboxSelected(_ isSelected: Bool)
  func hideKeyboard()
  func setShownLicenseAgreementView(isShown: Bool)
  func setAgreementText(_ text: String)
  func showError(title: String,
                 message: String)
  
}


class LicenseAgreementPresenter: Presenter, LicenseAgreementPresenterProtocol {

  private unowned let view: LicenseAgreementViewProtocol
  private let apiClient = ApiClient()
  
  //MARK: Implementation
  required init(view: LicenseAgreementViewProtocol) {
    self.view = view
  }
  
  func didStart() {
    requestAgreement()
    view.initLicenseAgreementViewElements()
    view.alignLicenseAgreementViewElements()
    view.setLicenseAgreementViewPlaceholders()
  }
  
  func didTapAgreeCheckbox(isSelected: Bool) {
    view.setAgreeCheckboxSelected(!isSelected)
  }
  
  func didTapAgreementButton() {
    view.hideKeyboard()
    view.setShownLicenseAgreementView(isShown: true)
  }
  
  func didTapCloseAgreementButton() {
    view.setShownLicenseAgreementView(isShown: false)
  }
  
  func requestAgreement() {
    let langID: String = Settings.langId().rawValue
    Observable<String>.just(langID).asObservable()
      .map { LegalRequest(location: $0) }
      .flatMap {(request) -> Observable<Legal> in
        return self.apiClient.send(apiRequest: request)
        
      }.subscribe(onNext: {(response) in
        print("Got legal")
        DispatchQueue.main.async {[unowned self] in
          self.view.setAgreementText(response.legal)
        }
      }, onError: {[unowned self] (error) in
        print(error)
        self.view.showError(title: "Error".localized(),
                            message: "Got legal error".localized())
      }).disposed(by: disposeBag)
  }
  
}
