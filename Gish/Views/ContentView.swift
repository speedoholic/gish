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
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                TextField($username)
                    .font(.largeTitle)
                    .padding()
                    .multilineTextAlignment(.center)
                
                segmentedView
                
                Text(selectedRole.getDescription())
                    .font(.callout)
                    .padding()
                    .frame(width: nil, height: 100, alignment: Alignment.center)
                
                PresentationButton(destination: ListView()) {
                    Text("Go")
                }
                
                Spacer()
            }
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
        }   .font(.headline)
            .frame(width: nil, height: 100, alignment: Alignment.center)
            .padding()
        
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
