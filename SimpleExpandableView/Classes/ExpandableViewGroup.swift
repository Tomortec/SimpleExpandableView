//
//  ExpandableViewGroup.swift
//  SimpleExpandableView
//
//  Created by Tomortec on 2022/5/18.
//  Copyright © 2022 Tomortec. All rights reserved.
//

import SwiftUI

public struct ExpandableViewsGroup: View {
    
    let headerViews: [AnyView]
    let contentViews: [AnyView]
    
    let headerSize: CGSize
    var cardSize: CGSize
    
    public init(
        headerSize: CGSize,
        cardSize: CGSize,
        headerViews: () -> [AnyView],
        contentViews: () -> [AnyView]
    ) {
        self.headerViews = headerViews()
        self.contentViews = contentViews()
        self.headerSize = headerSize
        self.cardSize = cardSize
    }
    
    public var body: some View {
        List {
            if headerViews.count == 1 {
                ForEach(contentViews.startIndex ..< contentViews.endIndex, id: \.self) {
                    index in
                    ExpandableView(headerSize: headerSize, cardSize: cardSize, header: {
                        headerViews.first!
                    }, content: {
                        contentViews[index]
                    })
                    .listRowSeparator(.hidden)
                }
            } else if headerViews.count == contentViews.count {
                ForEach(contentViews.startIndex ..< contentViews.endIndex, id: \.self) {
                    index in
                    ExpandableView(headerSize: headerSize, cardSize: cardSize, header: {
                        headerViews[index]
                    }, content: {
                        contentViews[index]
                    })
                    .listRowSeparator(.hidden)
                }
            } else {
                fatalError("ExpandableViewsGroup requires your headerViews.count equals 1 or equals to contentViews.count")
            }
        }
    }
}

extension ExpandableViewsGroup {
    public func dynamicHeight() -> Self {
        var copied = self
        copied.cardSize.height = -1.0
        return copied
    }
}
