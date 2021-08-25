//
//  ContentView.swift
//  Limitless
//
//  Created by Nils Veidis on 8/24/21.
//

import SwiftUI

struct ContentView: View {
    @State var pushed: Bool = false
    @State var word: String?
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: { self.newGame() }, label: {
                    Text("Start").font(.largeTitle).bold()
                })
                if let word = self.word {
                NavigationLink(
                    destination: Draw(pushed: self.$pushed, word: word)
                        .navigationBarTitle("Pixelate")
                        .navigationBarTitleDisplayMode(.inline),
                    isActive: self.$pushed, label: { })
                }
            }
        }
    }
    
    private func newGame() {
        self.word = getWord()
        self.pushed = true
    }
    
    private func getWord() -> String {
        let word = ["frog", "crayon", "pig", "caterpillar", "ants", "bee", "eye", "lion", "car", "pool", "hand", "grapes", "monster", "book", "house", "balloon", "zebra", "bed", "candle", "bird", "starfish", "ear", "star", "mouse", "snail", "nose", "jar", "comb", "pen", "coin", "camera", "slide", "ladybug", "helicopter", "crayon", "night", "square", "beak", "blocks", "bark",  "rock", "leaf", "train", "mountain", "cup", "pencil", "heart", "chair", "bridge", "neck", "ghost", "fork"].randomElement()
        return word!
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
