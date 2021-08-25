//
//  CanvasGuess.swift
//  Limitless
//
//  Created by Nils Veidis on 8/24/21.
//

import SwiftUI

struct DrawGuess: View {
    @Binding var pushed: Bool
    @Binding var secondPushed: Bool
    @Environment(\.colorScheme) var colorScheme
    @State private var playAgain: Bool = false
    var canvas: [Int: Color]
    var correctAnswer: String
    @State private var guess: String = ""
    @State private var correct: Bool?
    
    var body: some View {
        VStack {
            
            if let correct = self.correct {
                if correct {
                    Text("Correct!").bold().foregroundColor(.green)
                        .font(.largeTitle)
                        .padding()
                } else {
                    Text("Incorrect").bold().foregroundColor(.red)
                        .font(.largeTitle)
                        .padding()
                }
            }
            
            VStack(spacing: 0) {
                ForEach(0..<10) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<10) { column in
                            Rectangle()
                                .aspectRatio(1.0, contentMode: .fit)
                                .foregroundColor((self.canvas[row * 10 + column] != nil) ? self.canvas[row * 10 + column] : (self.colorScheme == .dark ? Color.gray.opacity(0.3) : Color.white.opacity(1)))
                        }
                    }
                }
            }.padding()
            
            Spacer()
            
            TextField(
                "Guess",
                text: $guess,
                onEditingChanged: { (isBegin) in
                    if isBegin {
                        print("Begins editing")
                    } else {
                        print("Finishes editing")
                    }
                },
                onCommit: {
                    self.correct = (guess.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == correctAnswer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines))
                }
            ).padding()
            .font(.title)
            
            Spacer()
            
            Button(action: { self.pushed = false }, label: {
                Text("Play again").bold()
            })
        }
    }
}

struct DrawGuess_Previews: PreviewProvider {
    static var previews: some View {
        Text("hi")
    }
}
