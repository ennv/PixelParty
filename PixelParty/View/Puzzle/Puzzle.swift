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
    @Binding var pushed: Bool
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
                                    .foregroundColor(self.colorGrid[index] ?? Color.background)
                            }).animation(.interactiveSpring())
                        }
                    }
                }
                Spacer()
                
                Button(action: { self.createGrid() }, label: {
                    Text("New Grid")
                }).padding()
            }.padding()
        } else {
            VStack {
                Spacer()
                Button(action: { self.startGame(difficulty: Difficulty.easy) }, label: { Text("Easy") }).font(.title)
                Spacer()
                Button(action: { self.startGame(difficulty: Difficulty.medium) }, label: { Text("Medium") }).font(.title)
                Spacer()
                Button(action: { self.startGame(difficulty: Difficulty.hard) }, label: { Text("Hard") }).font(.title)
                Spacer()
                Button(action: { self.startGame(difficulty: Difficulty.expert) }, label: { Text("Expert") }).font(.title)
                Spacer()
            }.padding()
        }
    }
    
    private func startGame(difficulty: Difficulty) {
        self.difficulty = difficulty
        self.createGrid()
    }
    
    private func createGrid() {

        let aR = Int.random(in: 0..<255)
        let aG = Int.random(in: 0..<255)
        let aB = Int.random(in: 0..<255)
        
        let bR = Int.random(in: 0..<255)
        let bG = Int.random(in: 0..<255)
        let bB = Int.random(in: 0..<255)
        
        let cR = Int.random(in: 0..<255)
        let cG = Int.random(in: 0..<255)
        let cB = Int.random(in: 0..<255)

        let dR = Int.random(in: 0..<255)
        let dG = Int.random(in: 0..<255)
        let dB = Int.random(in: 0..<255)
        
        if let difficulty = self.difficulty {
            let width = difficulty.width()
            for row in (0..<width) {
                for column in (0..<width) {
                    let index: Int = ((row * (width * 2) + column).isMultiple(of: width * 2) ? (row * (width * 2) + column) / 2 : (row * (width * 2)) / 2 + column)
                    let redAcross = Double(aR - (bR / width * column))
                    let greenAcross = Double(aG - (bG / width * column))
                    let blueAcross = Double(aB - (bB / width * column))
                    
                    
                    let redDown = Double(redAcross) - Double((cR - dR) / width * row)
                    let greenDown = Double(greenAcross) - Double((cG - dG) / width * row)
                    let blueDown = Double(blueAcross) - Double((cB - dB) / width * row)

                    self.colorGrid[index] = Color(
                        // Color by RGB requires values to be percentages (hence: / 255)
                        red: redDown / 255,
                        green: greenDown / 255,
                        blue: blueDown / 255,
                        opacity: 100)
                }
            }
        }
    }
}

struct Puzzle_Previews: PreviewProvider {
    static var previews: some View {
        Text("hi")
    }
}
