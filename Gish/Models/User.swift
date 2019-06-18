//
//  User.swift
//  Gish
//
//  Created by Kushal Ashok on 2019/6/19.
//  Copyright © 2019 Kushal Ashok. All rights reserved.
//

import Combine
import SwiftUI

class User: BindableObject, Codable {
    enum CodingKeys: String, CodingKey {
        case name, age, email, phone, isPaidMember, clubName, clubNumber, role
    }
    
    let didChange = PassthroughSubject<Void, Never>()
    
    static let roles = ["Member", "President", "VPPR", "VPM", "VPE", "Treasurer", "Secretary", "SAA"]
    
    var name = "" {didSet {update()}}
    var age = 18  {didSet {update()}}
    var email = "" {didSet {update()}}
    var phone = "" {didSet {update()}}
    
    var isValid: Bool {
        if name.isEmpty || email.isEmpty || phone.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    var isPaidMember = false {didSet {update()}}
    var clubName = ""  {didSet {update()}}
    var clubNumber = ""  {didSet {update()}}
    var role = 0 {didSet {update()}}
    
    func update() {
        didChange.send(())
    }
}
