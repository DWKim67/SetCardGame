//
//  VanillaSetGame.swift
//  Set-CardGame
//
//  Created by Daniel Kim on 2024-01-09.
//

import SwiftUI

class VanillaSetGame: ObservableObject {
    private static let colors = ["red", "green", "purple"]
    private static let shapes = ["diamond", "squiggle", "oval"]
    private static let shadings = ["solid", "striped", "open"]
    
    private static func createSetGame() -> SetGame<CardContent> {
        var cards: [SetGame<CardContent>.Card] = []
        for color in colors {
            for count in 1...3 {
                for shape in shapes {
                    for shading in shadings {
                        let content = CardContent(color: color, number: count, shape: shape, shading: shading)
                        let id = "\(color)\(count)\(shape)\(shading)"
                        cards.append(SetGame<CardContent>.Card(content: content, id: id))
                    }
                }
            }
        }
        return SetGame<CardContent>(cards: cards)
    }
    
    @Published private var game = createSetGame()
    
    var cardsInPlay: Array<SetGame<CardContent>.Card> {
        return game.cardsInPlay
    }
    
    var deck: Array<SetGame<CardContent>.Card> {
        return game.deck
    }
    
    var discardDeck: Array<SetGame<CardContent>.Card> {
        return game.discardDeck
    }
    
    func choose(_ card: SetGame<CardContent>.Card){
        game.choose(card)
        if game.selectedCards.count >= 3 {
            let isMatch = checkMatch()
            game.updateSelectedCards(isMatching: isMatch)
        }
    }
    
    func dealCards() {
        if game.selectedCards.count < 3 {
            return
        }
        
        if checkMatch() {
            game.removeSelectedCards()
        }
        
        if game.cardsInPlay.count <= 12 {
            game.addCards()
        }
    }
    
    func newGame() {
        game.newGame()
    }
    
    private func checkMatch() -> Bool {
        return game.selectedCards[0].content.isSetMatch(content1: game.selectedCards[1].content, content2: game.selectedCards[2].content)
    }
    
}
