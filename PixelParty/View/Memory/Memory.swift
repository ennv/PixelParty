//
//  Memory.swift
//  PixelParty
//
//  Created by Nils Veidis on 8/25/21.
//

import SwiftUI

struct Memory: View {
    
    var body: some View {
        Text("ho ")
//        ForEach(0..<10) { row in
//            HStack(spacing: 0) {
//                ForEach(0..<10) { column in
//                    Button(action: { self.colorPixel(index: row * 10 + column) }, label: {
//                        Rectangle()
//                            .aspectRatio(1.0, contentMode: .fit)
//                            .foregroundColor((self.canvas[row * 10 + column] != nil) ? self.canvas[row * 10 + column] : (self.colorScheme == .dark ? Color.gray.opacity(0.3) : Color.white.opacity(1)))
//                    }).animation(.interactiveSpring())
//                }
//            }
//        }
    }
}

struct Memory_Previews: PreviewProvider {
    static var previews: some View {
        Memory()
    }
}
