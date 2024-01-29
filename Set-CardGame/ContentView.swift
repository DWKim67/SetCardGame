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
    @Namespace private var dealingNamespace
    @Namespace private var discardNamespace
    
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
    
    
    var cards: some View {
        withAnimation {
            AspectVGrid(setGame.cardsInPlay, aspectRatio: cardAspectRatio) {card in
                CardView(content: card.content, card: card)
                    .aspectRatio(cardAspectRatio, contentMode: .fit)
                    .padding(4)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .matchedGeometryEffect(id: card.id, in: discardNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .overlay{
                        MatchIndicator(matchState: card.matchingState)
                    }
                    .onTapGesture {
                        withAnimation{
                            setGame.choose(card)
                        }
                    }
                    
            }
        }
    }
    
    var deck: some View {
        var i = 0.0
        return ZStack {
            if (setGame.deck.count > 0) {
                ForEach(setGame.deck, id: \.self.id) { card in
                    CardView(content: card.content, card:card)
                        .aspectRatio(cardAspectRatio, contentMode: .fit)
                        .offset(y: CGFloat(i))
                        .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                        .transition(.asymmetric(insertion: .identity, removal: .identity))
                        .scaleEffect(0.4)
                }
                .onTapGesture {
                    deal()
                }
            } else {
                Color.clear
                    .aspectRatio(cardAspectRatio, contentMode: .fit)
                    .scaleEffect(0.4)
            }
        }
        
    }
    
    func deal() {
        withAnimation(.easeInOut(duration:0.5)){
            setGame.dealCards()
            setGame.flipDealtCards()
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
                        .matchedGeometryEffect(id: card.id, in: discardNamespace)
                        .transition(.asymmetric(insertion: .identity, removal: .identity))
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
