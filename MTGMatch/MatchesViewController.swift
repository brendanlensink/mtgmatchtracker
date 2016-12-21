//
//  MatchesViewController.swift
//  MTGMatchTracker
//
//  Created by Brendan Lensink on 2016-12-10.
//  Copyright © 2016 blensink. All rights reserved.
//

import UIKit
import CoreData

class MatchesViewController: UIViewController {
  
  private let viewModel: MatchesViewModel
  
  // MARK: - Lifecycle
  
  init() {
    viewModel = MatchesViewModel()
    
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
    
    // MARK: Make the background view and gradient
    
    let backgroundView = UIView()
    view.addSubview(backgroundView)
    
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
    viewModel.getMatches()
  }
  
}
