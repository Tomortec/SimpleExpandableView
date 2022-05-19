//
//  ExpandableView.swift
//  SimpleExpandableView
//
//  Created by Tomortec on 2022/5/18.
//  Copyright © 2022 Tomortec. All rights reserved.
//

import SwiftUI

/**
 ExpandableView with `headerView` and `contentView`
 
 Simple Example:
 ``` swift
 List {
     ForEach(0 ..< 5) {
         _ in
         ExpandableView(
             headerSize: CGSize(width: 250.0, height: 50.0),
             cardSize: CGSize(width: 250.0, height: 250.0), header: {
                 Text("Hello world")
                     .foregroundColor(.white)
                     .frame(maxWidth: .infinity, maxHeight: .infinity)
                     .background(LinearGradient(colors: [.blue, .cyan], startPoint: .top, endPoint: .bottom))
             }, content: {
                 VStack {
                     Image(systemName: "heart.fill")
                         .resizable()
                         .frame(width: 180, height: 180)
                     Text("Hi")
                         .font(.title2)
                 }
                 .foregroundColor(.white)
             })
         .cardBackgroundColor(.cyan)
         .shadow(shadowRadius: 0.0)
         .listRowSeparator(.hidden)
         .frame(maxWidth: .infinity) // align center
         .padding(.vertical, 5.0)
     }
 }
 ```
 */
public struct ExpandableView<Header: View, Content: View>: View {
    
    let headerView: Header
    let contentView: Content
    
    /// The size of the header view
    let headerSize: CGSize
    
    /// The passed size of the card
    private(set) var cardSize: CGSize
    
    /// The height of the `contentView`
    @State private(set) var contentHeight: CGFloat = 100.0
    
    /// The height of the card
    ///
    /// - note: if the height of `cardSize` is negative, this value will be the height of `contentView`, that is 'dynamic height'.
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
    
    /// Used to remove the space between header and card
    private var cardYOffset: CGFloat {
        -1 * (headerCornerRadius + cardCornerRadius)
    }
    
    @State var isExpanding: Bool = false
    let action: (() -> ())?
    
    /// Construct an `ExpandableView` with must-have paras: `headerSize`, `cardSize`, `header`, `content`
    ///
    /// - parameters:
    ///     - headerSize: defines the size of the `header`. Required
    ///     - cardSize: defines the size of the `cardView`. Note that you can fix the size of the `cardView` by providing a valid height. Or if you'd like the height of the `cardView` to adapt to that of the `contentView`, you can provide a negative height or just call `dynamicCardHeight()` method. Required
    ///     - header: the content of `headerView`. Required
    ///     - content: the `contentView`, that is, the content of `cardView`. Required
    ///     - onTapped: the closure to execute when the `headerView` is tapped. Default is `nil`
    ///
    /// - note: if you are trying to wrap `ExpandableView` with `VStack`, affected by the coordinate, the `ExpandableView` will expand in two directions. A recommended container is `List` (you can remove the separator by calling `ExpandableView(...).listRowSeparator(.hidden)`)
    /// - note: if you'd like to use `View` as your background (like `LinearGradient`, `Shape`), modify your passed `headerView` instead of calling `.headerBackgroundColor(_:)` which only accepts `Color`
    /// - note: if you are only changing the background color of the `contentView` you passed, you will find that there is white space (brought by `cornerRadius`) between the `headerView` and the `contentView`. To avoid the unwanted result, use `.cardBackgroundColor(_:)` method instead.
    /// - note: you can fix the size of the `cardView` by providing a valid height. Or if you'd like the height of the `cardView` to adapt to that of the `contentView`, you can provide a negative height or just call `dynamicCardHeight()` method.
    public init(
        headerSize: CGSize,
        cardSize: CGSize,
        @ViewBuilder header: () -> Header,
        @ViewBuilder content: () -> Content,
        onTapped action: (() -> ())? = nil
    ) {
        self.headerView = header()
        self.contentView = content()
        self.headerSize = headerSize
        self.cardSize = cardSize
        self.action = action
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
                    action?()
                }
                
                VStack(spacing: 0.0) {
                    // as a spacer to prevent the `contentView` from moving upwards, being masked by the `headerView`
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

/* MARK: - Config for Appearance */
extension ExpandableView {
    /// Change the background color of header view
    ///
    /// - note: if you'd like to use `View` as your background (like `LinearGradient`, `Shape`), modify your passed `headerView` instead of calling this method
    /// For example:
    /// ``` Swift
    /// ExpandableView(
    ///     headerSize: CGSize(width: 200.0, height: 50.0),
    ///     cardSize: CGSize(width: 200.0, height: 200.0), header: {
    ///         Text("Hello world")
    ///             .foregroundColor(.white)
    ///             .frame(maxWidth: .infinity, maxHeight: .infinity)
    ///             .background(LinearGradient(colors: [.blue, .cyan], startPoint: .top, endPoint: .bottom))
    ///     }, content: {
    ///         Text("Hi")
    ///     })
    ///
    /// ```
    public func headerBackgroundColor(_ color: Color) -> Self {
        var copied = self
        copied.headerBackgroundColor = color
        return copied
    }
    
    /// Change the background color of the card view
    ///
    /// - note: if you are only changing the background color of the `contentView` you passed (Just like the codes below shows), you will find that there is white space (brought by `cornerRadius`) between the `headerView` and the `contentView`. To avoid the unwanted result, use this method instead.
    /// ``` Swift
    /// ExpandableView(
    ///      headerSize: CGSize(width: 200.0, height: 50.0),
    ///      cardSize: CGSize(width: 200.0, height: 200.0), header: {
    ///          Text("Hello world")
    ///              .foregroundColor(.white)
    ///              .frame(maxWidth: .infinity, maxHeight: .infinity)
    ///              .background(LinearGradient(colors: [.blue, .cyan], startPoint: .top, endPoint: .bottom))
    ///      }, content: {
    ///          Text("Hi")
    ///              .foregroundColor(.white)
    ///              .frame(maxWidth: .infinity, maxHeight: .infinity)
    ///              .background(.cyan) // just changing the background color of the `contentView` may cause unwanted result
    ///      })
    /// ```
    public func cardBackgroundColor(_ color: Color) -> Self {
        var copied = self
        copied.cardBackgroundColor = color
        return copied
    }
    
    /// Change the corner radius of the header view
    public func headerCornerRadius(_ radius: CGFloat) -> Self {
        var copied = self
        copied.headerCornerRadius = radius
        return copied
    }
    
    /// Change the corner radius of the card view
    public func cardCornerRadius(_ radius: CGFloat) -> Self {
        var copied = self
        copied.cardCornerRadius = radius
        return copied
    }
    
    /// Change the shadow of the whole view (both header view and card view will render shadow)
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
    
    /// Determine the height of the card view by the `contentView` you passed instead of a fixed height
    ///
    /// - note: Once this method is called, the height of `cardSize` you passed in constructor will make no sense and be set to `-1.0`. In the logic of `ExpandableView`, a card view with negative height means dynamic height is needed.
    public func dynamicCardHeight() -> Self {
        var copied = self
        copied.cardSize.height = -1.0
        return copied
    }
}
