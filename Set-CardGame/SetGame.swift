//
//  SetGame.swift
//  Set-CardGame
//
//  Created by Daniel Kim on 2024-01-09.
//

import Foundation

struct SetGame<Content> {
    private var backupDeck: Array<Card> = []
    private(set) var deck: Array<Card> = []
    private(set) var discardDeck: Array<Card> = []
    private(set) var cardsInPlay: Array<Card> = []
    private(set) var selectedCards: Array<Card> = []
    private(set) var score: Int
    
    init (cards: Array<Card>) {
        self.backupDeck = cards
        score = 0
        self.deck = cards
        //deck.shuffle()
        for _ in 0..<12 {
            cardsInPlay.append(deck.remove(at: 0))
        }
    }
    
    mutating func choose (_ card: Card) {
        if let chosenIndex = cardsInPlay.firstIndex(where: {$0.id == card.id}) {
            
            if selectedCards.count >= 3 {
                if (selectedCards.allSatisfy({ $0.matchingState == .isMatched })) {
                    removeSelectedCards()
                    addCards()
                } else {
                    for i in 0..<selectedCards.count {
                        if let chosenIndex = cardsInPlay.firstIndex(where: {$0.id == selectedCards[i].id}) {
                            cardsInPlay[chosenIndex].matchingState = MatchingState.isNotInMatch
                            selectedCards[i].matchingState = MatchingState.isNotInMatch
                        }
                    }
                }
            }
            
            if !cardsInPlay[chosenIndex].isSelected {

                // Checks the case where all 3 are selected
                if (selectedCards.count >= 3) {
                    let removedID = selectedCards.removeFirst().id
                    if let removedIndex = cardsInPlay.firstIndex(where: {$0.id == removedID}) {
                        cardsInPlay[removedIndex].isSelected = false
                    }
                    
                    
                }
                cardsInPlay[chosenIndex].isSelected.toggle()
                selectedCards.append(cardsInPlay[chosenIndex])
            } else {
                selectedCards.removeAll(where: {$0.id == card.id})
                cardsInPlay[chosenIndex].isSelected.toggle()
            }
        }
        
    }
    
    mutating func updateSelectedCards(isMatching: Bool) {
        for i in 0..<selectedCards.count {
            if let chosenIndex = cardsInPlay.firstIndex(where: {$0.id == selectedCards[i].id}) {
                if (isMatching) {
                    cardsInPlay[chosenIndex].matchingState = MatchingState.isMatched
                    selectedCards[i].matchingState = MatchingState.isMatched
                } else {
                    cardsInPlay[chosenIndex].matchingState = MatchingState.isMisMatched
                    selectedCards[i].matchingState = MatchingState.isMisMatched
                }
            }
        }
    }
    
    mutating func newGame() {
        score = 0
        self.deck = self.backupDeck
        self.discardDeck.removeAll()
        cardsInPlay.removeAll()
        selectedCards.removeAll()
        deck.shuffle()
        for _ in 0..<12 {
            cardsInPlay.append(deck.remove(at: 0))
        }
    }
    
    mutating func addCards() {
        for _ in 0..<min(3, deck.count) {
            cardsInPlay.append(deck.remove(at: 0))
        }
    }
    
    mutating func removeSelectedCards() {
        if (selectedCards.allSatisfy({ $0.matchingState == MatchingState.isMatched })) {
            cardsInPlay.removeAll(where: { $0.matchingState == MatchingState.isMatched })
            for i in 0..<3 {
                selectedCards[2 - i].isSelected = false
                discardDeck.append(selectedCards.removeLast())
            }
        }
    }
    
    struct Card: Identifiable {
        let content: Content
        var isSelected = false
        var matchingState = MatchingState.isNotInMatch
        
        var id: String
        init(content: Content, id: String) {
            self.content = content
            self.id = id
        }
        
        init(content: Content, isSelected: Bool, matchingState: MatchingState, id: String) {
            self.content = content
            self.matchingState = matchingState
            self.isSelected = isSelected
            self.id = id
        }
    }
    
    enum MatchingState {
        case isMatched
        case isMisMatched
        case isNotInMatch
    }
}
