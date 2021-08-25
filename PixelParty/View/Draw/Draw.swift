//
//  Canvas.swift
//  Limitless
//
//  Created by Nils Veidis on 8/24/21.
//

import SwiftUI

struct Draw: View {
    @Binding var pushed: Bool
    @State var secondPushed: Bool = false
    @Environment(\.colorScheme) var colorScheme
    @State private var timeRemaining = 60
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var selectedColor: Color = .orange
    @State var canvas = [Int: Color]()
    private let colors: [Color] = [Color.orange, Color.red, Color.green, Color.blue, Color.gray]
    private let colorsTwo: [Color] = [Color.yellow, Color(.magenta), Color.purple, Color(.brown), Color.black]
    let word: String

    var body: some View {
            VStack(spacing: 0) {
                NavigationLink(destination: DrawGuess(pushed: self.$pushed, secondPushed: self.$secondPushed, canvas: self.canvas, correctAnswer: self.word), isActive: self.$secondPushed) { }
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
                    
                    Spacer()
                    
                    VStack(alignment: .center) {
                        Text("YOUR WORD:").font(.headline).foregroundColor(.gray).bold()
                        Text(self.word).font(.largeTitle).bold()
                    }
                    Spacer()
                        
                    ForEach(0..<10) { row in
                        HStack(spacing: 0) {
                            ForEach(0..<10) { column in
                                Button(action: { self.colorPixel(index: row * 10 + column) }, label: {
                                    Rectangle()
                                        .aspectRatio(1.0, contentMode: .fit)
                                        .foregroundColor((self.canvas[row * 10 + column] != nil) ? self.canvas[row * 10 + column] : (self.colorScheme == .dark ? Color.gray.opacity(0.3) : Color.white.opacity(1)))
                                }).animation(.interactiveSpring())
                            }
                        }
                    }.shadow(color: (self.colorScheme == .dark ? Color.black.opacity(0.3) : Color.gray.opacity(0.3)), radius: 6, x: 0.0, y: 0.0)
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    VStack {
                        HStack {
                            ForEach(self.colors, id: \.self) { color in
                                Button(action: { self.selectedColor = color }, label: {
                                    Rectangle()
                                        .aspectRatio(1.0, contentMode: .fit)
                                        .foregroundColor(color)
                                })
                            }
                        }
                        HStack {
                            ForEach(self.colorsTwo, id: \.self) { color in
                                Button(action: { self.selectedColor = color }, label: {
                                    Rectangle()
                                        .aspectRatio(1.0, contentMode: .fit)
                                        .foregroundColor(color)
                                })
                            }
                        }
                    }.padding()
                    
                HStack {
                    Button(action: { self.canvas = [Int: Color]() }, label: {
                            Text("Clear").foregroundColor(.red)
                                .font(.title2)
                    })
                    Spacer()
                    Button(action: { self.secondPushed = true }, label: {
                            Text("Done").foregroundColor(.blue)
                                .font(.title2)
                    })
                }.padding()
                Spacer()
                }
                .onReceive(timer) { time in
                    if self.timeRemaining > 0 {
                        self.timeRemaining -= 1
                    }
                    if self.timeRemaining <= 0 {
                        self.secondPushed = true
                    }
        }

    }
    
    private func colorPixel(index: Int) {
        if self.canvas[index] == nil || self.canvas[index] != self.selectedColor {
            self.canvas[index] = self.selectedColor
        } else {
            self.canvas[index] = nil
        }
    }
}

struct Draw_Previews: PreviewProvider {
    static var previews: some View {
        Text("hi")
    }
}
