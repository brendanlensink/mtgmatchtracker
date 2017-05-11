//
//  MatchViewController.swift
//  MatchTracker
//
//  Created by Brendan Lensink on 2017-05-06.
//  Copyright © 2017 Brendan Lensink. All rights reserved.
//

import Eureka

class MatchViewController: FormViewController {

    // MARK: Properties
    
    var viewModel: MatchViewModel
    
    // MARK: View Lifecycle
    
    init() {
        viewModel = MatchViewModel()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        form +++ Section("Match Info")
            <<< DateTimeInlineRow("created"){
                $0.title = "Date Row"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
            }
            <<< TextRow("name") {
                $0.title = "Event Name"
            }
            <<< ActionSheetRow<String>("format") {
                $0.title = "Format"
                $0.selectorTitle = "Format"
                $0.options = Format.allValues
            }
            <<< ActionSheetRow<String>("rel") {
                $0.title = "REL"
                $0.selectorTitle = "REL"
                $0.options = REL.allValues
            }
            <<< TextRow("myDeck") {
                $0.title = "My Deck"
            }
            <<< TextRow("theirDeck") {
                $0.title = "Their Deck"
            }
        +++ Section("Games")
            <<< GameRow("gameOne") {
                $0.cell.game.gameNumber.value = 0
                $0.value = $0.cell.game // TODO: Move this to setup() also pointers?
            }
            <<< GameRow("gameTwo") {
                $0.cell.game.gameNumber.value = 1
                $0.value = $0.cell.game
            }
            <<< GameRow("gameThree") {
                $0.cell.game.gameNumber.value = 2
                $0.value = $0.cell.game

            }
        +++ Section()
            <<< ButtonRow() {
                $0.title = "Save"
            }
            .onCellSelection { (cell, row) in
                let (result, message) = self.viewModel.storeMatch(values: self.form.values())
                if !result {
                    // TODO: Show an error message
                    
                    self.present(AlertController.showAlert(title: "Uh Oh!", message: message)
                        , animated: true, completion: {})
                }else {
                    print(message)
                }
                
            }
    }
}
