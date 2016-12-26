//
//  LogMatchViewController.swift
//  MTGMatchTracker
//
//  Created by Brendan Lensink on 2016-11-18.
//  Copyright © 2016 blensink. All rights reserved.
//

import UIKit
import SnapKit
import ReactiveCocoa
import ReactiveSwift

class LogMatchViewController: UIViewController {
  
  let viewModel: LogMatchViewModel
  
  // MARK: - UI Elements
  
  private let scrollView: UIScrollView
  
  private let dateButton: UIButton
  private let formatButton: UIButton
  private let relButton: UIButton
  private let myDeck: UITextField
  private let theirDeck: UITextField
  private let myHand: UIButton
  private let theirHand: UIButton
  private let gameViewOne: GameView
  private let gameViewTwo: GameView
  private let gameViewThree: GameView
  private let plusButton: UIButton
  
  fileprivate let defaults = UserDefaultsModel.sharedInstance
  
  // MARK: - Lifecycle
  
  init() {
    viewModel = LogMatchViewModel()
    
    scrollView = UIScrollView()
    
    dateButton = UIButton()
    formatButton = UIButton()
    relButton = UIButton()
    myDeck = UITextField()
    theirDeck = UITextField()
    myHand = UIButton()
    theirHand = UIButton()
    gameViewOne = GameView()
    gameViewTwo = GameView()
    gameViewThree = GameView()
    plusButton = UIButton()
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("NSCoding is not supported")
  }
  
  // MARK: - View Lifecycle
  
