//
//  SetGameView.swift
//  Set
//
//  Created by Ruslan Alekyan on 14.04.2023.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var game: SetGameViewModel
    
    @Namespace private var deckNamespace
    
    var body: some View {
        VStack {
            gameBody
            
            HStack {
                Spacer()
                deckBody
                Spacer()
                restartButton
                Spacer()
                discardPileBody
                Spacer()
            }
            .padding()
        }
        .background(.black)
    }
    
    private var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            CardView(card: card)
                .matchedGeometryEffect(id: card.id, in: deckNamespace)
                .onTapGesture {
                    withAnimation {
                        game.choose(card)
                    }
                }
        }
        .padding()
    }
    
    private var deckBody: some View {
        VStack(spacing: 0) {
            Text("Deck")
                .foregroundStyle(.white)
            ZStack {
                ForEach(game.deck) { card in
                    CardView(card: card, isDealt: false)
                        .matchedGeometryEffect(id: card.id, in: deckNamespace)
                }
            }
            .frame(width: 60, height: 90)
            .onTapGesture {
                withAnimation {
                    game.dealThreeCards()
                }
            }
        }
    }
    
    private var restartButton: some View {
        Button("Restart") {
            withAnimation {
                game.restart()
            }
        }
    }
    
    private var discardPileBody: some View {
        VStack(spacing: 0) {
            Text("Discard Pile")
                .foregroundStyle(.white)
            ZStack {
                ForEach(game.discardPile) { card in
                    CardView(card: card)
                        .matchedGeometryEffect(id: card.id, in: deckNamespace)
                }
            }
            .frame(width: 60, height: 90)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGameViewModel()
        SetGameView(game: game)
    }
}
