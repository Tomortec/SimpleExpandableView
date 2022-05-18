//
//  ExpandableView.swift
//  SimpleExpandableView
//
//  Created by Tomortec on 2022/5/18.
//  Copyright © 2022 Tomortec. All rights reserved.
//

import SwiftUI

public struct ExpandableView<Header: View, Content: View>: View {
    
    let headerView: Header
    let contentView: Content
    
    /// The size of the header view
    let headerSize: CGSize
    
    /// The size of the card
    var cardSize: CGSize
    
    @State var contentHeight: CGFloat = 100.0
    
    var desiredCardHeight: CGFloat {
        cardSize.height < 0.0 ? contentHeight : cardSize.height
    }
    
    var headerBackgroundColor:  Color = .white
    var cardBackgroundColor: Color = .white
    
    var headerCornerRadius: CGFloat = 12.0
    var cardCornerRadius: CGFloat   = 12.0
    
    var shadowRadius: CGFloat = 6.0
    var shadowColor: Color = .gray
    var shadowXOffset: CGFloat = 0.0
    var shadowYOffset: CGFloat = 0.0
    
    /// Used to remove the weird space between header and card
    private var cardYOffset: CGFloat {
        -1 * (headerCornerRadius + cardCornerRadius)
    }
    
    @State var isExpanding: Bool = false
    
    public init(
        headerSize: CGSize,
        cardSize: CGSize,
        @ViewBuilder header: () -> Header,
        @ViewBuilder content: () -> Content
    ) {
        self.headerView = header()
        self.contentView = content()
        self.headerSize = headerSize
        self.cardSize = cardSize
    }
    
    public var body: some View {
        // used to modify the whole view's coordinate
        GeometryReader {
            _ in
            VStack(spacing: cardYOffset) {
                HeaderView(size: headerSize, header: {
                    headerView
                })
                .background(headerBackgroundColor)
                .cornerRadius(headerCornerRadius)
                .zIndex(5)
                .onTapGesture {
                    withAnimation {
                        isExpanding.toggle()
                    }
                }
                
                VStack(spacing: 0.0) {
                    cardBackgroundColor.frame(width: cardSize.width, height: abs(cardYOffset))
                    
                    ChildHeightReader(height: $contentHeight) {
                        contentView
                    }
                }
                .frame(width: cardSize.width)
                .animatingCellHeight(isExpanding ? desiredCardHeight + abs(cardYOffset) : 0.0)
                .background(cardBackgroundColor)
                .cornerRadius(cardCornerRadius)
            }
            .shadow(color: shadowColor, radius: shadowRadius, x: shadowXOffset, y: shadowYOffset)
        }
        .frame(width: max(headerSize.width, cardSize.width))
        .animatingCellHeight(isExpanding ? headerSize.height + desiredCardHeight : headerSize.height)
    }
}

extension ExpandableView {
    /// Change the background color of header view
    ///
    /// - note: if you'd like to use `View` as your background, modify your passed `headerView` instead of calling this method
    public func headerBackgroundColor(_ color: Color) -> Self {
        var copied = self
        copied.headerBackgroundColor = color
        return copied
    }
    
    public func cardBackgroundColor(_ color: Color) -> Self {
        var copied = self
        copied.cardBackgroundColor = color
        return copied
    }
    
    public func headerCornerRadius(_ radius: CGFloat) -> Self {
        var copied = self
        copied.headerCornerRadius = radius
        return copied
    }
    
    public func cardCornerRadius(_ radius: CGFloat) -> Self {
        var copied = self
        copied.cardCornerRadius = radius
        return copied
    }
    
    public func shadow(
        shadowRadius: CGFloat = 6.0,
        color: Color = .gray,
        x: CGFloat = 0.0,
        y: CGFloat = 0.0
    ) -> Self {
        var copied = self
        copied.shadowRadius = shadowRadius
        copied.shadowColor = color
        copied.shadowXOffset = x
        copied.shadowYOffset = y
        return copied
    }
    
    public func dynamicHeight() -> Self {
        var copied = self
        copied.cardSize.height = -1.0
        return copied
    }
}
