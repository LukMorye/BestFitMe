//
//  AccountInteractor.swift
//  BestFitMe
//
//  Created by Титов Валентин on 16/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit
import AdSupport
import RxSwift

enum AccountInteractorError: Error {
  case existAccount, registration, userNotFound,authorization
}

class AccountInteractor: Interactor {

  /* Observable */
  let authSubject: PublishSubject<Void> = PublishSubject()
  let errorSubject: PublishSubject<AccountInteractorError> = PublishSubject()
  /* Api Client */
  private let apiClient: ApiClient = ApiClient()
  /* User Defaults service */
  let userDefaultsService: UserDefaultsService
  
  //MARK: Implementation
  init(userDefaultsService: UserDefaultsService) {
    self.userDefaultsService = userDefaultsService
  }
  
  func registrateUser(with name: String,
                      phone: String,
                      email: String,
                      password: String) {
    let device = UIDevice.current
    var params:[String: Any] = [String: Any]()
    params[RegistrateRequest.kName] = name
    params[RegistrateRequest.kPhone] = phone
    params[RegistrateRequest.kEmail] = email
    params[RegistrateRequest.kPassword] = password
    params[RegistrateRequest.kDeviceModel] = UIDevice.modelName.rawValue
    params[RegistrateRequest.kDeviceOS] = device.systemName + device.systemVersion
    params[RegistrateRequest.kDeviceLang] = Settings.langId().rawValue
    params[RegistrateRequest.kAppVersion] = Settings.appVersion()
    if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
      params[RegistrateRequest.kIdfa] = ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    Observable<[String:Any]>.just(params).asObservable()
      .map { RegistrateRequest(parameters: $0) }
      .flatMap {(request) -> Observable<RegistrateInfo> in
        return self.apiClient.send(apiRequest: request)
      }.subscribe(onNext: {(response) in
        self.authorization(email: email,
                           password: password)
      }, onError: {[unowned self] (error) in
        print(error)
        DispatchQueue.main.async {
          //MARK: Check if account exist
          self.errorSubject.onNext(.registration)
        }
      }).disposed(by: disposeBag)
  }
  
  func authorization(email: String,
                     password: String) {
    let device = UIDevice.current
    var params:[String: Any] = [String: Any]()
    params[RegistrateRequest.kEmail] = email
    params[RegistrateRequest.kPassword] = password
    params[RegistrateRequest.kDeviceModel] = UIDevice.modelName.rawValue
    params[RegistrateRequest.kDeviceOS] = device.systemName + device.systemVersion
    params[RegistrateRequest.kDeviceLang] = Settings.langId().rawValue
    params[RegistrateRequest.kAppVersion] = Settings.appVersion()
    if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
      params[RegistrateRequest.kIdfa] = ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    Observable<[String:Any]>.just(params).asObservable()
      .map { AuthRequest(parameters: $0) }
      .flatMap {(request) -> Observable<Token> in
        return self.apiClient.send(apiRequest: request)
      }.subscribe(onNext: {(token) in
        self.userDefaultsService.save(token: token,
                                      for: email)
        DispatchQueue.main.async { self.authSubject.onNext(())}
      }, onError: {[unowned self] (error) in
        print(error)
        DispatchQueue.main.async {
          //MARK: Check if account exist
          self.errorSubject.onNext(.authorization)
        }
      }).disposed(by: disposeBag)
  }
  
}