  /**
   * Called by the OS when the view loads
   */
  override func viewDidLoad() {
    
    // MARK: Attach a gesture recognizer to listen for taps outside the text field
    
    let tap: UITapGestureRecognizer =
      UITapGestureRecognizer(target: self, action: #selector(LogMatchViewController.dismissKeyboard))
    
    //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
    //tap.cancelsTouchesInView = false
    
    view.addGestureRecognizer(tap)
    
    // MARK: Make the background view and gradient
    
    let backgroundView = UIView()
    backgroundView.backgroundColor = Color.background
    view.addSubview(backgroundView)
    
      // Snapkit
      backgroundView.snp.makeConstraints { make in
        make.edges.equalTo(view)
      }
    
    // MARK: Make the scroll view to put all the elements inside
    
    scrollView.isScrollEnabled = false
    view.addSubview(scrollView)
    
      // Snapkit
      scrollView.snp.makeConstraints { make in
        make.top.equalTo(view).offset(GC.Margin.top + 10)
        make.bottom.equalTo(view).offset(GC.Margin.bottom)
        make.left.equalTo(view).offset(GC.Margin.left)
        make.right.equalTo(view).offset(GC.Margin.right)
      }
    
    // MARK: Make the date button
    
    let dayFormatter: DateFormatter = DateFormatter()
    dayFormatter.dateStyle = .medium
    
    let timeFormatter: DateFormatter = DateFormatter()
    timeFormatter.timeStyle = .short
    
    let day = dayFormatter.string(from: Date())
    let time = timeFormatter.string(from: Date())
    
    viewModel.date.swap(day + " " + time)
    
    dateButton.setTitle(day + " " + time, for: .normal)
    dateButton.setTitleColor(Color.TextField.text, for: .normal)
    dateButton.contentHorizontalAlignment = .left
    dateButton.contentVerticalAlignment = .bottom
    scrollView.addSubview(dateButton)
    Button().makeUnderline(button: dateButton)
    
      // Snapkit
      dateButton.snp.makeConstraints { make in
        make.top.equalTo(scrollView)
        make.height.equalTo(GC.Button.height)
        make.left.equalTo(scrollView)
        make.right.equalTo(scrollView)
        make.width.equalTo(scrollView)
      }
    
    // MARK: Make the format dropdown
    
    formatButton.setTitle(Text.format, for: .normal)
    formatButton.setTitleColor(Color.TextField.text, for: .normal)
    formatButton.contentHorizontalAlignment = .left
    formatButton.contentVerticalAlignment = .bottom
    scrollView.addSubview(formatButton)
    Button().makeUnderline(button: formatButton)
    
      // Snapkit
      formatButton.snp.makeConstraints { make in
        make.top.equalTo(dateButton.snp.bottom).offset(GC.Padding.vertical)
        make.height.equalTo(GC.Button.height)
        make.leading.equalTo(scrollView)
        make.width.equalTo(scrollView).multipliedBy(0.45)
    }
    
    // MARK: Make the REL dropdown
    
    relButton.setTitle(Text.rel, for: .normal)
    relButton.setTitleColor(Color.TextField.text, for: .normal)
    relButton.contentHorizontalAlignment = .left
    relButton.contentVerticalAlignment = .bottom
    scrollView.addSubview(relButton)
    Button().makeUnderline(button: relButton)
    
      // Snapkit
      relButton.snp.makeConstraints { make in
        make.centerY.equalTo(formatButton)
        make.height.equalTo(GC.Button.height)
        make.trailing.equalTo(scrollView)
        make.width.equalTo(view).multipliedBy(0.45)
      }

    // MARK: Make the my deck label
    
    myDeck.attributedPlaceholder = NSAttributedString(
      string: Text.myDeck,
      attributes: [NSForegroundColorAttributeName: Color.TextField.placeholder]
    )
    myDeck.tag = 1
    myDeck.textColor = Color.TextField.text
    myDeck.textAlignment = .left
    myDeck.keyboardType = .default
    myDeck.autocapitalizationType = .none
    myDeck.autocorrectionType = .no
    myDeck.leftViewMode = .always
    myDeck.leftView =
      UIView(frame: CGRect(x: 0, y: 0, width: 5, height: myDeck.frame.height))
    scrollView.addSubview(myDeck)
    Button().makeUnderline(textField: myDeck)
    
      // Snapkit
      myDeck.snp.makeConstraints { make in
        make.top.equalTo(formatButton.snp.bottom).offset(GC.Padding.vertical)
        make.height.equalTo(GC.Button.height)
        make.left.equalTo(formatButton)
        make.right.equalTo(formatButton)
      }

    // MARK: Make the their deck label
    
    theirDeck.attributedPlaceholder = NSAttributedString(
      string: Text.theirDeck,
      attributes: [NSForegroundColorAttributeName: Color.TextField.placeholder]
    )
    theirDeck.tag = 2
    theirDeck.textColor = Color.TextField.text
    theirDeck.textAlignment = .left
    theirDeck.keyboardType = .default
    theirDeck.autocapitalizationType = .none
    theirDeck.autocorrectionType = .no
    theirDeck.leftViewMode = .always
    theirDeck.leftView =
      UIView(frame: CGRect(x: 0, y: 0, width: 5, height: theirDeck.frame.height))
    scrollView.addSubview(theirDeck)
    Button().makeUnderline(textField: theirDeck)
    
      // Snapkit
      theirDeck.snp.makeConstraints { make in
        make.top.equalTo(myDeck)
        make.height.equalTo(GC.Button.height)
        make.left.equalTo(relButton)
        make.right.equalTo(relButton)
      }
    
    // MARK: Make the first game view
    
    gameViewOne.initGame(vc: self, game: 1)
    scrollView.addSubview(gameViewOne)
    
      // Snapkit
      gameViewOne.snp.makeConstraints { make in
        make.top.equalTo(myDeck.snp.bottom).offset(GC.Padding.vertical)
        make.height.equalTo(100)
        make.left.equalTo(scrollView)
        make.right.equalTo(scrollView)
      }
    
    // MARK: Make the second game view
    
    gameViewTwo.initGame(vc: self, game: 2)
    scrollView.addSubview(gameViewTwo)
    
      // Snapkit
      gameViewTwo.snp.makeConstraints { make in
        make.top.equalTo(gameViewOne.snp.bottom).offset(GC.Padding.vertical)
        make.height.equalTo(100)
        make.left.equalTo(scrollView)
        make.right.equalTo(scrollView)
      }
    
    // MARK: Make the third game view
    
    gameViewThree.initGame(vc: self, game: 3)
    gameViewThree.isHidden = true
    scrollView.addSubview(gameViewThree)
    
      // Snapkit
      gameViewThree.snp.makeConstraints { make in
        make.top.equalTo(gameViewTwo.snp.bottom).offset(GC.Padding.vertical)
        make.height.equalTo(100)
        make.left.equalTo(scrollView)
        make.right.equalTo(scrollView)
      }
    
    // MARK: Make the plus button for game 3
    
    plusButton.setTitle("+", for: .normal)
    plusButton.setTitleColor(Color.TextField.text, for: .normal)
    plusButton.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 50)
    scrollView.addSubview(plusButton)
    
      // Snapkit
      plusButton.snp.makeConstraints { make in
        make.top.equalTo(gameViewTwo.snp.bottom).offset(GC.Padding.vertical)
        make.centerX.equalTo(scrollView)
      }
  
    bindViewModel()
  }
  
