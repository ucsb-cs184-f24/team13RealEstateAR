//
//  ContentView.swift
//  hello-world
//
//  Created by Animesh on 07/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showHello = false
    @State private var showWorld = false
    @State private var showGlobe = false
    @State private var globeRotation = 0.0
    @State private var moveTextUp = false
    @State private var showName = false
    
    var body: some View {
        ZStack {
            Color(.white).ignoresSafeArea()
                Text("Hello")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .offset(x: showHello ? 0 : -300, y : -80)
                    .offset(x: moveTextUp ? -130 : 0, y: moveTextUp ? -280 : 0)
                    .animation(.easeOut(duration: 1), value: showHello)
                    .animation(.easeInOut(duration: 1), value: moveTextUp)
                Text("World!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .offset(x: showWorld ? 0 : 300, y : -40)
                    .offset(x: moveTextUp ? -28 : 0, y: moveTextUp ? -320 : 0)
                    .animation(.easeOut(duration: 1), value: showHello)
                    .animation(.easeInOut(duration: 1), value: moveTextUp)
                Image(systemName: "globe")
                    .font(.system(size: 80))
                    .foregroundColor(.blue)
                    .offset(y : 30)
                    .opacity(showGlobe ? 1 : 0)
                    .rotation3DEffect(
                        .degrees(globeRotation),
                        axis: (x: 0, y: 1, z: 0)
                    )
                    .animation(.easeInOut(duration: 0.25), value: showGlobe)
                Text("Animesh")
                    .font(.title)
                    .fontWeight(.thin)
                    .offset(y : -15)
                    .opacity(showName ? 1 : 0)
                    .animation(.easeIn(duration: 0.5), value: showName)
                Text("Sachan")
                    .font(.title)
                    .fontWeight(.thin)
                    .offset(y : 15)
                    .opacity(showName ? 1 : 0)
                    .animation(.easeIn(duration: 0.5), value: showName)
        }
        .onAppear{
            showHello = true
            showWorld = true
            DispatchQueue.main.asyncAfter(deadline: .now()+1){
                showGlobe = true
                withAnimation(Animation.linear(duration: 0.5).delay(0.5)){
                    globeRotation = 180
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+3){
                showGlobe = false
                moveTextUp = true
                showName = true
            }
        }
    }
}

#Preview {
    ContentView()
}
