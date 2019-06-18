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

struct DetailView: View {
    var selectedImage: String
    
    @State private var hidesNavigationBar = false
    
    var body: some View {
        let image = UIImage(named: selectedImage)!
        return Image(uiImage: image)
            .resizable()
            .aspectRatio(1024/768, contentMode: .fit)
            .navigationBarTitle(Text(selectedImage), displayMode: .inline)
            .navigationBarHidden(hidesNavigationBar)
            .tapAction {
                self.hidesNavigationBar.toggle()
            }
    }
}

struct ListView : View {
    
    @ObjectBinding var dataSource = DataSource()
    
    var body: some View {
        NavigationView {
            List(dataSource.pictures.identified(by: \.self)) { picture in
                NavigationButton(destination:DetailView(selectedImage: picture), isDetail: true) {
                    Text(picture)
                }
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
