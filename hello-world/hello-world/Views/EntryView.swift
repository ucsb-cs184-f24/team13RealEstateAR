//
//  EntryView.swift
//  hello-world
//
//  Created by Animesh on 14/10/24.
//

import SwiftUI

struct EntryView: View {
    
    @Binding var proceed: Bool
    
    var body: some View {
        ZStack {
            Color(red: 23/255, green: 50/255, blue: 87/255).ignoresSafeArea()
            Image("AR_app_logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .offset(y: -13)
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now()+2.25){
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
