//
//  ContentView.swift
//  SimpleExpandableView_Example
//
//  Created by Tomortec on 2022/5/18.
//  Copyright © 2022 Tomortec. All rights reserved.
//

import SwiftUI
import SimpleExpandableView

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("ExpandableView Example", destination: {
                    ComponentExample()
                })
                NavigationLink("ExpandableViewsGroup Example", destination: {
                    GroupExample()
                })
            }
            .navigationTitle("Examples")
        }
        .navigationViewStyle(.columns)
    }
}

struct ContentViewPreviews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
