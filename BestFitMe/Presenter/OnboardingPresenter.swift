//
//  OnboardingPresenter.swift
//  BestFitMe
//
//  Created by Титов Валентин on 30/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit

protocol OnboardingPresenterProtocol {
  func didStart()
  func didTapSkipButton()
  func didTapPageControl(at number: Int)
}

protocol OnboardingViewProtocol: class {
  func initView()
  func setPlaceholders()
  func setPageControlNumbers(_ numbers: Int)
  func setCurrentPage(number: Int)
  func placeOnboardingItem(with title: String,
                           details: String,
                           image: UIImage)
}


class OnboardingPresenter: Presenter, OnboardingPresenterProtocol {
  /* View */
  private unowned let view: OnboardingViewProtocol
  
  //MARK: - Implementation
  init(view: OnboardingViewProtocol) {
    self.view = view
  }
  
  func didStart() {
    view.initView()
    view.setPlaceholders()
  }
  
  func didTapSkipButton() {
    
  }
  
  func didTapPageControl(at number: Int) {
    
  }
  
  
  
  
  
}
