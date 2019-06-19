//
//  ContentView.swift
//  Gish
//
//  Created by Kushal Ashok on 2019/6/16.
//  Copyright © 2019 Kushal Ashok. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    
    @State private var username: String = "Guest"
    @State private var selectedRoleIndex: Int = 0
    
    private var selectedRole: Role {
        return Role(rawValue: selectedRoleIndex) ?? Role.timer
    }
    
    let colors: [Color] = [.green, .yellow, .red]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                TextField($username)
                    .font(.largeTitle)
                    .padding()
                    .multilineTextAlignment(.center)
                
                segmentedView
                
                Image(systemName: selectedRole.getImageName())
                    .foregroundColor(Color.blue)
                    .font(.largeTitle)
                
                
                Text(selectedRole.getDescription())
                    .font(.callout)
                    .padding()
                    .frame(width: nil, height: 100, alignment: Alignment.center)
                
                hintView
                
                PresentationButton(destination: ListView()) {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 150, height: 150)
                        Text("Go")
                            .font(.largeTitle)
                    }
                }
                
                Spacer()
            }
            .background(LinearGradient(gradient: Gradient(colors:
                [.white, .gray]), startPoint: .top, endPoint: .bottom),
                    cornerRadius: 0)
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle(Text("Gish"))
            .navigationBarItems(trailing:
                PresentationButton(destination:FormView()) {
                    Text("Register")
                }
            )
        }
    }
    
    private var segmentedView: some View {
        SegmentedControl(selection: $selectedRoleIndex) {
            ForEach(0..<Role.allCases.count) { index in
                Text(Role.getString(index)).tag(index)
            }
        }   .font(.largeTitle)
            .frame(width: nil, height: 100, alignment: Alignment.center)
            .padding()
        
    }
    
    private var hintView: some View {
        Group {
            if selectedRole == .timer {
                HStack {
                    //TODO: Convert each circle to a button and show a picker to change the values while using a model to save timer configuration
                    ForEach(colors.identified(by: \.self)) { color in
                        Circle()
                            .fill(color)
                            .frame(width: 50, height: 50)
                    }
                }
            } else {
                Text("Ah, Um, Lexical or non-lexical pauses")
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
