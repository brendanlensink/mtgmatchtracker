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
    
    private let dateLabel: UILabel
    fileprivate let dateField: UITextField
    private let nameLabel: UILabel
    private let nameField: UITextField
    private let formatLabel: UILabel
    fileprivate let formatField: UITextField
    private let relLabel: UILabel
    fileprivate let relField: UITextField
    private let myDeckLabel: UILabel
    private let myDeckField: UITextField
    private let theirDeckLabel: UILabel
    private let theirDeckField: UITextField
    
    private let gameCollection: UITableView
    fileprivate let datePicker: UIDatePicker
    fileprivate let formatPicker: UIPickerView
    fileprivate let relPicker: UIPickerView
    
    private let saveButton: UIButton
    
    // MARK: Properties
    
    fileprivate let formats = ["Sealed", "Draft", "Standard", "Modern", "Legacy", "Commander"]
    fileprivate let rels = ["Casual", "Competitive", "Professional"]
    
    // MARK: View Lifecycle
    
    init() {
        dateLabel = UILabel()
        dateField = UITextField()
        nameLabel = UILabel()
        nameField = UITextField()
        formatLabel = UILabel()
        formatField = UITextField()
        relLabel = UILabel()
        relField = UITextField()
        myDeckLabel = UILabel()
        myDeckField = UITextField()
        theirDeckLabel = UILabel()
        theirDeckField = UITextField()
        
        gameCollection = UITableView()
        datePicker = UIDatePicker()
        formatPicker = UIPickerView()
        relPicker = UIPickerView()
        
        saveButton = UIButton()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.background
        
        // MARK: Set up the date picker view
        
        datePicker.sizeToFit()
        datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        dateField.inputView = datePicker
        
        let toolbar = UIToolbar()
        toolbar.barStyle = .black
        toolbar.isTranslucent = true
        toolbar.tintColor = nil
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(NewMatchViewController.dismissPicker))
        toolbar.setItems([doneButton], animated: false)
        dateField.inputAccessoryView = toolbar
        
        // MARK: Format the custom pickers
        
        formatPicker.sizeToFit()
        formatPicker.backgroundColor = Color.Picker.background
        formatPicker.delegate = self
        formatPicker.dataSource = self
        formatField.inputView = formatPicker
        formatField.inputAccessoryView = toolbar

        relPicker.sizeToFit()
        relPicker.backgroundColor = Color.Picker.background
        relPicker.delegate = self
        relPicker.dataSource = self
        relField.inputView = relPicker
        relField.inputAccessoryView = toolbar

        
        // MARK: Create the match specific info
        
        dateLabel.text = "Date:"
        dateLabel.textColor = Color.Text.secondary
        dateLabel.font = GC.Font.main
        view.addSubview(dateLabel)

            dateLabel.snp.makeConstraints { make in
                make.top.equalTo(view).offset(GC.Margin.top)
                make.leading.equalTo(view).offset(GC.Margin.left)
            }
        
        dateField.text = DateManager.sharedInstance.toString(date: Date())
        dateField.textColor = Color.Text.main
        dateField.font = GC.Font.main
        dateField.contentHorizontalAlignment = .left
        view.addSubview(dateField)
        
            dateField.snp.makeConstraints { make in
                make.top.bottom.equalTo(dateLabel)
                make.left.equalTo(dateLabel.snp.right).offset(GC.Padding.horizontal)
                make.width.equalTo(view).multipliedBy(0.85)
                make.right.equalTo(view).offset(GC.Margin.right)
            }
        
        nameLabel.text = "Event Name:"
        nameLabel.textColor = Color.Text.secondary
        nameLabel.font = GC.Font.main
        view.addSubview(nameLabel)
        
            nameLabel.snp.makeConstraints { make in
                make.top.equalTo(dateLabel.snp.bottom).offset(GC.Padding.vertical)
                make.leading.equalTo(dateLabel)
            }

        nameField.placeholder = "Event Name"
        nameField.textColor = Color.Text.main
        nameField.font = GC.Font.main
        view.addSubview(nameField)
        
            nameField.snp.makeConstraints { make in
                make.top.bottom.equalTo(nameLabel)
                make.leading.equalTo(nameLabel.snp.trailing).offset(GC.Padding.horizontal)
                make.trailing.equalTo(view).offset(GC.Margin.right)
            }
        
        formatLabel.text = "Format:"
        formatLabel.textColor = Color.Text.secondary
        formatLabel.font = GC.Font.main
        view.addSubview(formatLabel)
        
        formatField.text = "Format"
        formatField.textColor = Color.Text.main
        formatField.font = GC.Font.main
        view.addSubview(formatField)
        
        relLabel.text = "REL"
        relLabel.textColor = Color.Text.secondary
        relLabel.font = GC.Font.main
        view.addSubview(relLabel)
        
        relField.text = "REL"
        relField.textColor = Color.Text.main
        relField.font = GC.Font.main
        view.addSubview(relField)
        
            formatLabel.snp.makeConstraints { make in
                make.left.equalTo(dateLabel)
                make.top.equalTo(nameLabel.snp.bottom).offset(GC.Padding.vertical)
            }
            
            relLabel.snp.makeConstraints { make in
                make.left.equalTo(view.snp.centerX)
                make.top.bottom.equalTo(formatLabel)
            }
            
            formatField.snp.makeConstraints { make in
                make.top.bottom.equalTo(formatLabel)
                make.left.equalTo(formatLabel.snp.right).offset(GC.Padding.horizontal)
                make.right.equalTo(relLabel.snp.left).offset(-GC.Padding.horizontal)
            }
            
            relField.snp.makeConstraints { make in
                make.top.bottom.equalTo(formatLabel)
                make.left.equalTo(relLabel.snp.right).offset(GC.Padding.horizontal)
                make.right.equalTo(view).offset(GC.Margin.right)
            }
        
        myDeckLabel.text = "My Deck:"
        myDeckLabel.textColor = Color.Text.secondary
        myDeckLabel.font = GC.Font.main
        view.addSubview(myDeckLabel)
        
        myDeckField.placeholder = "My Deck"
        myDeckField.textColor = Color.Text.main
        myDeckField.font = GC.Font.main
        view.addSubview(myDeckField)
        
        theirDeckLabel.text = "Their Deck:"
        theirDeckLabel.textColor = Color.Text.secondary
        theirDeckLabel.font = GC.Font.main
        view.addSubview(theirDeckLabel)
        
        theirDeckField.placeholder = "Their Deck"
        theirDeckField.textColor = Color.Text.main
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
        
        // MARK: Make the game collection view and save button
        
        saveButton.setTitle("SAVE", for: .normal)
        saveButton.setTitleColor(Color.Text.main, for: .normal)
        saveButton.backgroundColor = Color.Button.Main.background
        view.addSubview(saveButton)
        
            saveButton.snp.makeConstraints { make in
                make.height.equalTo(60)
                make.bottom.equalTo(view)
                make.left.right.equalTo(view)
            }
        
        gameCollection.dataSource = self
        gameCollection.delegate = self
        gameCollection.isScrollEnabled = false
        gameCollection.separatorStyle = .none
        gameCollection.backgroundColor = UIColor.clear
        gameCollection.rowHeight = 112
        gameCollection.register(UINib(nibName: "GameCell", bundle: nil), forCellReuseIdentifier: "GameCell")
        view.addSubview(gameCollection)
        
            gameCollection.snp.makeConstraints { make in
                make.top.equalTo(myDeckLabel.snp.bottom).offset(GC.Padding.vertical*2)
                make.bottom.equalTo(saveButton.snp.top)
                make.left.right.equalTo(view)
            }
    }
    
    // MARK: Date Picker Functions
    
    func dismissPicker() {
        // TODO: PRetty sure I can pass a reference to the caller in and not just blindly call resign on all 3 fields
        dateField.resignFirstResponder()
        formatField.resignFirstResponder()
        relField.resignFirstResponder()
    }
    
    func handleDatePicker(sender: UIDatePicker) {
        dateField.text = DateManager.sharedInstance.toString(date: sender.date)
    }
}

extension NewMatchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GameCell

        cell.myHandPicker.dataSource = self
        cell.myHandPicker.delegate = self
        cell.theirHandPicker.dataSource = self
        cell.theirHandPicker.delegate = self
        return cell

    }
}

extension NewMatchViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case formatPicker: formatField.text = formats[row]
        case relPicker: relField.text = rels[row]
        default: break
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case datePicker: return 8
        case formatPicker: return formats.count
        case relPicker: return rels.count
        default: return 0
        }
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
        label?.textColor = Color.Text.main
        label?.textAlignment = .center
        
        switch pickerView {
        case datePicker:
            label?.text = "\(7-row)"
            label?.textAlignment = .right
        case formatPicker: label?.text = formats[row]
        case relPicker: label?.text = rels[row]
        default: break
        }
        
        return label!
        
    }
}
