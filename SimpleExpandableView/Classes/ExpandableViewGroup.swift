//
//  ExpandableViewGroup.swift
//  SimpleExpandableView
//
//  Created by Tomortec on 2022/5/18.
//  Copyright © 2022 Tomortec. All rights reserved.
//

import SwiftUI

/**
 A list of `ExpandableView` contained by `List`
 
 There are three constructors to create an `ExpandableViewGroup`.
 
 Simple example:
 ``` swift
 /* MARK: - Using Generics */
 ExpandableViewsGroup(
     headerSize: CGSize(width: 200, height: 50),
     cardSize: CGSize(width: 200, height: 200), headerViews: {
         [Text("Hi")]
     }, contentViews: {
         [Text("Hello"), Text("123"), Text(";")]
     })
 
 /* MARK: - Using [AnyView] */
 ExpandableViewsGroup(
     headerSize: CGSize(width: 200, height: 50),
     cardSize: CGSize(width: 200, height: 200), headerViews: {
         [AnyView(Text("Hi"))]
     }, contentViews: {
         Array(repeating: AnyView(Image(systemName: "heart.fill")), count: 5)
     })
 
 /* MARK: - Using Variadic Parameters */
 ExpandableViewsGroup(
     headerSize: CGSize(width: 200, height: 50),
     cardSize: CGSize(width: 200, height: 200),
     headerViews: AnyView(Text("Hello")), AnyView(Text("Hi")),
     contentViews: AnyView(Text("With")), AnyView(Text("123")))
 ```
 
 - note: the `ExpandableViewsGroup` will hide list row separator, align expandable views center, have the group's background color `.clear` by default.
 */
public struct ExpandableViewsGroup: View {
    
    let headerViews: [AnyView]
    let contentViews: [AnyView]
    
    let headerSize: CGSize
    private(set) var cardSize: CGSize
    
    var verticalSpacing: CGFloat = 10.0
    
    /// The background color of the group
    var backgroundColor: Color = .clear
    
    /// Construct a `ExpandableViewsGroup` with must-have paras: `headerSize`, `cardSize`, `headerViews`, `contentViews`
    ///
    /// - parameters:
    ///     - headerSize: the size of the `headerViews`. Required
    ///     - cardSize: defines the size of the `cardView`. Note that you can fix the size of the `cardView` by providing a valid height. Or if you'd like the height of the `cardView` to adapt to that of the `contentViews`, you can provide a negative height or just call `dynamicCardHeight()` method. Required
    ///     - headerViews: the content of header views. Required
    ///     - contentViews: the content of card views. Required
    ///
    /// - note: if the count of `headerViews` is `1`, all of the `ExpandableView`s will share the same header view. Or if the count of `headerViews` equals to that of `contentViews`, one header view will match one content view.
    /// - important: if the count of `headerViews` is neither `1` nor matches the `contentViews`'s, a `fatalError` will be thrown
    /// - important: the types of elements in `headerViews` must be the same, or the compiler will throw an error. So does `contentViews`. If you prefer different types, wrap each element with `AnyView(_:)` as the example in ``ExpandableViewsGroup`` does (buidling documentation is needed).
    public init<Header, Content>(
        headerSize: CGSize,
        cardSize: CGSize,
        headerViews:  () -> [Header],
        contentViews: () -> [Content]
    )  where Header : View, Content : View {
        self.headerSize = headerSize
        self.cardSize = cardSize
        self.headerViews = headerViews().map { AnyView($0) }
        self.contentViews = contentViews().map { AnyView($0) }
    }
    
    /// Construct a `ExpandableViewsGroup` with must-have paras: `headerSize`, `cardSize`, `headerViews`, `contentViews`
    ///
    /// - parameters:
    ///     - headerSize: the size of the `headerViews`. Required
    ///     - cardSize: defines the size of the `cardView`. Note that you can fix the size of the `cardView` by providing a valid height. Or if you'd like the height of the `cardView` to adapt to that of the `contentViews`, you can provide a negative height or just call `dynamicCardHeight()` method. Required
    ///     - headerViews: the content of header views. Required
    ///     - contentViews: the content of card views. Required
    ///
    /// - note: if the count of `headerViews` is `1`, all of the `ExpandableView`s will share the same header view. Or if the count of `headerViews` equals to that of `contentViews`, one header view will match one content view.
    /// - important: if the count of `headerViews` is neither `1` nor matches the `contentViews`'s, a `fatalError` will be thrown
    public init(
        headerSize: CGSize,
        cardSize: CGSize,
        headerViews:  () -> [AnyView],
        contentViews: () -> [AnyView]
    ) {
        self.headerViews = headerViews()
        self.contentViews = contentViews()
        self.headerSize = headerSize
        self.cardSize = cardSize
    }
    
    /// Construct a `ExpandableViewsGroup` with must-have paras: `headerSize`, `cardSize`, `headerViews`, `contentViews`
    ///
    /// - parameters:
    ///     - headerSize: the size of the `headerViews`. Required
    ///     - cardSize: defines the size of the `cardView`. Note that you can fix the size of the `cardView` by providing a valid height. Or if you'd like the height of the `cardView` to adapt to that of the `contentViews`, you can provide a negative height or just call `dynamicCardHeight()` method. Required
    ///     - headerViews: the content of header views. Required
    ///     - contentViews: the content of card views. Required
    ///
    /// - note: if the count of `headerViews` is `1`, all of the `ExpandableView`s will share the same header view. Or if the count of `headerViews` equals to that of `contentViews`, one header view will match one content view.
    /// - important: if the count of `headerViews` is neither `1` nor matches the `contentViews`'s, a `fatalError` will be thrown
    public init(
        headerSize: CGSize,
        cardSize: CGSize,
        headerViews:  AnyView...,
        contentViews: AnyView...
    ) {
        self.headerViews = headerViews
        self.contentViews = contentViews
        self.headerSize = headerSize
        self.cardSize = cardSize
    }
    
    public var body: some View {
        List {
            if headerViews.count == 1 ||
                headerViews.count == contentViews.count {
                
                ForEach(contentViews.startIndex ..< contentViews.endIndex, id: \.self) {
                    index in
                    ExpandableView(headerSize: headerSize, cardSize: cardSize, header: {
                        headerViews.count == 1 ? headerViews.first! : headerViews[index]
                    }, content: {
                        contentViews[index]
                    })
                    .listRowSeparator(.hidden)
                    .listRowBackground(backgroundColor)
                    .frame(maxWidth: .infinity) // align center
                    .padding(.vertical, verticalSpacing / 2.0)
                }
                
            } else {
                fatalError("ExpandableViewsGroup requires your headerViews.count equals 1 or equals to contentViews.count")
            }
        }
    }
}

extension ExpandableViewsGroup {
    /// Set the vertical spacing between two `ExpandableView`
    public func verticalSpacing(_ spacing: CGFloat) -> Self {
        var copied = self
        copied.verticalSpacing = spacing
        return copied
    }
    
    /// Change the background color of the group
    public func backgroundColor(_ color: Color) -> Self {
        var copied = self
        copied.backgroundColor = color
        return copied
    }
    
    /// Set all `ExpandableView` in the group with `.dynamicCardHeight()`
    ///
    /// See Also: ``ExpandableView/dynamicCardHeight()``
    public func dynamicCardHeight() -> Self {
        var copied = self
        copied.cardSize.height = -1.0
        return copied
    }
}
