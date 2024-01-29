//
//  MatchIndicator.swift
//  Set-CardGame
//
//  Created by Daniel Kim on 2024-01-22.
//

import SwiftUI

struct MatchIndicator: View {
    let errorRotVal = 0.2
    var matchState: MatchingState
    @State var scale: CGFloat = 0.0
    @State var errorRot = -0.2
    @State var lightScale: CGFloat = 0.0
    @State var lightOpacity: CGFloat = 1.0
    
    var body: some View {
        if matchState == MatchingState.isMatched {
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.green)
                .scaleEffect(scale)
                .background {
                    Image(systemName: "rays")
                        .foregroundStyle(.yellow)
                        .scaleEffect(lightScale)
                        .opacity(lightOpacity)
                }
                .onAppear {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        scale = 1.0
                    }
                    withAnimation(.easeOut(duration: 1.0)) {
                        lightScale = 4.0
                    }
                    withAnimation(.easeIn(duration:0.5).delay(0.3)) {
                        lightOpacity = 0.0
                    }
                    withAnimation(.easeIn(duration: 0.2).delay(0.8)) {
                        scale = 0.0
                    }
                    
                }
        }
        else if matchState == MatchingState.isMisMatched {
            Image(systemName: "xmark")
                .fontWeight(.black)
                .foregroundStyle(.red)
                .scaleEffect(scale)
                .rotationEffect(.radians(errorRot))
                .onAppear {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        scale = 1.0
                    }
                    withAnimation(.easeOut(duration: 0.1).repeatForever().delay(0.3)) {
                        errorRot = errorRotVal
                    }
                    withAnimation(.easeIn(duration: 0.2).delay(0.8)) {
                        scale = 0.0
                    }
                    withAnimation(.linear(duration:0.01).delay(1.0)) {
                        errorRot = errorRotVal * -1.0
                    }
                    
                }
        }
    }
}

#Preview {
    MatchIndicator(matchState: MatchingState.isMisMatched)
}
