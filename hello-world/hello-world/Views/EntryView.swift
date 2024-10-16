//
//  EntryView.swift
//  hello-world
//
//  Created by Animesh on 14/10/24.
//

import SwiftUI

struct EntryView: View {
    @State private var showHello = false
    @State private var showWorld = false
    @State private var showGlobe = false
    @State private var loginView = false
    @Binding var proceed: Bool
    
    var body: some View {
        ZStack {
            Color(red: 23/255, green: 50/255, blue: 87/255).ignoresSafeArea()
            Text("Hello")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .offset(x: showHello ? 0 : -300, y : 10)
                .opacity(loginView ? 0 : 1)
                .animation(.easeOut(duration: 1), value: showHello)
                .animation(.easeOut(duration: 0.5), value: loginView)
            Text("World!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .offset(x: showWorld ? 0 : 300, y : 50)
                .opacity(loginView ? 0 : 1)
                .animation(.easeOut(duration: 1), value: showHello)
                .animation(.easeOut(duration: 0.5), value: loginView)
            Image("AR_app_logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .offset(y: -50)
                .opacity(showGlobe ? 1 : 0)
                .animation(.easeOut(duration: 1), value: showGlobe)
        }
        .onAppear{
            showHello = true
            showWorld = true
            DispatchQueue.main.asyncAfter(deadline: .now()+1){
                showGlobe = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+2.25){
                loginView = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+2.8){
                proceed = true
            }
        }
    }
}

struct EntryView_Previews: PreviewProvider {
    @State static var proceed = false
    static var previews: some View {
        EntryView(proceed: $proceed)
    }
}
