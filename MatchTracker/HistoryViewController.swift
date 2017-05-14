//
//  HistoryViewController.swift
//  MatchTracker
//
//  Created by Brendan Lensink on 2017-05-13.
//  Copyright © 2017 Brendan Lensink. All rights reserved.
//

import UIKit
import Eureka
import MessageUI

class HistoryViewController: FormViewController {
    
    fileprivate let viewModel: HistoryViewModel
    
    // MARK: View Lifecycle
    
    init() {
        viewModel = HistoryViewModel()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let exportButton = UIBarButtonItem(title: "EXPORT", style: .done, target: self, action: #selector(HistoryViewController.exportCSV))
        self.navigationItem.rightBarButtonItem = exportButton
        
        form +++ Section("Match History")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.refreshMatchHistory()
        
        for match in viewModel.matches {
            form.last! <<< MatchSummaryRow() {
                $0.cell.match = match
                $0.onCellSelection { _ in
                    self.navigationController?.pushViewController(MatchViewController(match: match), animated: true)
                }
            }
        }
    }
}

extension HistoryViewController: MFMailComposeViewControllerDelegate {
    @objc fileprivate func exportCSV() {
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        composeVC.setSubject("Match History CSV")
        composeVC.setMessageBody("Have a nice day.", isHTML: false)
        composeVC.mailComposeDelegate = self
        
        guard MFMailComposeViewController.canSendMail() else { return }
        
        if let data = viewModel.exportCSV() {
            composeVC.addAttachmentData(data, mimeType: "text/csv", fileName: "history.csv")
            navigationController?.present(composeVC, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
