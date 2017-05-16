//
//  GameCell.swift
//  MatchTracker
//
//  Created by Brendan Lensink on 2017-05-06.
//  Copyright © 2017 Brendan Lensink. All rights reserved.
//

import Eureka

final class GameCell: Cell<Game>, CellType, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate {
    
    // MARK: Properties
    
    var game = Game()
    
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
    
    required init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setup() {
        super.setup()
        
        myHandPicker.delegate = self
        myHandPicker.dataSource = self
        theirHandPicker.delegate = self
        theirHandPicker.dataSource = self
        notesField.delegate = self
        height = {112}
    }
    
    override func update() {
        if !self.isHidden {
            self.row.value = game
        }
        
        setResult(result: Result(rawValue: game.result!)!)
        setStart(start: Start(rawValue: game.start!)!)
    }
    
    // MARK: Actions
    
    @IBAction func resultButtonTouched(_ sender: UIButton) {
        if sender.titleLabel!.text == "Win" {
            setResult(result: .loss)
        }else {
            setResult(result: .win)
        }
    }
    
    @IBAction func startButtonTouched(_ sender: UIButton) {
        if sender.titleLabel!.text == "Play" {
            setStart(start: .draw)
        }else {
            setStart(start: .play)
        }
    }
    
    // MARK: Helper Functions
    
    private func setResult(result: Result) {
        switch result {
        case .loss:
            self.resultLabel.text = self.resultButton.titleLabel?.text
            self.resultButton.setTitle("Loss", for: .normal)
            game.result = Result.loss.rawValue
        case .win:
            self.resultLabel.text = self.resultButton.titleLabel?.text
            self.resultButton.setTitle("Win", for: .normal)
            game.result = Result.win.rawValue
        case .draw:
            return
        }
    }
    
    private func setStart(start: Start) {
        switch start {
        case .play:
            self.startLabel.text = self.startButton.titleLabel?.text
            self.startButton.setTitle("Play", for: .normal)
//            game.start = Start.play.rawValue
        case .draw:
            self.startLabel.text = self.startButton.titleLabel?.text
            self.startButton.setTitle("Draw", for: .normal)
//            game.start = Start.draw.rawValue
        }
    }
    
    // MARK: UIPickerView DataSource and Delegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 8
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(7-row)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let updatedValue = Hand(rawValue: Int8(7-row))
        switch pickerView {
        case myHandPicker: game.myHand.value = updatedValue?.rawValue
        case theirHandPicker: game.theirHand.value = updatedValue?.rawValue
        default: return
        }
    }
    
    // MARK: UITextView Delegate
    
    func textViewDidChange(_ textView: UITextView) {
        game.notes = textView.text
    }
}

// MARK: Eureka Row Class

final class GameRow: Row<GameCell>, RowType {
    required init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<GameCell>(nibName: "GameCell")
    }
}
