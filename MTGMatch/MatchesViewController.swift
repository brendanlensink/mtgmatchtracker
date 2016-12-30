//
//  MatchesViewController.swift
//  MTGMatchTracker
//
//  Created by Brendan Lensink on 2016-12-10.
//  Copyright © 2016 blensink. All rights reserved.
//

import UIKit
import MessageUI
import CoreData

class MatchesViewController: UIViewController {
  
  fileprivate let viewModel: MatchesViewModel
  
  // MARK: - UI Elements

  fileprivate let exportButton: UIButton
  fileprivate let matchesTable: UITableView
  fileprivate let matchCellIdentifier = "MatchCell"
  
  // MARK: - Lifecycle
  
  init() {
    viewModel = MatchesViewModel()
    
    exportButton = UIButton()
    matchesTable = UITableView()
    
    // MARK: Load all the matches stored on the device
    
    // TODO: Add view model load function
    
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
    
    self.navigationController?.isNavigationBarHidden = true
    
    // MARK: Make the background view and gradient
    
    let backgroundView = UIView()
    backgroundView.backgroundColor = Color.background
    view.addSubview(backgroundView)
    
      // Snapkit
      backgroundView.snp.makeConstraints { make in
        make.edges.equalTo(view)
      }
    
    // MARK: If there are matches to display show them, otherwise show a placeholder message
    
    // MARK: But actually make the export all button first so we can size the table off it
    
    exportButton.setTitle(Text.Matches.export, for: .normal)
    exportButton.setTitleColor(Color.Button.Text.primary, for: .normal)
    exportButton.contentHorizontalAlignment = .right
    view.addSubview(exportButton)
    
      // Snapkit
      exportButton.snp.makeConstraints { make in
        make.bottom.equalTo(view).offset(GC.Margin.bottom)
        make.left.equalTo(view).offset(GC.Margin.left)
        make.right.equalTo(view).offset(GC.Margin.right)
      }
    
    matchesTable.delegate = self
    matchesTable.dataSource = self
    matchesTable.register(MatchCell.self, forCellReuseIdentifier: matchCellIdentifier)
    matchesTable.estimatedRowHeight = 100
    matchesTable.rowHeight = UITableViewAutomaticDimension
    matchesTable.separatorColor = Color.background
    matchesTable.backgroundColor = Color.background
    matchesTable.tableFooterView = UIView()
    view.addSubview(matchesTable)
    
      // Snapkit
      matchesTable.snp.makeConstraints { make in
        make.top.equalTo(view).offset(GC.Margin.top)
        make.bottom.equalTo(exportButton.snp.top).offset(GC.Padding.vertical)
        make.left.right.equalTo(view)
      }
    
    // MARK: Make the matches table
    
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
    
    exportButton.reactive.controlEvents(.touchUpInside).observeValues { _ in
      let emailViewController = self.viewModel.emailCSV(self.viewModel.exportCSV())
      emailViewController.mailComposeDelegate = self
      
      if MFMailComposeViewController.canSendMail() {
        self.present(emailViewController, animated: true, completion: nil)
      }
    }
  }
}

extension MatchesViewController: UITableViewDelegate {
  
  /**
   *  Called when a match cell is selected.
   *
   *  - Parameters:
   *    - tableView: A table-view object informing the delegate about the new row selection
   *    - indexPath: An index path locating the new selected row in `tableView`
   */
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 0
  }
}

// MARK: - UITableViewDataSource

extension MatchesViewController: UITableViewDataSource {
  
  /**
   *  The number of sections in the TableView
   *
   *  - Parameters:
   *    - tableView: An object representing the table view requesting this information
   *
   *  - Returns: The number of sections in the `tableView`
   */
  func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.numberOfSections()
  }
  
  /**
   *  The number of rows in a given TableView section
   *
   *  - Parameters:
   *    - tableView: An object representing the table view requesting this information
   *    - section: An index number identifying a section in `tableView`
   *
   *  - Returns: The number of rows in `section`
   */
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfMatchesInSection(section)
  }
  
  /**
   *  The cell at a given index path
   *
   *  - Parameters:
   *    - tableView: An object representing the table view requesting this information
   *    - indexPath: An index path locating a row in `tableView`
   *
   *  - Returns: The cell at `indexPath`, containing a name and an email address or phone number
   */
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {
      
      let cell = tableView
        .dequeueReusableCell(withIdentifier: matchCellIdentifier, for: indexPath)
        as! MatchCell
      
      let match = viewModel.getMatchAt(index: indexPath.row)
      cell.setMatchInfo(match: match)
      return cell
  }
}

// MARK: - MFMailComposeViewControllerDelegate Method

extension MatchesViewController: MFMailComposeViewControllerDelegate {
  
  /**
   *  Dismisses the mail view controller once it's done
   */
  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    controller.dismiss(animated: true, completion: nil)
  }
}
