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
    let match: Match?
    
    // MARK: View Lifecycle
    
    init(match: Match?) {
        viewModel = MatchViewModel(match: match)
        self.match = match
        
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
                $0.value = match?.name
            }
            <<< ActionSheetRow<String>("format") {
                $0.title = "Format"
                $0.selectorTitle = "Format"
                $0.value = match?.format
                $0.options = Format.allValues
            }
            <<< ActionSheetRow<String>("rel") {
                $0.title = "REL"
                $0.selectorTitle = "REL"
                $0.value = match?.rel
                $0.options = REL.allValues
            }
            <<< TextRow("myDeck") {
                $0.title = "My Deck"
                $0.value = match?.myDeck
            }
            <<< TextRow("theirDeck") {
                $0.title = "Their Deck"
                $0.value = match?.theirDeck
            }
        +++ Section("Games")
            <<< GameRow("game0") {
                $0.cell.game.gameNumber.value = 0
            }
            <<< GameRow("game1") {
                $0.cell.game.gameNumber.value = 1
            }
            <<< GameRow("game2") {
                $0.cell.game.gameNumber.value = 2
                $0.hidden = Eureka.Condition.function(["addButton"], { (form) -> Bool in
                    let row: ButtonRow? = form.rowBy(tag: "addButton")
                    return row?.value == nil
                })
            }
            <<< ButtonRow("addButton") {
                $0.title = "Add"
            }
            .onCellSelection { cell, row in
                row.value = "true?"
                row.hidden = true
                for row in self.form.rows {
                    row.evaluateHidden()
                }
            }
        +++ Section()
            <<< ButtonRow() {
                $0.title = "Save"
            }
            .onCellSelection { (cell, row) in
                let (result, message) = self.viewModel.storeMatch(values: self.form.valuesNonNil())
                if !result {
                    // TODO: Show a better error message
                    
                    self.present(AlertController.showAlert(title: "Uh Oh!", message: message)
                        , animated: true, completion: {})
                }else {
                    self.navigationController?.pushViewController(MatchViewController(match: nil), animated: true)
                }
            }
        
        updateGameCells()
    }
    
    // MARK: Helper Functions
    
    private func updateGameCells() {
        if let match = self.match {
            for game in match.games {
                if let gameNumber = game.gameNumber.value {
                    let gameRow = self.form.rowBy(tag: "game\(gameNumber)")
                    print(gameRow, "game\(gameNumber)")
                    
                }
                print(game.gameNumber.value, "Notes")
            }
        }
    }
}
