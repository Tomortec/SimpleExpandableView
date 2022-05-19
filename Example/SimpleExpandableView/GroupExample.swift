//
//  GroupExample.swift
//  SimpleExpandableView_Example
//
//  Created by 李奥 on 2022/5/19.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI
import SimpleExpandableView

struct GroupExample: View {
    var body: some View {
        ExpandableViewsGroup(headerSize: CGSize(width: 300.0, height: 80.0), cardSize: CGSize(width: 300.0, height: 300.0), headerView: {
            HStack {
                Image(systemName: "person.circle")
                    .font(.largeTitle)
                
                VStack {
                    Text("Header")
                        .font(.title)
                    Text("SimpleExpandableView")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(colors: [.blue, .cyan], startPoint: .topTrailing, endPoint: .bottomLeading))
        }, contentViews: {[
            AnyView(Image(systemName: "heart.fill")
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: 120, height: 120)
                .padding()),
            AnyView(Image(systemName: "sun.max.fill")
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: 120, height: 120)
                .padding()),
            AnyView(Image(systemName: "moon.fill")
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: 120, height: 120)
                .padding())
        ]})
        .cardBackgroundColor(.cyan)
        .shadow(shadowRadius: 0.0)
        .dynamicCardHeight()
        .verticalSpacing(10.0)
        .foregroundColor(.white)
    }
}

struct GroupExamplePreviews: PreviewProvider {
    static var previews: some View {
        GroupExample()
    }
}
