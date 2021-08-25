//
//  ContentView.swift
//  Limitless
//
//  Created by Nils Veidis on 8/24/21.
//
enum Games: String, CaseIterable {
    
    case draw = "draw"
    
    init?(id : Int) {
        switch id {
        case 1: self = .draw
        default: return nil
        }
    }
}

import SwiftUI

struct ContentView: View {
    @State var newDrawGame: Bool = false
    @State var word: String?
    
    var body: some View {
        NavigationView {
            VStack {
                ForEach(Games.allCases, id: \.self) { game in
                    Button(action: { self.newGame(game: game) }, label: {
                        Text(game.rawValue).font(.largeTitle).bold()
                    })
                }

                
                
                if let word = self.word {
                NavigationLink(
                    destination: Draw(pushed: self.$newDrawGame, word: word)
                        .navigationBarTitle("Pixelate")
                        .navigationBarTitleDisplayMode(.inline),
                    isActive: self.$newDrawGame, label: { })
                }
            }
        }
    }
    
    private func newGame(game: Games) {
        switch game {
        case .draw:
            self.word = getWord()
            self.newDrawGame = true
        }
    }
    
    private func getWord() -> String {
        let word = ["frog", "crayon", "pig", "caterpillar", "ants", "bee", "eye", "lion", "car", "pool", "hand", "grapes", "monster", "book", "house", "balloon", "zebra", "bed", "candle", "bird", "starfish", "ear", "star", "mouse", "snail", "nose", "jar", "comb", "pen", "coin", "camera", "slide", "ladybug", "helicopter", "crayon", "night", "square", "beak", "blocks", "bark",  "rock", "leaf", "train", "mountain", "cup", "pencil", "heart", "chair", "bridge", "neck", "ghost", "fork"].randomElement()
        return word!
    }
    
    private func getMemoryMatrix() -> [Int] {
        return [1, 2]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