  /**
   *  Called by the OS when the view appears
   */
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  /**
   * Called by the OS when the view has disappeared
   */
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
  }
  
  // MARK: - Reactive Bindings
  
  /**
   *  Set up and bind the reactive elements to the view model
   */
  private func bindViewModel() {
    
    // MARK: Button Listeners
    
    formatButton.reactive.controlEvents(.touchUpInside).observeValues  { _ in
      self.present( Picker.sharedInstance.makeFormatAlert(
        model: self.viewModel), animated: false, completion: {} )
    }
    
    relButton.reactive.controlEvents(.touchUpInside).observeValues { _ in
      self.present( Picker.sharedInstance.makeRELAlert(
        model: self.viewModel), animated: false, completion: {} )
    }
    
    viewModel.myDeck <~ myDeck.reactive.continuousTextValues
    viewModel.theirDeck <~ theirDeck.reactive.continuousTextValues
  
    plusButton.reactive.controlEvents(.touchUpInside).observeValues { _ in
      self.plusButton.isHidden = true
      self.gameViewThree.isHidden = false
    }
    
    // MARK: If any of the fields are populated by user defaults we need to update the stream
    
    if(defaults.getFormat() != nil) {
      let format = defaults.getFormat()!
      formatButton.setTitle(format, for: .normal)
      viewModel.format.swap(format)
    }
    
    if(defaults.getREL() != nil) {
      let rel = defaults.getREL()!
      relButton.setTitle(rel, for: .normal)
      viewModel.rel.swap(rel)
    }
    
    if(defaults.getMyDeck() != nil) {
      let deck = defaults.getMyDeck()!
      myDeck.text = deck
      viewModel.myDeck.swap(deck)
    }
    
    // MARK: View Model Response Listeners
    
    viewModel.addButtonStream.observeValues { _ in
      self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain,
        target: self, action: #selector(self.addTapped))
    }
    
    viewModel.format.signal.observeValues { value in
      self.formatButton.setTitle(value, for: .normal)
    }
    
    viewModel.rel.signal.observeValues { value in
      self.relButton.setTitle(value, for: .normal)
    }
    
    // MARK: Game View Listeners
    
    gameViewOne.doneStream.observeValues { _ in
      self.viewModel.gameOne.swap(self.gameViewOne.getGame())
    }
    
    gameViewTwo.doneStream.observeValues { _ in
      self.viewModel.gameTwo.swap(self.gameViewTwo.getGame())
    }
    
    gameViewThree.doneStream.observeValues { _ in
      self.viewModel.gameThree.swap(self.gameViewThree.getGame())
    }
  }
  
  //Calls this function when the tap is recognized.
  func dismissKeyboard() {
    print("dismiss called")
    //Causes the view (or one of its embedded text fields) to resign the first responder status.
    view.endEditing(true)
  }
  
  // MARK: Navigation Bar Actions
  
  func addTapped(_ sender: UIButton) {
    if(viewModel.saveMatch()) {
      print("match saved")
      self.present(LogMatchViewController(), animated: true, completion: {}) }
  }
}
