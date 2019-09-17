//
//  ViewController.swift
//  BestFitMe
//
//  Created by Титов Валентин on 16/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

  let disposeBag: DisposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupDI()
  }

  func setupDI() {}

  
  func subscribeKeyboardNotifications() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(keyboardWillShow),
                                           name: UIResponder.keyboardWillShowNotification,
                                           object: nil)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(keyboardWillHide),
                                           name:UIResponder.keyboardWillHideNotification,
                                           object: nil)
  }
  
  func unsubscribeKeyboardNotifications() {
    NotificationCenter.default.removeObserver(self)
  }
  
  @objc func keyboardWillShow(notification: NSNotification) { }
  
  @objc func keyboardWillHide() { }
  
}


//MARK: Default error
extension ViewController {
  
  func showError(title: String,
                 message: String) {
    let alertVC: UIAlertController = UIAlertController.init(title: title,
                                                            message: message,
                                                            preferredStyle: .alert)
    alertVC.addAction(UIAlertAction.init(title: "Ok".localized(),
                                         style: .cancel,
                                         handler: nil))
    present(alertVC, animated: true,
            completion: nil)
    
  }
}

