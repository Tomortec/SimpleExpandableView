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
//        VStack {
//            List {
//                ForEach(0 ..< 5) {
//                    _ in
//                    ExpandableView(headerSize: CGSize(width: 200, height: 50), cardSize: CGSize(width: 200, height: 200), header: {
//                        Text("Hi")
//                    }, content: {
//                        VStack {
//                            Spacer()
//                            Text("Hello")
//                        }
//                    })
//                }
//            }
//
//            List {
//                ForEach(0 ..< 5) {
//                    _ in
//                    ExpandableView(headerSize: CGSize(width: 200, height: 50), cardWidth: 200, header: {
//                        Text("Hi")
//                    }, content: {
//                        Text("Hello")
//                            .frame(width: 200, height: 100)
//                    })
//                }
//            }
//        }
        EmptyView()
    }
}

struct ContentViewPreviews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
