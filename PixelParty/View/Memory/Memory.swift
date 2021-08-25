//
//  Memory.swift
//  PixelParty
//
//  Created by Nils Veidis on 8/25/21.
//

import SwiftUI

struct Memory: View {
    @State var matrix: Matrix?
    @State var matrixInts: [Int] = []
    @State var score: Int = 0
    @State var matrixComplete = false
    @State var numberOfItems = 4
    @Binding var pushed: Bool
    @State private var timeRemaining = 60
    var width: Int = 5
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var timerDone: Bool = false

    var body: some View {
        VStack {
            Text("Time: \(self.timeRemaining)")
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
                .background(
                    Capsule()
                        .fill(self.timeRemaining > 10 ? Color.gray : Color.red)
                )
                .padding()
            
            Text("Points: \(self.score)").font(self.timerDone ? .largeTitle : .headline)
        
            !self.timerDone ? self.matrix : nil
            
            Spacer()

        }
        .onAppear(perform: {
            self.matrix = newMatrix()
        })
        .onChange(of: self.matrixComplete, perform: { complete in
            if complete {
                self.matrix = self.newMatrix()
            }
        })
        .onReceive(timer) { time in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            }
            if self.timeRemaining <= 0 {
                self.timerDone = true
            }
        }
    }
    
    private func newMatrix() -> Matrix {
        self.numberOfItems += 1
        let newMatrix = self.makeMatrix(numberOfItems: numberOfItems, maxNumber: self.width * self.width)
        self.matrixInts = newMatrix
            
        self.matrixComplete = false
        
        return Matrix(score: self.$score, matrix: self.$matrixInts, finished: self.$matrixComplete, width: self.width)
    }
    
    private func makeMatrix(numberOfItems: Int, maxNumber: Int) -> [Int] {
        return Array((0..<maxNumber).shuffled().prefix(numberOfItems))
    }
}

struct Matrix: View {
    @Binding var score: Int
    @Binding var matrix: [Int]
    @Binding var finished: Bool
    var width: Int
    @State var selectedBoxes: [Int] = []
    @State var showCorrect: Bool = true
    @State var correctBoxesRemaining = 0
    @State var interactableMatrix: [Int: Color] = [:]
    @State var correctMatrix: [Int: Color] = [:]
    
    var body: some View {
        VStack {
            Text("Boxes Remaining: \(self.correctBoxesRemaining)")
            ForEach(0..<width) { row in
                HStack() {
                    ForEach(0..<width) { column in
                        let index: Int = ((row * (width * 2) + column).isMultiple(of: width * 2) ? (row * (width * 2) + column) / 2 : (row * (width * 2)) / 2 + column)
                        Button(action: { self.colorPixel(index: index) }, label: {
                            Rectangle()
                                .aspectRatio(1.0, contentMode: .fit)
                                .foregroundColor(self.correctBoxesRemaining <= 0 ? Color.green : self.showCorrect ? self.correctMatrix[index] : self.interactableMatrix[index])
                        })
                        .foregroundColor(Color.background)
                        .disabled(self.showCorrect || self.correctBoxesRemaining <= 0)
                        .animation(.interactiveSpring())
                    }.border(Color.gray, width: 1)
                }
            }
        }
        .onAppear(perform: {
            // FIRST LOAD
            self.loadNewMatrix()
        })
        .onChange(of: self.matrix, perform: { _ in
            self.reset()
            // SUBSQUENT LOADS
            self.loadNewMatrix()
        })
    }
    
    private func reset() {
        self.selectedBoxes = []
        self.correctBoxesRemaining = 0
        self.interactableMatrix = [:]
        self.correctMatrix = [:]
    }
    
    private func loadNewMatrix() {
        self.showCorrect = true
        self.selectedBoxes = []
        self.interactableMatrix = self.getInteractableMatrix()
        self.correctMatrix = self.getCorrectMatrix()
        self.correctBoxesRemaining = self.matrix.count
        // Delay of 2 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.showCorrect = false
        }
    }
    
    private func getInteractableMatrix() -> [Int: Color] {
        var interactableMatrix: [Int: Color] = [:]
        let area: Int = self.width * self.width
        for index in 0..<area {
            interactableMatrix[index] = Color.background
        }
        return interactableMatrix
    }
    
    private func getCorrectMatrix() -> [Int: Color] {
        var correctMatrix: [Int: Color] = [:]
        let area: Int = self.width * self.width
        for index in 0..<area {
            correctMatrix[index] = self.matrix.contains(index) ? Color.green : Color.background
        }
        return correctMatrix
    }
    
    private func colorPixel(index: Int) {
        if self.matrix.contains(index) {
            if !self.selectedBoxes.contains(index) {
                self.interactableMatrix[index] = Color.green
                self.score += 10
                self.correctBoxesRemaining -= 1
                if self.correctBoxesRemaining <= 0 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.finished = true
                    }
                }
                self.selectedBoxes.append(index)
            }
        } else {
            if !self.selectedBoxes.contains(index) {
                self.interactableMatrix[index] = Color.red
                self.score -= 10
                self.selectedBoxes.append(index)
            }
        }
    }
}

struct Memory_Previews: PreviewProvider {
    static var previews: some View {
        Text("hi")
    }
}
