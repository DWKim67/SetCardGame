//
//  ContentView.swift
//  Set-CardGame
//
//  Created by Daniel Kim on 2024-01-08.
//

import SwiftUI

private let cardAspectRatio: CGFloat = 2.0/3.0

struct ContentView: View {
    @ObservedObject var setGame: VanillaSetGame
    
    var body: some View {
        VStack {
            cards
            HStack{
                deck
                Spacer()
                discardDeck
            }
            HStack{
                newGameButton
                Spacer()
                dealCardButton
            }
        }
        .padding()
    }
    
    private var newGameButton: some View {
        Button {
            setGame.newGame()
        } label: {
            Text("New Game")
        }
    }
    
    private var dealCardButton: some View {
        Button {
            setGame.dealCards()
        } label: {
            Text("Deal 3 Cards")
        }.disabled(setGame.deck.count == 0)
    }
    
    var cards: some View {
        AspectVGrid(setGame.cardsInPlay, aspectRatio: cardAspectRatio) {card in
            CardView(content: card.content, card: card)
                .aspectRatio(cardAspectRatio, contentMode: .fit)
                .padding(4)
                .onTapGesture {
                    setGame.choose(card)
                }
        }
    }
    
    var deck: some View {
        var i = 0.0
        return ZStack {
            if (setGame.deck.count > 0) {
                ForEach(setGame.deck) { card in
                    CardView(content: card.content, card:card)
                        .aspectRatio(cardAspectRatio, contentMode: .fit)
                        .offset(y: CGFloat(i))
                        .scaleEffect(0.4)
                    ExecuteCode({i -= 1})
                }
            } else {
                Color.clear
                    .aspectRatio(cardAspectRatio, contentMode: .fit)
                    .scaleEffect(0.4)
            }
        }
    }
    
    var discardDeck: some View {
        var i = 0.0
        return ZStack {
            if (setGame.discardDeck.count > 0) {
                ForEach(setGame.discardDeck) { card in
                    CardView(content: card.content, card:card)
                        .aspectRatio(cardAspectRatio, contentMode: .fit)
                        .offset(y: CGFloat(i))
                        .scaleEffect(0.4)
                    ExecuteCode({i -= 1})
                }
            } else {
                Color.clear
                    .aspectRatio(cardAspectRatio, contentMode: .fit)
                    .scaleEffect(0.4)
            }
        }
    }

    struct ExecuteCode : View {
        init( _ codeToExec: () -> () ) {
            codeToExec()
        }
        
        var body: some View {
            EmptyView()
        }
    }
}



#Preview {
    ContentView(setGame: VanillaSetGame())
}
