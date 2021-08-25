//
//  Puzzle.swift
//  PixelParty
//
//  Created by Nils Veidis on 8/25/21.
//

import SwiftUI

enum Difficulty {
    case easy
    case medium
    case hard
    case expert
    
    func width () -> Int {
        switch self {
        case .easy:
          return 3
        case .medium:
          return 5
        case .hard:
          return 7
        case .expert:
          return 10
        default:
          return 5
        }
      }
}
struct Puzzle: View {
    @State var colorGrid: [Int: Color] = [:]
    @State var difficulty: Difficulty?
    
    var body: some View {
        
        if let difficulty = self.difficulty {
            let width = difficulty.width()
            VStack(spacing: 0) {
                ForEach(0..<width) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<width) { column in
                            let index: Int = ((row * (width * 2) + column).isMultiple(of: width * 2) ? (row * (width * 2) + column) / 2 : (row * (width * 2)) / 2 + column)
                            Button(action: {}, label: {
                                Rectangle()
                                    .foregroundColor(self.colorGrid[index] ?? .orange)
                            }).animation(.interactiveSpring())
                        }
                        // TODO: REMOVE
                        .border(Color.black, width: 1)
                    }
                }
            }.padding()
            .onAppear(perform: {
                self.createGrid()
            })
        } else {
            VStack {
                Spacer()
                Button(action: {self.difficulty = Difficulty.easy}, label: { Text("Easy") }).font(.title)
                Spacer()
                Button(action: {self.difficulty = Difficulty.medium}, label: { Text("Medium") }).font(.title)
                Spacer()
                Button(action: {self.difficulty = Difficulty.hard}, label: { Text("Hard") }).font(.title)
                Spacer()
                Button(action: {self.difficulty = Difficulty.expert}, label: { Text("Expert") }).font(.title)
                Spacer()
            }.padding()
        }
    }
    
    private func createGrid() {
        let whiteColor = Color(red: 0, green: 0, blue: 0, opacity: 100)
        let blackColor = Color(red: 255, green: 255, blue: 255, opacity: 100)

        let aR = Int.random(in: 0..<255)
        let aG = Int.random(in: 0..<255)
        let aB = Int.random(in: 0..<255)
        
        let bR = Int.random(in: 0..<255)
        let bG = Int.random(in: 0..<255)
        let bB = Int.random(in: 0..<255)

        if let difficulty = self.difficulty {
            let width = difficulty.width()
            for row in (0..<width) {
                for column in (0..<width) {
                    let index: Int = ((row * (width * 2) + column).isMultiple(of: width * 2) ? (row * (width * 2) + column) / 2 : (row * (width * 2)) / 2 + column)
                    self.colorGrid[index] = Color(
                        red: Double(255 - (aR / width)),
                        green: Double(255 - (aG / width * column)),
                        blue: Double(255 - (aB / width * column)),
                        opacity: 100)
                }
            }
        }
    }
}

struct Puzzle_Previews: PreviewProvider {
    static var previews: some View {
        Puzzle()
    }
}
