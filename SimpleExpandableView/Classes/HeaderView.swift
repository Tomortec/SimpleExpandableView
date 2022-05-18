//
//  HeaderView.swift
//  SimpleExpandableView
//
//  Created by Tomortec on 2022/5/18.
//  Copyright © 2022 Tomortec. All rights reserved.
//

import SwiftUI

struct HeaderView<V: View>: View {
    
    let headerView: V
    
    let size: CGSize
    var cornerRadius: CGFloat = 12.0
    
    init(size: CGSize, @ViewBuilder header: () -> V) {
        self.headerView = header()
        self.size = size
    }
    
    var body: some View {
        ZStack {
            headerView
        }
        .frame(width: size.width, height: size.height)
        .cornerRadius(cornerRadius)
    }
}

extension HeaderView {
    func cornerRadius(_ radius: CGFloat) -> Self {
        var copied = self
        copied.cornerRadius = radius
        return self
    }
}
