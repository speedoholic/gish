//
//  FormView.swift
//  Gish
//
//  Created by Kushal Ashok on 2019/6/19.
//  Copyright © 2019 Kushal Ashok. All rights reserved.
//

import Combine
import SwiftUI

struct FormView : View {
    @ObjectBinding var user = User()
    
    @State var confirmationMessage = ""
    @State var showingConfirmation = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField($user.name, placeholder: Text("Username"))
                    
                    Stepper(value: $user.age, in: 18...99) {
                        Text("Age: \(user.age)")
                    }
                    
                    TextField($user.email, placeholder: Text("Email Address"))
                    TextField($user.phone, placeholder: Text("Phone Number"))
                }
                Section {
                    Toggle(isOn: $user.isPaidMember) {
                        Text("Are you a paid member of a club?")
                    }
                    
                    if user.isPaidMember {
                        TextField($user.clubName, placeholder: Text("Club Name"))
                        TextField($user.clubNumber, placeholder: Text("Club Number"))
                        Picker(selection: $user.role, label: Text("Role in the Club")) {
                            ForEach(0 ..< User.roles.count) {
                                Text(User.roles[$0]).tag($0)
                            }
                            }
                            .pickerStyle(.wheel)
                    }
                }
                Section {
                    Button(action: {
                        self.addUser()
                    }) {
                        Text("Register")
                    }
                }
                .disabled(!user.isValid)
            }
                .navigationBarTitle(Text("Create Account"))
                .presentation($showingConfirmation) {
                   Alert(title: Text("Thank you"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func addUser() {
        guard let encoded = try? JSONEncoder().encode(user) else {
            print("Failed to encode user")
            return
        }
        guard let url = URL(string: "https://reqres.in/api/users") else {return}
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) {
            guard let data = $0 else {
                print("No Data in response: \($2?.localizedDescription ?? "Unkown erro")")
                return
            }
            if let decodedUser = try? JSONDecoder().decode(User.self, from: data) {
                self.confirmationMessage = "User \(decodedUser.name) has been registered successfully"
                self.showingConfirmation = true
            } else {
                let dataString = String(decoding: data, as: UTF8.self)
                print("Invalid response: \(dataString)")
            }
        }.resume()
    }
}

#if DEBUG
struct FormView_Previews : PreviewProvider {
    static var previews: some View {
        FormView()
    }
}
#endif
