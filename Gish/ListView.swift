//
//  ListView.swift
//  Gish
//
//  Created by Kushal Ashok on 2019/6/16.
//  Copyright © 2019 Kushal Ashok. All rights reserved.
//

import Combine
import SwiftUI

class DataSource: BindableObject {
    let didChange = PassthroughSubject<Void, Never>()
    var pictures = [String]()
    
    init() {
        let fm = FileManager.default
        if let path = Bundle.main.resourcePath, let items = try? fm.contentsOfDirectory(atPath: path) {
            for item in items {
                if item.hasPrefix("nssl") {
                    pictures.append(item)
                }
            }
        }
        didChange.send(())
    }
}

struct ListView : View {
    
    var dataSource = DataSource()
    
    var body: some View {
        NavigationView {
            List {
                Text("Test")
                Text("Test")
                Text("Test")
            }.navigationBarTitle(Text("History"))
        }
    }
}

#if DEBUG
struct ListView_Previews : PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
#endif
