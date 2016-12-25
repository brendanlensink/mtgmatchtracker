//
//  GameView.swift
//  MTGMatchTracker
//
//  Created by Brendan Lensink on 2016-11-18.
//  Copyright © 2016 blensink. All rights reserved.
//

import UIKit
import SnapKit
import ReactiveSwift
import enum Result.NoError

class GameView: UIView {
  
  // MARK: - Inputs
  
  var game: Int
  let startStream: MutableProperty<Start?>
  let resultStream: MutableProperty<GameResult?>
  let myHandStream: MutableProperty<Hand>
  let theirHandStream: MutableProperty<Hand>
  let notesStream: MutableProperty<String?>
  
  // MARK: - Outputs

//  let game: Games
  let doneStream: Signal<Bool, NoError>
  
  // MARK: - UI Elements
  
  let playDraw: UISwitch
  let playText: UILabel
  let result: UISwitch
  let resultText: UILabel
  let myHand: UIButton
  let theirHand: UIButton
  let notes: UITextView
  
  // MARK: - Input

  override init (frame : CGRect) {
    
    // MARK: Set up reactive elements 
    
    game = 0
    startStream = MutableProperty(nil)
    resultStream = MutableProperty(nil)
    myHandStream = MutableProperty(Hand.seven)
    theirHandStream = MutableProperty(Hand.seven)
    notesStream = MutableProperty(nil)
    
    doneStream = Signal.combineLatest(
      startStream.signal,
      resultStream.signal
    ).map { inputs in
      return true
    }
    
    // MARK: Set up UI Elements
    
    playDraw = UISwitch()
    playText = UILabel()
    result = UISwitch()
    resultText = UILabel()
    myHand = UIButton()
    theirHand = UIButton()
    notes = UITextView()
    
    super.init(frame : frame)
  }
  
