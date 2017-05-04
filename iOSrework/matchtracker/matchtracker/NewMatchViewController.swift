//
//  NewMatchViewController.swift
//  matchtracker
//
//  Created by Brendan Lensink on 2017-04-12.
//  Copyright © 2017 blensink. All rights reserved.
//

import UIKit
import SnapKit
import ReactiveCocoa
import ReactiveSwift
import SwiftyUserDefaults

class NewMatchViewController: UIViewController {
    
    // MARK: UI Elements
    
    fileprivate let dateLabel: UILabel
    fileprivate let dateField: UITextField
    fileprivate let nameLabel: UILabel
    fileprivate let nameField: UITextField
    fileprivate let formatLabel: UILabel
    fileprivate let formatField: UITextField
    fileprivate let relLabel: UILabel
    fileprivate let relField: UITextField
    fileprivate let myDeckLabel: UILabel
    fileprivate let myDeckField: UITextField
    fileprivate let theirDeckLabel: UILabel
    fileprivate let theirDeckField: UITextField
    fileprivate let addButton: UIButton
    
    fileprivate let gameCollection: UITableView
    fileprivate let datePicker: UIDatePicker
    fileprivate let formatPicker: UIPickerView
    fileprivate let relPicker: UIPickerView
    
    fileprivate var saveButton: UIBarButtonItem
    
    // MARK: Properties
    
    fileprivate let viewModel: NewMatchViewModel
    fileprivate let match: Match?
    
    // MARK: View Lifecycle
    init(match: Match?) {
        viewModel = NewMatchViewModel()
        self.match = match
        
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
        addButton = UIButton()
        
        gameCollection = UITableView()
        datePicker = UIDatePicker()
        formatPicker = UIPickerView()
        relPicker = UIPickerView()
        
        saveButton = UIBarButtonItem()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Color.background
        
        if match == nil {
            self.navigationItem.hidesBackButton = true
            self.navigationController?.navigationBar.barTintColor = Color.NavBar.background

            saveButton = UIBarButtonItem(title: "SAVE", style: .done, target: self, action: #selector(NewMatchViewController.saveMatch))
        }

        // MARK: Set up the date picker view
        
        datePicker.sizeToFit()
        datePicker.backgroundColor = Color.Picker.background
        datePicker.tintColor = Color.Picker.text
        datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        dateField.inputView = datePicker
        
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.backgroundColor = Color.Picker.background
        toolbar.tintColor = Color.Picker.text
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
                make.top.equalTo(view).offset(GC.Margin.top+50)
                make.leading.equalTo(view).offset(GC.Margin.left)
            }
        
        dateField.textColor = Color.Text.main
        dateField.font = GC.Font.main
        dateField.tintColor = Color.Text.tint
        dateField.contentHorizontalAlignment = .left
        view.addSubview(dateField)
        
            dateField.snp.makeConstraints { make in
                make.top.bottom.equalTo(dateLabel)
                make.left.equalTo(dateLabel.snp.right).offset(GC.Padding.horizontal)
                make.width.equalTo(view).multipliedBy(0.76)
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

        nameField.attributedPlaceholder = NSAttributedString(string: "Event Name", attributes: [NSForegroundColorAttributeName: Color.Text.placeholder])
        nameField.textColor = Color.Text.main
        nameField.font = GC.Font.main
        nameField.tintColor = Color.Text.tint
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
        formatField.textColor = Color.Text.placeholder
        formatField.font = GC.Font.main
        formatField.tintColor = Color.Text.tint
        view.addSubview(formatField)
        
        relLabel.text = "REL:"
        relLabel.textColor = Color.Text.secondary
        relLabel.font = GC.Font.main
        view.addSubview(relLabel)
        
        relField.text = "REL"
        relField.textColor = Color.Text.placeholder
        relField.font = GC.Font.main
        relField.tintColor = Color.Text.tint
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
        
        myDeckField.attributedPlaceholder = NSAttributedString(string: "My Deck", attributes: [NSForegroundColorAttributeName: Color.Text.placeholder])
        myDeckField.textColor = Color.Text.main
        myDeckField.font = GC.Font.main
        myDeckField.tintColor = Color.Text.tint
        view.addSubview(myDeckField)
        
        theirDeckLabel.text = "Their Deck:"
        theirDeckLabel.textColor = Color.Text.secondary
        theirDeckLabel.font = GC.Font.main
        view.addSubview(theirDeckLabel)
        
        theirDeckField.attributedPlaceholder = NSAttributedString(string: "Their Deck", attributes: [NSForegroundColorAttributeName: Color.Text.placeholder])
        theirDeckField.textColor = Color.Text.main
        theirDeckField.font = GC.Font.main
        theirDeckField.tintColor = Color.Text.tint
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
        
        gameCollection.dataSource = self
        gameCollection.delegate = self
        gameCollection.isScrollEnabled = false
        gameCollection.separatorStyle = .none
        gameCollection.backgroundColor = UIColor.clear
        gameCollection.rowHeight = 112
        gameCollection.register(UINib(nibName: "GameCell", bundle: nil), forCellReuseIdentifier: "GameCell")
        view.addSubview(gameCollection)
        
            gameCollection.snp.makeConstraints { make in
                make.top.equalTo(myDeckLabel.snp.bottom).offset(GC.Padding.vertical)
                make.bottom.equalTo(view)
                make.left.right.equalTo(view)
            }
        
        // MARK: Make the add button
        
        addButton.setTitle("+", for: .normal)
        addButton.setTitleColor(Color.Text.main, for: .normal)
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        addButton.addTarget(self, action: #selector(NewMatchViewController.addButtonPressed), for: .touchUpInside)
        view.addSubview(addButton)
        
            addButton.snp.makeConstraints { make in
                make.centerX.equalTo(view)
                make.top.equalTo(gameCollection.snp.top).offset(270)
            }
        
        // MARK: Make all the text field underlines
        
        let dateLine = UIView()
        dateLine.backgroundColor = Color.TextField.underline
        view.addSubview(dateLine)
        
            dateLine.snp.makeConstraints { make in
                make.height.equalTo(1)
                make.top.equalTo(dateField.snp.bottom).offset(GC.Padding.underline)
                make.left.right.equalTo(dateField)
            }
        
        let eventLine = UIView()
        eventLine.backgroundColor = Color.TextField.underline
        view.addSubview(eventLine)
        
            eventLine.snp.makeConstraints { make in
                make.height.equalTo(1)
                make.top.equalTo(nameField.snp.bottom).offset(GC.Padding.underline)
                make.left.right.equalTo(nameField)
            }
        
        let formatLine = UIView()
        formatLine.backgroundColor = Color.TextField.underline
        view.addSubview(formatLine)
        
        formatLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(formatField.snp.bottom).offset(GC.Padding.underline)
            make.left.right.equalTo(formatField)
        }
        
        let relLine = UIView()
        relLine.backgroundColor = Color.TextField.underline
        view.addSubview(relLine)
        
        relLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(relField.snp.bottom).offset(GC.Padding.underline)
            make.left.right.equalTo(relField)
        }
        
        let myDeckLine = UIView()
        myDeckLine.backgroundColor = Color.TextField.underline
        view.addSubview(myDeckLine)
        
        myDeckLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(myDeckField.snp.bottom).offset(GC.Padding.underline)
            make.left.right.equalTo(myDeckField)
        }
        
