//
//  CardView.swift
//  Set-CardGame
//
//  Created by Daniel Kim on 2024-01-10.
//

import SwiftUI

typealias Card = SetGame<CardContent>.Card


struct CardView: View {
    private let colors = ["blue": Color.blue, "green": Color.green, "purple": Color.purple]
    private let shapes: [String: AnyView] = ["diamond": AnyView(Rectangle()), "squiggle": AnyView(Capsule()), "oval": AnyView(Ellipse())]
    private let shadings = ["solid", "striped", "open"]


    private let selectedColors = [MatchingState.isMatched: Color.green, MatchingState.isMisMatched: Color.red, MatchingState.isNotInMatch: Color.blue]
    
    var content: CardContent
    var card: Card
    
    
    private let shapeAspectRatio: CGFloat = 3.0/2.0
    var body: some View {
        let base = RoundedRectangle(cornerRadius: 12)
        GeometryReader { geometry in
            ZStack {
                if (card.isFlipped) {
                    base.strokeBorder(lineWidth: 3)
                        .background(base.fill(.white))
                        .shadow(color: selectedColors[card.matchingState]  ?? .black, radius: card.isSelected ? geometry.size.width * 0.04 : 0)
                        .overlay(
                            CardContentView(content: content, num: content.number, card: card, geometry: geometry)
                        )
                        .foregroundColor(colors[content.color])
                } else {
                    base.strokeBorder(lineWidth: 3)
                        .background(.white)
                        .foregroundColor(.black)
                }
            }
            

            
            
            
        }
    }
    
    
}
var contentTest = CardContent(color: "blue", number: 3, shape: "oval", shading: "solid")
var cardTest = Card(content: contentTest, isSelected: true, matchingState: MatchingState.isMisMatched, id: 0)


struct CardView_Preivews: PreviewProvider {
    static var previews: some View {
    
     CardView(content: contentTest, card: cardTest)
        .padding(60)
        .aspectRatio(2.0/3.0, contentMode: .fit)
        
    }
}
