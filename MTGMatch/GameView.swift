//
//  GameView.swift
//  MTGMatchTracker
//
//  Created by Brendan Lensink on 2016-11-18.
//  Copyright © 2016 blensink. All rights reserved.
//

import UIKit
import SnapKit
import DLRadioButton
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
  
  let playRadio: DLRadioButton
  let drawRadio: DLRadioButton
  let playText: UILabel
  let winRadio: DLRadioButton
  let lossRadio: DLRadioButton
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
    
    playRadio = DLRadioButton()
    drawRadio = DLRadioButton()
    playText = UILabel()
    winRadio = DLRadioButton()
    lossRadio = DLRadioButton()
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
    
    // MARK: Let's just set all the switch properties at the top
    let iconHeight: CGFloat = 30
    let iconWidth: CGFloat = 50
    let iconStrokeWidth: CGFloat = 2
    let iconColor = Color.GameCell.Switch.border
    let indicatorColor = Color.GameCell.Switch.selected
    
    // MARK: Make the play/draw radio buttons
    
    self.game = game
    
    playRadio.isIconSquare = true
    playRadio.iconSize = iconWidth
    playRadio.iconStrokeWidth = iconStrokeWidth
    playRadio.iconColor = iconColor
    playRadio.indicatorColor = indicatorColor
    playRadio.otherButtons = [drawRadio]
    self.addSubview(playRadio)
    
      // Snapkit
      playRadio.snp.makeConstraints { make in
        make.height.equalTo(iconHeight)
        make.centerY.equalTo(self).multipliedBy(0.6)
        make.left.equalTo(self).offset(GC.Padding.horizontal)
      }
    
    let playLabel = UILabel()
    playLabel.text = Text.GameCell.play
    playLabel.textColor = Color.GameCell.Switch.text
    self.addSubview(playLabel)
    
      // Snapkit
      playLabel.snp.makeConstraints { make in
          make.centerX.centerY.equalTo(playRadio)
      }
    
    drawRadio.isIconSquare = true
    drawRadio.iconSize = iconWidth
    drawRadio.iconStrokeWidth = iconStrokeWidth
    drawRadio.iconColor = iconColor
    drawRadio.indicatorColor = indicatorColor
    drawRadio.otherButtons = [playRadio]
    self.addSubview(drawRadio)
    
      // Snapkit
      drawRadio.snp.makeConstraints { make in
        make.height.equalTo(iconHeight)
        make.centerY.equalTo(playRadio)
        make.left.equalTo(playRadio.snp.right).offset(-2)
      }
    
    let drawLabel = UILabel()
    drawLabel.text = Text.GameCell.draw
    drawLabel.textColor = Color.GameCell.Switch.text
    self.addSubview(drawLabel)
    
      // Snapkit
      drawLabel.snp.makeConstraints { make in
        make.centerX.centerY.equalTo(drawRadio)
      }

    // MARK: Make the win/loss switch
    
    winRadio.isIconSquare = true
    winRadio.iconSize = iconWidth
    winRadio.iconStrokeWidth = iconStrokeWidth
    winRadio.iconColor = iconColor
    winRadio.indicatorColor = indicatorColor
    winRadio.otherButtons = [lossRadio]
    self.addSubview(winRadio)
    
      // Snapkit
      winRadio.snp.makeConstraints { make in
        make.height.equalTo(iconHeight)
        make.top.equalTo(playRadio.snp.bottom).offset(GC.Padding.vertical)
        make.left.equalTo(playRadio)
      }
    
    let winLabel = UILabel()
    winLabel.text = Text.GameCell.win
    winLabel.textColor = Color.GameCell.Switch.text
    self.addSubview(winLabel)
    
      // Snapkit
      winLabel.snp.makeConstraints { make in
        make.centerX.centerY.equalTo(winRadio)
      }
    
    lossRadio.isIconSquare = true
    lossRadio.iconSize = iconWidth
    lossRadio.iconStrokeWidth = iconStrokeWidth
    lossRadio.iconColor = iconColor
    lossRadio.indicatorColor = indicatorColor
    lossRadio.otherButtons = [winRadio]
    self.addSubview(lossRadio)
    
      // Snapkit
      lossRadio.snp.makeConstraints { make in
        make.height.equalTo(iconHeight)
        make.centerY.equalTo(winRadio)
        make.left.equalTo(winRadio.snp.right).offset(-2)
      }
    
    let lossLabel = UILabel()
    lossLabel.text = Text.GameCell.loss
    lossLabel.textColor = Color.GameCell.Switch.text
    self.addSubview(lossLabel)
    
      // Snapkit
      lossLabel.snp.makeConstraints { make in
        make.centerX.centerY.equalTo(lossRadio)
      }
    
    // MARK: Make the my hand button
    
    myHand.setTitle(Text.GameCell.myHand + "7", for: .normal)
    myHand.setTitleColor(Color.TextField.text, for: .normal)
    myHand.titleLabel?.font = GC.Font.main
    self.addSubview(myHand)
    
      // Snapkit
      myHand.snp.makeConstraints { make in
        make.centerY.equalTo(drawRadio)
        make.left.equalTo(drawRadio.snp.right).offset(GC.Padding.horizontal*2)
      }
    
    // MARK: Make the their hand button
    
    theirHand.setTitle(Text.GameCell.theirHand + "7", for: .normal)
    theirHand.setTitleColor(Color.TextField.text, for: .normal)
    theirHand.titleLabel?.font = GC.Font.main
    self.addSubview(theirHand)
    
      // Snapkit
      theirHand.snp.makeConstraints { make in
        make.centerY.equalTo(lossRadio)
        make.left.equalTo(lossRadio.snp.right).offset(GC.Padding.horizontal*2)
      }
    
    // MARK: Make the notes view
    
    notes.layer.borderColor = Color.GameCell.border.cgColor
    notes.textColor = Color.TextField.text
    notes.backgroundColor = Color.GameCell.textFieldBackground
    notes.layer.borderWidth = 1
    notes.layer.cornerRadius = 4
    notes.delegate = self
    self.addSubview(notes)
    
      // Snapkit
      notes.snp.makeConstraints { make in
        make.top.equalTo(self).offset(GC.Padding.vertical)
        make.bottom.equalTo(self).offset(-GC.Padding.vertical)
        make.left.equalTo(theirHand.snp.right).offset(GC.Padding.horizontal*2)
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
//    if playSwitch.isOn {
//      self.startStream.swap(Start.play)
//    }else {
//      self.startStream.swap(Start.draw)
//    }
  }
  
  func resultChanged(_ playSwitch: UISwitch) {
//    if result.isEnabled {
//      self.resultStream.swap(GameResult.w)
//    }else {
//      self.resultStream.swap(GameResult.l)
//    }
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
