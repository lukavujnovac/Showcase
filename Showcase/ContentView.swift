//
//  ContentView.swift
//  Showcase
//
//  Created by Luka Vujnovac on 23.12.2023..
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 80) {
            VStack{
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                
                Text("Hello, world!")
            }
            .showCase(
                order: 0,
                title: "First showcase window",
                cornerRadius: 10,
                style: .continuous,
                scale: 1.2
            )
            
            HStack {
                Button("Tap me", action: {})
                    .buttonStyle(.bordered)
                    .showCase(
                        order: 1,
                        title: "Second showcase window.",
                        cornerRadius: 10,
                        style: .continuous
                    )
                
                Button("Tap me 2", action: {})
                    .buttonStyle(.bordered)
                    .showCase(
                        order: 2,
                        title: "Third showcase window.",
                        cornerRadius: 10,
                        style: .continuous
                    )
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .showcaseRoot(onFinished: {
            print("Showcase finished")
        })
    }
}

#Preview {
    ContentView()
}
