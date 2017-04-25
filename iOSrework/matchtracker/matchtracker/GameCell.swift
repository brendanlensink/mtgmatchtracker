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
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    
        bindReactive()
    }
    
    func bindReactive() {
        gameReadySignal = Signal.combineLatest(
            startStream,
            resultStream,
            myHandStream,
            theirHandStream,
            noteStream
        ).map { inputs in
            let game = Game()
            game.start = inputs.0
            game.result = inputs.1
            game.myHand = inputs.2
            game.theirHand = inputs.3
            game.notes = inputs.4
            return game
        }
        
        // TODO: There's got to be a better way to do this part. Ideally all the streams just start non-empty
        startObserver.send(value: Start.play)
        resultObserver.send(value: Result.win)
        myHandObserver.send(value: Hand.seven)
        theirHandObserver.send(value: Hand.seven)
        noteObserver.send(value: "")
    }
    
    @IBAction func resultButtonTouched(_ sender: UIButton) {
        if sender.titleLabel!.text == "Win" {
            resultObserver.send(value: Result.loss)
            sender.setTitle("Loss", for: .normal)
            resultLabel.text = "Win"
        }else {
            resultObserver.send(value: Result.win)
            sender.setTitle("Win", for: .normal)
            resultLabel.text = "Loss"
        }
    }
    
    @IBAction func startButtonTouched(_ sender: UIButton) {
        if sender.titleLabel!.text == "Play" {
            startObserver.send(value: Start.draw)
            sender.setTitle("Draw", for: .normal)
            startLabel.text = "Play"
        }else {
            startObserver.send(value: Start.play)
            sender.setTitle("Play", for: .normal)
            startLabel.text = "Draw"
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

