//
//  PulsingLoader.swift
//  APIApp
//
//  Created by Israel Berezin on 2/19/20.
//  Copyright © 2020 Israel Berezin. All rights reserved.
//

import SwiftUI

struct PulsingLoader: View {
    
    @State private var pulsate = false  // for small white cdircle
    @State private var progress = false  // for white ring
    var extWidth: CGFloat = 80
    var extheight: CGFloat = 80
    var intWidth: CGFloat = 25
    var intheight: CGFloat = 25
    var animationColor = Color(#colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1))
    
    var body: some View {
              ZStack {
//              RadialGradient(gradient: Gradient(colors: [Color.white, Color.red]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, startRadius: /*@START_MENU_TOKEN@*/5/*@END_MENU_TOKEN@*/, endRadius: /*@START_MENU_TOKEN@*/500/*@END_MENU_TOKEN@*/)
//                  .scaleEffect(1.2)
              Circle() // Large circle
                  .frame(width: extWidth, height: extheight)
                  .foregroundColor(Color(#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)))
              Circle() // Ring
                  .trim(from: progress ? 0 : 1, to: 1)
                  .stroke(style: StrokeStyle(lineWidth: 7, lineCap: .round, lineJoin: .round))
                  .frame(width: extWidth, height: extheight)
                  .foregroundColor(animationColor)
                  .opacity(0.4)
              Circle() // Ring
                  .trim(from: progress ? 0 : 1, to: 1)
                  .stroke(style: StrokeStyle(lineWidth: 7, lineCap: .round, lineJoin: .round))
                  .frame(width: extWidth, height: extheight)
                  .foregroundColor(animationColor)
                  .rotationEffect(.degrees(90))
                  .rotation3DEffect(.degrees(180), axis: (x: 1, y: 0, z: 0))
                  .animation(Animation.easeInOut(duration: 4).repeatForever(autoreverses: false))
                  .onAppear() {
                      self.progress.toggle()
              }
              Circle() // small circle
                  .frame(width: intWidth, height: intheight)
                  .foregroundColor(animationColor)
                  .scaleEffect(pulsate ? 1 : 0.6)
                  .animation(Animation.spring(response: 0.3, dampingFraction: 0.2, blendDuration: 0).repeatForever(autoreverses: false))
                  .onAppear() {
                      self.pulsate.toggle()
              }
              }.shadow(radius: 25).frame(width: 200, height: 200, alignment: .center)
    }
}

struct PulsingLoader_Previews: PreviewProvider {
    static var previews: some View {
        PulsingLoader()
    }
}
