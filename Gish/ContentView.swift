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
                    .background(Color.white)
                    .multilineTextAlignment(.center)
                
                segmentedView
                
                Divider()
                
                Text(selectedRole.getDescription())
                    .font(.callout)
                    .padding()
                
                Spacer()
            }
            .background(Color(white: 0.85))
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle(Text("Gish"))
        }
    }
    
    private var segmentedView: some View {
        SegmentedControl(selection: $selectedRoleIndex) {
            ForEach(0..<Role.allCases.count) { index in
                Text(Role.getString(index)).tag(index)
            }
        }   .font(.subheadline)
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