  convenience init() {
    self.init(frame:CGRect.zero)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  /**
   *  Set up the game
   *
   *  - Parameters:
   *    - vc: A reference to the view controller containing this game view
   *    - game: The game number within the match
   */
  func initGame(vc: LogMatchViewController, game: Int) {
    // MARK: Make the play/draw switch
    
    self.game = game
    
    playDraw.isOn = true
    playDraw.addTarget(self, action: #selector(playDrawChanged(_:)), for: .valueChanged)
    self.addSubview(playDraw)
    
      // Snapkit
      playDraw.snp.makeConstraints { make in
        make.centerY.equalTo(self).multipliedBy(0.6)
        make.left.equalTo(self).offset(GC.Padding.horizontal)
      }
    
    playText.text = Text.GameCell.play
    playText.font = GC.Font.main
    self.addSubview(playText)
    
      // Snapkit
      playText.snp.makeConstraints { make in
        make.centerY.equalTo(playDraw)
        make.left.equalTo(playDraw.snp.right).offset(GC.Padding.horizontal)
        make.width.equalTo(40)
      }
    
    // MARK: Make the win/loss switch
    
    result.isOn = true
    result.addTarget(self, action: #selector(resultChanged(_:)), for: .valueChanged)
    self.addSubview(result)
    
      // Snapkit
      result.snp.makeConstraints { make in
        make.centerY.equalTo(self).multipliedBy(1.4)
        make.left.equalTo(playDraw)
      }
    
    resultText.text = Text.GameCell.win
    resultText.font = GC.Font.main
    self.addSubview(resultText)
    
      // Snapkit
      resultText.snp.makeConstraints { make in
        make.centerY.equalTo(result)
        make.left.equalTo(result.snp.right).offset(GC.Padding.horizontal)
        make.width.equalTo(40)
      }
    
    // MARK: Make the my hand button
    
    myHand.setTitle(Text.GameCell.myHand + "7", for: .normal)
    myHand.setTitleColor(Color.TextField.text, for: .normal)
    myHand.titleLabel?.font = GC.Font.main
    self.addSubview(myHand)
    
      // Snapkit
      myHand.snp.makeConstraints { make in
        make.centerY.equalTo(playDraw)
        make.left.equalTo(playText.snp.right).offset(GC.Padding.horizontal)
      }
    
    // MARK: Make the their hand button
    
    theirHand.setTitle(Text.GameCell.theirHand + "7", for: .normal)
    theirHand.setTitleColor(Color.TextField.text, for: .normal)
    theirHand.titleLabel?.font = GC.Font.main
    self.addSubview(theirHand)
    
      // Snapkit
      theirHand.snp.makeConstraints { make in
        make.centerY.equalTo(result)
        make.left.equalTo(resultText.snp.right).offset(GC.Padding.horizontal)
      }
    
    // MARK: Make the notes view
    
    notes.layer.borderColor = Color.GameCell.border.cgColor
    notes.layer.borderWidth = 1
    notes.layer.cornerRadius = 4
    notes.delegate = self
    self.addSubview(notes)
    
      // Snapkit
      notes.snp.makeConstraints { make in
        make.top.equalTo(self).offset(GC.Padding.vertical)
        make.bottom.equalTo(self).offset(-GC.Padding.vertical)
        make.left.equalTo(theirHand.snp.right).offset(GC.Padding.horizontal)
        make.right.equalTo(self).offset(-GC.Padding.horizontal)
      }
    
    // MARK: - Reactive Elements
    
    // MARK: Alert View Show/Hide Listeners
    
    myHand.reactive.controlEvents(.touchUpInside).observeValues { _ in
      vc.present( Picker.sharedInstance.makeHandAlert(hand: self.myHandStream, isTheirs: false,
        model: vc.viewModel), animated: false, completion: {} )
    }
    
    theirHand.reactive.controlEvents(.touchUpInside).observeValues { _ in
      vc.present( Picker.sharedInstance.makeHandAlert(hand: self.theirHandStream, isTheirs: true,
        model: vc.viewModel), animated: false, completion: {} )
    }
    
    // MARK: Game View Button Listeners
    
    startStream.signal.observeValues { value in
      let startText = (value!.rawValue == 0 ? Text.GameCell.play : Text.GameCell.draw)
      self.playText.text = startText
    }
    
    resultStream.signal.observeValues { value in
      let resultText = (value!.rawValue == 0 ? Text.GameCell.win : Text.GameCell.loss)
      self.resultText.text = resultText
    }
    
    myHandStream.signal.observeValues { value in
      self.myHand.setTitle(Text.GameCell.myHand + String(describing: value.rawValue), for: .normal)
    }
    
    theirHandStream.signal.observeValues { value in
      self.theirHand.setTitle(
        Text.GameCell.theirHand + String(describing: value.rawValue), for: .normal)
    }
  }
  
  // MARK: Switch Delegate Methods
  
  func playDrawChanged(_ playSwitch: UISwitch) {
    if playSwitch.isOn {
      self.startStream.swap(Start.play)
    }else {
      self.startStream.swap(Start.draw)
    }
  }
  
  func resultChanged(_ playSwitch: UISwitch) {
    if result.isOn {
      self.resultStream.swap(GameResult.w)
    }else {
      self.resultStream.swap(GameResult.l)
    }
  }
  
  /**
   *  Return a game object from the information in the game view
   */
  func getGame() -> Game {
    let newGame = Game()
    newGame.game = self.game
    newGame.start = (startStream.value?.rawValue)!
    newGame.result = (resultStream.value?.rawValue)!
    newGame.myHand = myHandStream.value.rawValue
    newGame.theirHand = theirHandStream.value.rawValue
    newGame.notes = ( notesStream.value == nil ? "" : notesStream.value! )
    
    return newGame
  }
}

// MARK: UI Text View Delegate Methods

extension GameView: UITextViewDelegate {
  /**
   *  Called by the text view as the user enters text
   */
  func textViewDidChange(_ textView: UITextView) {
    notesStream.swap(textView.text)
  }
}
