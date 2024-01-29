//
//  CardContentView.swift
//  Set-CardGame
//
//  Created by Daniel Kim on 2024-01-12.
//

import SwiftUI

struct CardContentView: View {
    
    private let colors = ["red": Color.red, "green": Color.green, "purple": Color.purple]
    private let shapes: [String: AnyShape] = ["diamond": AnyShape(Rectangle()), "squiggle": AnyShape(Capsule()), "oval": AnyShape(Ellipse())]
    private let shadings = ["solid", "striped", "open"]


    private let selectedColors = [MatchingState.isMatched: Color.green, MatchingState.isMisMatched: Color.red, MatchingState.isNotInMatch: Color.blue]
    
    var content: CardContent
    var num: Int
    var card: Card
    var geometry: GeometryProxy
    
    private let shapeAspectRatio: CGFloat = 3.0/2.0
    
    var body: some View {
        LazyVStack{
            ForEach(0..<num) {_ in
                (shapes[content.shape]!)
                    
                    .fill((colors[content.color] ?? .black)
                        .opacity((content.shading == "solid") ? 1 : ((content.shading == "striped") ? 0.5 : 0)))
                    .stroke(colors[content.color]!, lineWidth:
                                (content.shading == "open") ? 2 : 0)
                    .aspectRatio(shapeAspectRatio, contentMode: .fit)
                    .frame(width: geometry.size.width * 0.8 ,height: geometry.size.height * 0.7 / CGFloat(num) )
            }
        }
    }
    
    
    
}



//struct CardContentView_Preivews: PreviewProvider {
//    static var previews: some View {
//    
//        CardContentView(content: contentTest, card: cardTest, geometry: <#T##GeometryProxy#>)
//
//        
//    }
//}


struct CardContentView_Preivews: PreviewProvider {
    static var previews: some View {
    
        CardView(content: contentTest, card: cardTest)
        .padding(60)
        .aspectRatio(2.0/3.0, contentMode: .fit)
        
    }
}