        let theirDeckLine = UIView()
        theirDeckLine.backgroundColor = Color.TextField.underline
        view.addSubview(theirDeckLine)
        
        theirDeckLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(theirDeckField.snp.bottom).offset(GC.Padding.underline)
            make.left.right.equalTo(theirDeckField)
        }
        
        bindViewModel()
    }
    
    // MARK: Events
    
    @objc private func addButtonPressed() {
        if viewModel.match.games.count == 2 {
            addButton.isHidden = true
            viewModel.match.games.append(nil)
            gameCollection.reloadData()
        }
    }
    
    // MARK: Reactive Binding
    
    private func bindViewModel() {
        viewModel.readySignal.observeValues { ready in
            var gameStatus = false
            let games = self.viewModel.match.games
            if let game1 = games[0], let game2 = games[1] {
                if game1.result.value == game2.result.value {
                    gameStatus = true
                } else if games.count > 2 {
                    gameStatus = games[2] != nil
                }
            }
            if gameStatus { self.navigationItem.rightBarButtonItem = self.saveButton }
        }
        
        nameField.reactive.continuousTextValues.observeValues { value in self.viewModel.eventObserver.send(value: value) }
        myDeckField.reactive.continuousTextValues.observeValues { value in
            self.viewModel.myDeckObserver.send(value: value)
        }
        theirDeckField.reactive.continuousTextValues.observeValues { value in
            self.viewModel.theirDeckObserver.send(value: value)
        }
                
        // MARK: Set defaults from previous match or fill in provided match details
        
        if match == nil {
            dateField.text = DateManager.shared.toString(date: Date())
            viewModel.dateObserver.send(value: Date())
            if let name = Defaults[.eventName] {
                nameField.text = name
                viewModel.eventObserver.send(value: name)
            }
            if let format = Defaults[.format] {
                formatField.text = format.title
                formatField.textColor = Color.Text.main
                viewModel.formatObserver.send(value: format)
            }
            if let rel = Defaults[.REL] {
                relField.text = rel.title
                relField.textColor = Color.Text.main
                viewModel.relObserver.send(value: rel)
            }
            if let myDeck = Defaults[.myDeck] {
                myDeckField.text = myDeck
                viewModel.myDeckObserver.send(value: myDeck)
            }
            
            /***************************
             
             We're going to fake a whole bunch of data to test exporting.
             
             ****************************/
            let testGame = Game()
            testGame.gameNumber.value = 0
            testGame.result.value = Result.loss.rawValue
            testGame.start.value = Start.draw.rawValue
            testGame.myHand.value = Hand.seven.rawValue
            testGame.theirHand.value = Hand.seven.rawValue
            viewModel.gamesObserver.send(value: (0, testGame))
            viewModel.gamesObserver.send(value: (1, testGame))
            
            viewModel.eventObserver.send(value: "Test Event")
            viewModel.formatObserver.send(value: Format.legacy)
            viewModel.relObserver.send(value: REL.professional)
            viewModel.myDeckObserver.send(value: "Test Deck")
            viewModel.theirDeckObserver.send(value: "Test Deck")
            /**
             End of fake testing data
             */

        }else {
            guard let match = self.match else { return }
            
            dateField.text = DateManager.shared.toString(date: Date())
            viewModel.dateObserver.send(value: match.created)
            if let name = match.name {
                nameField.text = name
                viewModel.eventObserver.send(value: name)
            }
            if let format = match.format {
                formatField.text = format.title
                formatField.textColor = Color.Text.main
                viewModel.formatObserver.send(value: format)
            }
            if let rel = match.rel {
                relField.text = rel.title
                relField.textColor = Color.Text.main
                viewModel.relObserver.send(value: rel)
            }
            if let myDeck = match.myDeck {
                myDeckField.text = myDeck
                viewModel.myDeckObserver.send(value: myDeck)
            }
            if let theirDeck = match.theirDeck {
                theirDeckField.text = theirDeck
                viewModel.theirDeckObserver.send(value: theirDeck)
            }
        }
    }
    
    // MARK: Actions
    
    @objc private func saveMatch() {
        self.viewModel.saveMatch()
        navigationController?.pushViewController(NewMatchViewController(match: nil), animated: true)
    }
    
    // MARK: Date Picker Functions
    
    @objc private func dismissPicker() {
        // TODO: Pretty sure I can pass a reference to the caller in and not just blindly call resign on all 3 fields
        dateField.resignFirstResponder()
        formatField.resignFirstResponder()
        relField.resignFirstResponder()
    }
    
    @objc private func handleDatePicker(sender: UIDatePicker) {
        let newText = DateManager.shared.toString(date: sender.date)
        dateField.text = newText
        viewModel.dateObserver.send(value: sender.date)
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
       return viewModel.match.games.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GameCell
        
        if let game = match?.rGames[indexPath.section] {
            print("Sending: \(indexPath.row),\(game)")
            cell.game = game
        }
        cell.gameReadySignal.observeValues { game in
            if let game = game {
                game.gameNumber.value = Int8(indexPath.section)
                self.viewModel.gamesObserver.send(value: (indexPath.section, game))
            }
        }
        return cell

    }
}

extension NewMatchViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let intRow = Int8(row)
        switch pickerView {
        case formatPicker: formatField.text = Format.allValues[row]
            formatField.textColor = Color.Text.main
            viewModel.formatObserver.send(value: Format(rawValue: intRow))
        case relPicker: relField.text = REL.allValues[row]
            relField.textColor = Color.Text.main
            viewModel.relObserver.send(value: REL(rawValue: intRow))
        default: return
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case formatPicker: return Format.allValues.count
        case relPicker: return REL.allValues.count
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
        label?.textColor = Color.Picker.text
        label?.textAlignment = .center
        
        switch pickerView {
        case formatPicker: label?.text = Format.allValues[row]
        case relPicker: label?.text = REL.allValues[row]
        default: break
        }
        
        return label!
    }
}
