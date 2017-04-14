//
//  NewMatchViewController.swift
//  matchtracker
//
//  Created by Brendan Lensink on 2017-04-12.
//  Copyright © 2017 blensink. All rights reserved.
//

import UIKit
import SnapKit

class NewMatchViewController: UIViewController {
    
    // MARK: UI Elements
    
    private var dateLabel: UILabel
    private var dateButton: UIButton
    private var nameLabel: UILabel
    private var nameField: UITextField
    private let formatLabel: UILabel
    private let formatButton: UIButton
    private let relLabel: UILabel
    private let relButton: UIButton
    private let myDeckLabel: UILabel
    private let myDeckField: UITextField
    private let theirDeckLabel: UILabel
    private let theirDeckField: UITextField
    
    private let gameCollection: UITableView
    
    // MARK: View Lifecycle
    
    init() {
        dateLabel = UILabel()
        dateButton = UIButton()
        nameLabel = UILabel()
        nameField = UITextField()
        formatLabel = UILabel()
        formatButton = UIButton()
        relLabel = UILabel()
        relButton = UIButton()
        myDeckLabel = UILabel()
        myDeckField = UITextField()
        theirDeckLabel = UILabel()
        theirDeckField = UITextField()
        
        gameCollection = UITableView()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.background
        
        // MARK: Create the match specific info
        
        dateLabel.text = "Date:"
        dateLabel.font = GC.Font.main
        view.addSubview(dateLabel)

            dateLabel.snp.makeConstraints { make in
                make.top.equalTo(view).offset(GC.Margin.top)
                make.leading.equalTo(view).offset(GC.Margin.left)
            }
        
        dateButton.titleLabel?.font = GC.Font.main
        view.addSubview(dateButton)
        
            dateButton.snp.makeConstraints { make in
                make.top.bottom.equalTo(dateLabel)
                make.left.equalTo(dateLabel.snp.right).offset(GC.Padding.horizontal)
                make.width.equalTo(view).multipliedBy(0.85)
                make.right.equalTo(view).offset(GC.Margin.right)
            }
        
        nameLabel.text = "Event Name:"
        nameLabel.font = GC.Font.main
        view.addSubview(nameLabel)
        
            nameLabel.snp.makeConstraints { make in
                make.top.equalTo(dateLabel.snp.bottom).offset(GC.Padding.vertical)
                make.leading.equalTo(dateLabel)
            }

        nameField.placeholder = "Event Name"
        nameField.font = GC.Font.main
        view.addSubview(nameField)
        
            nameField.snp.makeConstraints { make in
                make.top.bottom.equalTo(nameLabel)
                make.leading.equalTo(nameLabel.snp.trailing).offset(GC.Padding.horizontal)
            }
        
        formatLabel.text = "Format:"
        formatLabel.font = GC.Font.main
        view.addSubview(formatLabel)
        
        formatButton.titleLabel?.font = GC.Font.main
        view.addSubview(formatButton)
        
        relLabel.text = "REL"
        relLabel.font = GC.Font.main
        view.addSubview(relLabel)
        
        relButton.titleLabel?.font = GC.Font.main
        view.addSubview(relButton)
        
            formatLabel.snp.makeConstraints { make in
                make.left.equalTo(dateLabel)
                make.top.equalTo(nameLabel.snp.bottom).offset(GC.Padding.vertical)
            }
            
            relLabel.snp.makeConstraints { make in
                make.left.equalTo(view.snp.centerX)
                make.top.bottom.equalTo(formatLabel)
            }
            
            formatButton.snp.makeConstraints { make in
                make.top.bottom.equalTo(formatLabel)
                make.left.equalTo(formatLabel.snp.right).offset(GC.Padding.horizontal)
                make.right.equalTo(relLabel.snp.left).offset(-GC.Padding.horizontal)
            }
            
            relButton.snp.makeConstraints { make in
                make.top.bottom.equalTo(formatLabel)
                make.left.equalTo(relLabel.snp.right).offset(GC.Padding.horizontal)
                make.right.equalTo(view).offset(GC.Margin.right)
            }
        
        myDeckLabel.text = "My Deck:"
        myDeckLabel.font = GC.Font.main
        view.addSubview(myDeckLabel)
        
        myDeckField.placeholder = "My Deck"
        myDeckField.font = GC.Font.main
        view.addSubview(myDeckField)
        
        theirDeckLabel.text = "Their Deck:"
        theirDeckLabel.font = GC.Font.main
        view.addSubview(theirDeckLabel)
        
        theirDeckField.placeholder = "Their Deck"
        theirDeckField.font = GC.Font.main
        view.addSubview(theirDeckField)
        
            myDeckLabel.snp.makeConstraints { make in
                make.left.equalTo(dateLabel)
                make.top.equalTo(formatLabel.snp.bottom).offset(GC.Padding.vertical)
            }
            
            theirDeckLabel.snp.makeConstraints { make in
                make.left.equalTo(view.snp.centerX)
                make.top.bottom.equalTo(myDeckLabel)
            }
            
            myDeckField.snp.makeConstraints { make in
                make.top.bottom.equalTo(myDeckLabel)
                make.left.equalTo(myDeckLabel.snp.right).offset(GC.Padding.horizontal)
                make.right.equalTo(theirDeckLabel.snp.left).offset(-GC.Padding.horizontal)
            }
            
            theirDeckField.snp.makeConstraints { make in
                make.top.bottom.equalTo(myDeckLabel)
                make.left.equalTo(theirDeckLabel.snp.right).offset(GC.Padding.horizontal)
                make.right.equalTo(view).offset(GC.Margin.right)
            }
        
        // MARK: Make the game collection view
        
        gameCollection.dataSource = self
        gameCollection.backgroundColor = UIColor.clear
        gameCollection.rowHeight = 112
        gameCollection.register(UINib(nibName: "GameCell", bundle: nil), forCellReuseIdentifier: "GameCell")
        view.addSubview(gameCollection)
        
        gameCollection.snp.makeConstraints { make in
            make.top.equalTo(myDeckLabel.snp.bottom).offset(GC.Padding.vertical*2)
            make.bottom.equalTo(view).offset(-GC.Margin.bottom)
            make.left.right.equalTo(view)
        }
    }
}

extension NewMatchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GameCell
        cell.backgroundColor = Color.Cell.background
        cell.myHandPicker.dataSource = self
        cell.myHandPicker.delegate = self
        cell.theirHandPicker.dataSource = self
        cell.theirHandPicker.delegate = self
        return cell

    }
}

extension NewMatchViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 8
    }
        
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView{
        
        var label = view as! UILabel!
        if label == nil {
            label = UILabel()
        }
        
        label?.font = UIFont.systemFont(ofSize: 24)
        label?.text = "\(7-row)"
        label?.textAlignment = .right
        return label!
        
    }
}
