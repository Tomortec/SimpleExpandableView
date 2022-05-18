//
//  Utilities.swift
//  SimpleExpandableView
//
//  Created by Tomortec on 2022/5/18.
//  Copyright © 2022 Tomortec. All rights reserved.
//

import SwiftUI

/* MARK: - Animation Modifier */
struct AnimatingCellHeight: AnimatableModifier {
    var height: CGFloat = 0
    
    var animatableData: CGFloat {
        get { height }
        set { height = newValue }
    }
    
    func body(content: Content) -> some View {
        content.frame(height: height)
    }
}

extension View {
    func animatingCellHeight(_ height: CGFloat) -> some View {
        modifier(AnimatingCellHeight(height: height))
    }
}

/* MARK: - Child Height Reader */
struct ChildHeightReader<Content: View>: View {
    @Binding var height: CGFloat
    let content: () -> Content
    
    var body: some View {
        ZStack {
            content()
                .background(
                    GeometryReader {
                        proxy in
                        Color.clear
                            .preference(key: HeightPreferenceKey.self,
                                        value: proxy.size.height)
                    }
                )
        }
        .onPreferenceChange(HeightPreferenceKey.self) {
            value in
            height = value
        }
    }
}

struct HeightPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: CGFloat = .zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
