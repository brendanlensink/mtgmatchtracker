//
//  GameCell.swift
//  matchtracker
//
//  Created by Brendan Lensink on 2017-04-13.
//  Copyright © 2017 blensink. All rights reserved.
//

import UIKit
import ReactiveSwift
import enum Result.NoError

class GameCell: UITableViewCell {
    
    // MARK: UI Elements
    
    @IBOutlet private var startButton: UIButton!
    @IBOutlet private var startLabel: UILabel!
    @IBOutlet private var resultButton: UIButton!
    @IBOutlet private var resultLabel: UILabel!
    @IBOutlet fileprivate var myHandPicker: UIPickerView!
    @IBOutlet private var myHandLabel: UILabel!
    @IBOutlet fileprivate var theirHandPicker: UIPickerView!
    @IBOutlet private var theirHandLabel: UILabel!
    @IBOutlet private var notesField: UITextView!
    
    // MARK: Properties
    
    var game: Game?
    
    // MARK: Reactive Elements
    
    var (gameReadySignal, gameReadyObserver) = Signal<Game?, NoError>.pipe()
    
    private let (startStream, startObserver) = Signal<Start, NoError>.pipe()
    private let (resultStream, resultObserver) = Signal<Result, NoError>.pipe()
    fileprivate let (myHandStream, myHandObserver) = Signal<Hand, NoError>.pipe()
    fileprivate let (theirHandStream, theirHandObserver) = Signal<Hand, NoError>.pipe()
    fileprivate let (noteStream, noteObserver) = Signal<String, NoError>.pipe()
    
    // MARK: View Lifecycle
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        bindGameCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        bindGameCell()
    }
    
    func bindGameCell() {
        gameReadySignal = Signal.combineLatest(
            startStream,
            resultStream,
            myHandStream,
            theirHandStream,
            noteStream
            ).map { inputs in
                let game = Game(value: [
                    "start": inputs.0.rawValue,
                    "result": inputs.1.rawValue,
                    "myHand": inputs.2.rawValue,
                    "theirHand": inputs.3.rawValue,
                    "notes": inputs.4
                    ])
                return game
        }
    }
    
    func bindReactive() {

        startStream.observeValues { value in
            self.startLabel.text = self.startButton.titleLabel?.text
            self.startButton.setTitle(value.title, for: .normal)
        }
        
        resultStream.observeValues { value in
            self.resultLabel.text = self.resultButton.titleLabel?.text
            self.resultButton.setTitle(value.title, for: .normal)
        }
        
        if let game = self.game {
            if let startRawValue = game.start.value {
                startObserver.send(value: Start(rawValue: startRawValue)!)
            }
            if let resultRawValue = game.result.value {
                resultObserver.send(value: Result(rawValue: resultRawValue)!)
            }
            if let myHand = game.myHand.value {
                myHandPicker.selectRow(Int(7-myHand), inComponent: 0, animated: true)
                myHandObserver.send(value: Hand(rawValue: myHand)!)
            }
            if let theirHand = game.theirHand.value {
                theirHandPicker.selectRow(Int(7-theirHand), inComponent: 0, animated: true)
                theirHandObserver.send(value: Hand(rawValue: theirHand)!)
            }

            if let notes = game.notes {
                notesField.text = notes
                noteObserver.send(value: notes)
            }
        } else {
            startObserver.send(value: Start.play)
            resultObserver.send(value: Result.win)
            myHandObserver.send(value: Hand.seven)
            theirHandObserver.send(value: Hand.seven)
            noteObserver.send(value: "")
        }
    }
    
    @IBAction func resultButtonTouched(_ sender: UIButton) {
        if sender.titleLabel!.text == "Win" {
            resultObserver.send(value: Result.loss)
        }else {
            resultObserver.send(value: Result.win)
        }
    }
    
    @IBAction func startButtonTouched(_ sender: UIButton) {
        if sender.titleLabel!.text == "Play" {
            startObserver.send(value: Start.draw)
        }else {
            startObserver.send(value: Start.play)
        }
    }
    
    override func layoutSubviews() {
        self.contentView.backgroundColor = Color.Cell.background
        
        startButton.setTitleColor(Color.Text.main, for: .normal)
        startLabel.textColor = Color.Text.secondary
        
        resultButton.setTitleColor(Color.Text.main, for: .normal)
        resultLabel.textColor = Color.Text.secondary
        
        myHandLabel.textColor = Color.Text.secondary
        theirHandLabel.textColor = Color.Text.secondary
        
        notesField.backgroundColor = Color.TextView.background
        notesField.textColor = Color.Text.main
        notesField.tintColor = Color.Text.main
        notesField.autocorrectionType = .no
        notesField.layer.borderColor = Color.TextView.border
        notesField.layer.cornerRadius = 4
        notesField.layer.borderWidth = 1
        
        // Reactive Bindings
        
        myHandPicker.dataSource = self
        myHandPicker.delegate = self
        theirHandPicker.dataSource = self
        theirHandPicker.delegate = self
        
        notesField.reactive.continuousTextValues.observeValues { text in
            if let text = text {
                self.noteObserver.send(value: text)
            }
        }
        
        bindReactive()
    }
}

// MARK: UIPicker Delegate and DataSource

extension GameCell: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let value = Hand(rawValue: Int8(7-row)) else { return }
        switch pickerView {
        case myHandPicker:
            myHandObserver.send(value: value)
        case theirHandPicker:
            theirHandObserver.send(value: value)
        default:
            break
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 8
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = view as! UILabel!
        if label == nil {
            label = UILabel()
        }
        
        label?.font = UIFont.systemFont(ofSize: 24)
        label?.textColor = Color.Picker.text
        label?.text = "\(7-row)"
        label?.textAlignment = .right
        label?.textColor = Color.Picker.altText
        
        return label!
    }
}

