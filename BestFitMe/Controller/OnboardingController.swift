//
//  OnboardingController.swift
//  BestFitMe
//
//  Created by Титов Валентин on 30/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit

class OnboardingController: ViewController,
OnboardingViewProtocol {
  
  /* UI Elements */
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var skipButton: UIButton!
  @IBOutlet weak var pageControl: UIPageControl!
  /* Presenter */
  var presenter: OnboardingPresenterProtocol!
  
  //MARK: - Implementation
  override func setupDI() {
    presenter = OnboardingPresenter(view: self)
    presenter.didStart()
  }
  
  func initView() {
    skipButton.rx.tap.subscribe(onNext: {[unowned self] (_) in
      self.presenter.didTapSkipButton()
    }).disposed(by: disposeBag)
    
  }
  
  func setPlaceholders() {
    
  }
  
  func setPageControlNumbers(_ numbers: Int) {
    
  }
  
  func setCurrentPage(number: Int) {
    
  }
  
  func placeOnboardingItem(with title: String,
                           details: String,
                           image: UIImage) {
    
  }
  
  
    // MARK: - Navigation
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
