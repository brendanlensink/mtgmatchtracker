//
//  TemplateViewController.swift
//  MTGMatchTracker
//
//  Created by Brendan Lensink on 2016-11-18.
//  Copyright © 2016 blensink. All rights reserved.
//

import UIKit

class TemplateViewController: UIViewController {
  
  private let viewModel: TemplateViewModel
  
  // MARK: - Lifecycle
  
  init() {
    viewModel = TemplateViewModel()
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("NSCoding is not supported")
  }
  
  // MARK: - View Lifecycle
  
  /**
   * Called by the OS when the view loads
   */
  override func viewDidLoad() {
//    self.title = Text.Title.template
    
    // MARK: Make the background view and gradient
    
    let backgroundView = UIView()
    
      // Snapkit
      backgroundView.snp.makeConstraints { make in
        make.edges.equalTo(view)
      }
    
    bindViewModel()
  }
  
  /**
   *  Called by the OS when the view appears
   */
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  /**
   * Called by the OS when the view has disappeared
   */
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
  }
  
  // MARK: - Reactive Bindings
  
  /**
   *  Set up and bind the reactive elements to the view model
   */
  private func bindViewModel() {
    
  }
  
}
