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
    @State private var red: Double = 420
    @State private var yellow: Double = 360
    @State private var green: Double = 300
    @State private var referenceDate = Date()
    @State private var selectedColorName: String = ""
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    private var selectedRole: Role {
        return Role(rawValue: selectedRoleIndex) ?? Role.timer
    }
    
    private var selectedColor: TimerColor {
        return TimerColor(rawValue: selectedColorName) ?? TimerColor.green
    }
    
    let colors: [Color] = [.green, .yellow, .red]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                TextField($username)
                    .textFieldStyle(.roundedBorder)
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
                
                configurationView
                
                PresentationButton(destination: ListView()) {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 100, height: 100)
                        Text("Go")
                            .font(.largeTitle)
                    }
                }
                Spacer()
            }
            .background(LinearGradient(gradient: Gradient(colors:
                [.white, .gray]), startPoint: .top, endPoint: .bottom),
                    cornerRadius: 0)
            .edgesIgnoringSafeArea(.bottom)
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
    
    private var configurationView: some View {
        Group {
            if self.selectedRole == Role.timer {
                VStack {
                    HStack {
                        ForEach(colors.identified(by: \.self)) { color in
                            Button(action: {
                                print("test")
                                self.selectedColorName = color.description
                            }) {
                                ZStack {
                                    Circle()
                                        .fill(color)
                                        .frame(width: 50, height: 50)
                                    Text(self.getTimerButtonTitle(color))
                                        .font(.footnote)
                                }
                                
                            }
                        }
                    }
                    sliderView
                }
            } else {
                Text("Ah, Um, Lexical or non-lexical pauses")
            }
        }
    }
    
    private func getTimerButtonTitle(_ color: Color) -> String {
        var numberOfSeconds = green
        guard let timerColor = TimerColor.init(rawValue: color.description) else {return ""}
        switch timerColor {
        case .green:
            numberOfSeconds = green
        case .yellow:
            numberOfSeconds = yellow
        case .red:
            numberOfSeconds = red
        }
        let minutes = numberOfSeconds / 60
        return "\(minutes.rounded(toPlaces: 1))"
    }
    
    
    private var sliderView: some View {
        Group {
            if self.selectedColor == .green {
                Slider(value: $green, from: 0, through: 600, by: 30) { (didBeginChange) in
                    if didBeginChange {
                        print("Started sliding from \(self.green)")
                    }
                    //didEndChange
                    else {
                        print("Stopped sliding at \(self.green)")
                        if self.green >= self.yellow {
                            self.green = self.yellow
                        }
                    }
                }.padding()
            } else if self.selectedColor == .yellow {
                Slider(value: $yellow, from: 0, through: 600, by: 30) { (didBeginChange) in
                    if didBeginChange {
                        print("Started sliding from \(self.yellow)")
                    }
                        //didEndChange
                    else {
                        print("Stopped sliding at \(self.yellow)")
                        if self.yellow <= self.green {
                            self.yellow = self.green
                        } else if self.yellow >= self.red {
                            self.yellow = self.red
                        }
                    }
                }.padding()
            } else if self.selectedColor == .red {
                Slider(value: $red, from: 0, through: 600, by: 30) { (didBeginChange) in
                    if didBeginChange {
                        print("Started sliding from \(self.red)")
                    }
                        //didEndChange
                    else {
                        print("Stopped sliding at \(self.red)")
                        if self.red <= self.yellow {
                            self.red = self.yellow
                        }
                    }
                }.padding()
            }
        }
    }
    
//    private var timerButtonTextView: some View {
//        Group {
//            if self.selectedColor == .green {
//                Text("\(green / 60)")
//                    .font(.footnote)
//            } else if self.selectedColor == .yellow {
//                Slider(value: $yellow, from: 0, through: 600, by: 30)
//            } else if self.selectedColor == .red {
//                Slider(value: $red, from: 0, through: 600, by: 30)
//            }
//        }
//    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
