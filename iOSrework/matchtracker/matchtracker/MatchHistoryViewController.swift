//
//  MatchHistoryViewController.swift
//  matchtracker
//
//  Created by Brendan Lensink on 2017-04-27.
//  Copyright © 2017 blensink. All rights reserved.
//

import UIKit

class MatchHistoryViewController: UIViewController {
    
    fileprivate let viewModel: MatchHistoryViewModel
    fileprivate let tableView: UITableView

    // MARK: View Lifecycle
    
    init() {
        viewModel = MatchHistoryViewModel()
        
        tableView = UITableView()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let exportButton = UIBarButtonItem(title: "EXPORT", style: .done, target: self, action: #selector(MatchHistoryViewController.exportCSV))
        self.navigationItem.rightBarButtonItem = exportButton
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Color.background
        tableView.estimatedRowHeight = 80
        tableView.register(UINib(nibName: "MatchCell", bundle: nil) , forCellReuseIdentifier: "matchCell")
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        
            tableView.snp.makeConstraints { make in
                make.edges.equalTo(view)
            }
    }
    
    // MARK: Helper Functions
    
    @objc private func exportCSV() {
        viewModel.exportCSV()
    }
}

extension MatchHistoryViewController: UITableViewDelegate {
    
}

extension MatchHistoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Handle table cell selection
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getMatchCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "matchCell", for: indexPath) as! MatchCell
        let match = viewModel.getMatchAt(index: indexPath.row)
        if let date = match.created {
            cell.timeLabel.text = DateManager.shared.toString(date: date)
        }
        if let format = match.format { cell.formatLabel.text = format.title }
        cell.accessoryType = .disclosureIndicator
        cell.resultLabel.text = match.getResult()
        
        return cell
    }
}
