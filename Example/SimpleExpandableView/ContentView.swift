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
//        List {
//            ForEach(0 ..< 5) {
//                _ in
//                ExpandableView(
//                    headerSize: CGSize(width: 250.0, height: 50.0),
//                    cardSize: CGSize(width: 250.0, height: 250.0), header: {
//                        Text("Hello world")
//                            .foregroundColor(.white)
//                            .frame(maxWidth: .infinity, maxHeight: .infinity)
//                            .background(LinearGradient(colors: [.blue, .cyan], startPoint: .top, endPoint: .bottom))
//                    }, content: {
//                        VStack {
//                            Image(systemName: "heart.fill")
//                                .resizable()
//                                .frame(width: 180, height: 180)
//                            Text("Hi")
//                                .font(.title2)
//                        }
//                        .foregroundColor(.white)
//                    })
//                .cardBackgroundColor(.cyan)
//                .shadow(shadowRadius: 0.0)
//                .listRowSeparator(.hidden)
//                .frame(maxWidth: .infinity) // align center
//                .padding(.vertical, 5.0)
//            }
//        }
//
        ExpandableViewsGroup(
            headerSize: CGSize(width: 200, height: 50),
            cardSize: CGSize(width: 200, height: 200), headerViews: {
                [AnyView(Text("Hi"))]
            }, contentViews: {
                Array(repeating: AnyView(Image(systemName: "heart.fill")), count: 5)
            })
        .verticalSpacing(20.0)
        
        ExpandableViewsGroup(
            headerSize: CGSize(width: 200, height: 50),
            cardSize: CGSize(width: 200, height: 200),
            headerViews: AnyView(Text("Hello")), AnyView(Text("Hi")),
            contentViews: AnyView(Text("With")), AnyView(Text("123")))
        
        ExpandableViewsGroup(
            headerSize: CGSize(width: 200, height: 50),
            cardSize: CGSize(width: 200, height: 200), headerViews: {
                [Text("Hi")]
            }, contentViews: {
                [Text("Hello"), Text("123"), Text(";")]
            })
    }
}

struct ContentViewPreviews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
