//
//  ComponentExample.swift
//  SimpleExpandableView_Example
//
//  Created by Tomortec on 2022/5/18.
//  Copyright © 2022 Tomortec. All rights reserved.
//

import SwiftUI
import SimpleExpandableView

struct ComponentExample: View {
    
    var body: some View {
        List {
            /* MARK: - Fixed Height */
            ExpandableView(
                headerSize: CGSize(width: 300.0, height: 50.0),
                cardSize: CGSize(width: 300.0, height: 200.0), header: {
                    Text("Fixed Height")
                        .font(.title)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(LinearGradient(colors: [.blue, .cyan], startPoint: .topTrailing, endPoint: .bottomLeading))
                }, content: {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fit)
                        // as you can see, compared with `No Shadow` view, the policy of resizing affects the animation
                        .scaleEffect(0.6)
                })
            .cardBackgroundColor(.cyan)
            .frame(maxWidth: .infinity)
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .padding(.vertical)
            
            /* MARK: - Dynamic Height */
            ExpandableView(
                headerSize: CGSize(width: 300.0, height: 50.0),
                cardSize: CGSize(width: 300.0, height: 200.0), header: {
                    Text("Dynamic Height")
                        .font(.title)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(LinearGradient(colors: [.red, .pink], startPoint: .topTrailing, endPoint: .bottomLeading))
                }, content: {
                    Image(systemName: "heart.fill")
                        .resizable()
                        // as you can see, compared with `Fixed Height` view, the policy of resizing affects the animation
                        .frame(width: 120.0, height: 120.0)
                })
            .cardBackgroundColor(.pink)
            .dynamicCardHeight()
            .frame(maxWidth: .infinity)
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .padding(.vertical)
            
            /* MARK: - No Shadow */
            ExpandableView(
                headerSize: CGSize(width: 300.0, height: 50.0),
                cardSize: CGSize(width: 300.0, height: 200.0), header: {
                    Text("No Shadow")
                        .font(.title)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(LinearGradient(colors: [.orange, .yellow], startPoint: .topTrailing, endPoint: .bottomLeading))
                }, content: {
                    Image(systemName: "heart.fill")
                        .resizable()
                        // as you can see, compared with `Fixed Height` view, the policy of resizing affects the animation
                        .frame(width: 120.0, height: 120.0)
                })
            .cardBackgroundColor(.yellow)
            .shadow(shadowRadius: 0)
            .frame(maxWidth: .infinity)
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .padding(.vertical)
            
            /* MARK: - Harmony */
            ExpandableView(
                headerSize: CGSize(width: 300.0, height: 50.0),
                cardSize: CGSize(width: 300.0, height: 200.0), header: {
                    Text("Harmony")
                        .font(.title)
                }, content: {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .frame(width: 120.0, height: 120.0)
                })
            .headerBackgroundColor(.mint)
            .cardBackgroundColor(.mint)
            .shadow(shadowRadius: 0)
            .frame(maxWidth: .infinity)
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .padding(.vertical)
            
            /* MARK: - More Complex One */
            ExpandableView(
                headerSize: CGSize(width: 300.0, height: 80.0),
                cardSize: CGSize(width: 300.0, height: 200.0), header: {
                    HStack {
                        Image(systemName: "person.circle")
                            .font(.largeTitle)
                        VStack(alignment: .leading) {
                            Text("Complex")
                                .font(.title2)
                            
                            Text("SimpleExpandableView")
                        }
                    }
                }, content: {
                    VStack {
                        Image(systemName: "heart.fill")
                            .resizable()
                            .frame(width: 120.0, height: 120.0)
                        
                        Text("Designed with heart")
                            .font(.title2)
                    }
                })
            .headerBackgroundColor(.purple)
            .cardBackgroundColor(.purple)
            .shadow(shadowRadius: 0)
            .frame(maxWidth: .infinity)
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .padding(.vertical)
        }
        .foregroundColor(.white)
    }
}

struct ComponentExamplePreviews: PreviewProvider {
    static var previews: some View {
        ComponentExample()
    }
}
