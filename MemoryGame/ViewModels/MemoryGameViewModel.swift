//
//  CardFlipViewModel.swift
//  CardFlip
//
//  Created by Jasjeev on 8/5/21.
//

import Foundation

final class MemoryGameViewModel: ObservableObject {
    
    @Published public var showGame: Bool = false
    @Published public var gameWon: Bool = false
    @Published public var cards: [[Card]]
    @Published public var winTime:Int
    @Published public var matches: [String]
    @Published public var maxMatches: Int
    @Published public var showParental: Bool
    @Published public var parentalQ: String
    var parentalUnlocked: Double
    var cardsOpen: [Int: Bool]
    var currentlyOpen: Int?
    var ignoreTaps: Bool
    var gameStartTime: Double?
    var parentalNum1: Int?
    var parentalNum2: Int?
    
    init() {
        self.cards = []
        self.cardsOpen = [Int: Bool]()
        self.currentlyOpen = nil
        self.matches = [String]()
        self.ignoreTaps = false
        self.gameStartTime = nil
        self.winTime = 0
        self.maxMatches = 0
        self.gameWon = false
        self.parentalUnlocked = 0
        self.showParental = true
        self.parentalQ = ""
    }
    
    
    private let imageList = ["memoryBeaverCardFront", "memoryBeeCardFront", "memoryButterflyCardFront", "memoryCamelCardFront", "memoryCowCardFront", "memoryDeerCardFront", "memoryDogCardFront", "memoryFrogCardFront", "memorySnailCardFront", "memoryTurtleCardFront"]

    func setGameBoard(_ rows: Int, _ columns: Int) {
         resetGame()
        
         createBoard(rows, columns)
        
         // set game start time
         self.gameStartTime = Date().timeIntervalSince1970
            
         self.showGame = true
    }
    
    
    func createBoard(_ rows: Int, _ columns: Int) {
        let len = rows * columns

        let uniqueCards = len/2
        
        maxMatches = uniqueCards
        
        // shuffle image list
        var imageListCopy = imageList
        imageListCopy.shuffle()
        
        // create flat array of pairs of unique cards
        
        var flatArray = [Card]()
        
        for i in 0..<uniqueCards {
            let curCard = Card(id: -1, frontImage: imageListCopy[i], displayImage: "allCardBacks", showing: false)
            
            // add a pair of cards of the same image
            flatArray.append(curCard)
            flatArray.append(curCard)
        }
        
        // shuffle the flat array to get a memory game
        flatArray.shuffle()
        
        // build 2D array from flat array
        for i in 0..<rows {
            self.cards.append([Card]())
            for j in 0..<columns {
                let flatIdx = i*columns + j
                var cardToAppend = flatArray[flatIdx]
                cardToAppend.id = i*10 + j
                
                cardsOpen[cardToAppend.id] = false
                
                self.cards[i].append(cardToAppend)
            }
        }
    }
    
    func returnToLobby() {
        showGame = false
        
        resetGame()
    }
    
    func resetGame() {
        self.cards = []
        self.cardsOpen = [Int: Bool]()
        self.currentlyOpen = nil
        self.matches = [String]()
        self.ignoreTaps = false
        self.gameStartTime = nil
        self.winTime = 0
        self.maxMatches = 0
        self.gameWon = false
    }
    
    func cardTapped(_ id: Int) {
        if(!ignoreTaps) {
            handleTapped(id)
        }
        else {
            print("Ignored tap!")
        }
    }
    
    func handleTapped(_ id: Int) {
        let (tappedrow, tappedcol) = getRowColById(id)
        
        let isOpen = cardsOpen[id]!
    
        
        if(!isOpen){
            // if it's the first card to show
            if(currentlyOpen == nil) {
                currentlyOpen = id
                
                // keep showing the current card
                cards[tappedrow][tappedcol].displayImage = cards[tappedrow][tappedcol].frontImage
                cards[tappedrow][tappedcol].showing = true
                cardsOpen[id] = true
            }
            else
            {
                // if it's a match keep it open or else show it for 1 second
                
                let (prevrow, prevcol) = getRowColById(currentlyOpen!)
                
                if(cards[prevrow][prevcol].frontImage == cards[tappedrow][tappedcol].frontImage) {
                    // it's a match!
                    matches.append(cards[tappedrow][tappedcol].frontImage)
                    
                    cards[tappedrow][tappedcol].displayImage = cards[tappedrow][tappedcol].frontImage
                    cards[tappedrow][tappedcol].showing = true
                    cardsOpen[id] = true
                    cardsOpen[currentlyOpen!] = true
                    currentlyOpen = nil
                }
                else {
                    // not a match show for 1 second
                    
                    ignoreTaps = true
                    cards[tappedrow][tappedcol].displayImage = cards[tappedrow][tappedcol].frontImage
                    cards[tappedrow][tappedcol].showing = true
                    cardsOpen[id] = true
                    cardsOpen[currentlyOpen!] = true
                    
                    // close after 1 second
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [self] in
                        cards[tappedrow][tappedcol].displayImage = "allCardBacks"
                        cards[tappedrow][tappedcol].showing = false
                        cards[prevrow][prevcol].displayImage = "allCardBacks"
                        cards[prevrow][prevcol].showing = false
                        cardsOpen[id] = false
                        cardsOpen[currentlyOpen!] = false
                        currentlyOpen = nil
                        ignoreTaps = false
                    }
                }
            }
            
            // check if the user won the game
            
            if((2*matches.count) == (cards.count * cards[0].count)) {
                gameWon = true
                
                // set win time
                self.winTime = Int(floor(Date().timeIntervalSince1970 - self.gameStartTime!))
            }
        }
    }
    
    func acceptVictory() {
        gameWon = false
    }
    
    func getRowColById(_ id: Int) -> (Int, Int) {
        return (id/10, id%10)
    }
    
    func shouldShowParental() {
        // keep parental unlocked for 1 minute
        if ((Date().timeIntervalSince1970 - parentalUnlocked) > 60) {
            showParental = true
            generateParental()
        }
        else {
            showParental = false
        }
    }
    
    func generateParental() {
        parentalNum1 = Int.random(in: -10..<50)
        parentalNum2 = Int.random(in: -10..<50)
        
        parentalQ = "What is " + String(parentalNum1!) + " + " + String(parentalNum2!) + " ?"
    }
    
    func checkParental(_ ans: String) {
        let n = Int(ans)
        if((n != nil) && (n == (parentalNum1!+parentalNum2!))){
            parentalUnlocked = Date().timeIntervalSince1970
            showParental = false
        }
    }
}

