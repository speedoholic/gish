//
//  Role.swift
//  Gish
//
//  Created by Kushal Ashok on 2019/6/16.
//  Copyright © 2019 Kushal Ashok. All rights reserved.
//

import Foundation

public enum Role: Int, CaseIterable {
    case timer
    case ahCounter
    
    func getDescription() -> String {
        switch self {
        case .timer:
            return "Manage time efficiently"
        case .ahCounter:
            return "Speak without unintended pauses"
        }
    }
    
    func getImageName() -> String {
        switch self {
        case .timer:
            return "clock"
        case .ahCounter:
            return "pencil.and.ellipsis.rectangle"
        }
    }
    
    static func getString(_ index: Int) -> String {
        guard let role = Role(rawValue: index) else {
            return ""
        }
        switch  role {
        case .timer:
            return "Timer"
        case .ahCounter:
            return "Ah Counter"
        }
    }
}
