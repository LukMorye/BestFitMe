//
//  Presenter.swift
//  BestFitMe
//
//  Created by Титов Валентин on 16/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import RxSwift

class Presenter {

  /* Internet parameters */
  let connectionSubject: PublishSubject<Bool> = PublishSubject()
  private let internetReachability = Reachability.forInternetConnection()
  /* Disposable */
  let disposeBag:DisposeBag = DisposeBag()
  
}

//MARK: Handle intenet connection
extension Presenter {
  /** Manual check internet connection
   */
  func hasConnectivity() -> Bool {
    let networkStatus:Int = internetReachability!.currentReachabilityStatus().rawValue
    return networkStatus != 0
  }
  
  /** Subscribe connection notification
   */
  func initInternetConnectionNotifier() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(self.changedInternetConnectionStatus),
                                           name: NSNotification.Name.reachabilityChanged,
                                           object: nil)
  }
  
  func startInternetConnectionNotifier() {
    internetReachability?.startNotifier()
  }
  
  func stopInternetConnectionNotifier() {
    internetReachability?.stopNotifier()
  }
  
  @objc func changedInternetConnectionStatus(_ notification:Notification) {
    if internetReachability!.currentReachabilityStatus() == NotReachable {
      print("Internet connection lost")
      DispatchQueue.main.async { self.connectionSubject.onNext(false) }
    } else if  internetReachability!.currentReachabilityStatus() != NotReachable {
      print("Internet connection appeared")
      DispatchQueue.main.async { self.connectionSubject.onNext(true) }
    }
  }
  
}
