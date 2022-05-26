//
//  HVStack.swift
//  InAccessibility
//
//  Created by Ryan Lintott on 2022-05-25.
//

import SwiftUI

/// An HStack that can change into a VStack based on a boolean value.
struct HVStack<Content: View>: View {
    let useVStack: Bool
    let alignment: Alignment
    let spacing: CGFloat?
    let content: () -> Content
    
    init(useVStack: Bool, alignment: Alignment = .center, spacing: CGFloat? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.useVStack = useVStack
        self.alignment = alignment
        self.spacing = spacing
        self.content = content
    }
    
    var body: some View {
        if useVStack {
            VStack(alignment: alignment.horizontal, spacing: spacing, content: content)
        } else {
            HStack(alignment: alignment.vertical, spacing: spacing, content: content)
        }
    }
}

struct HVStack_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HVStack(useVStack: false) {
                Text("Hello")
                Text("World")
            }
            .environment(\.dynamicTypeSize, .large)
            
            HVStack(useVStack: true, alignment: .leading) {
                Text("Hello")
                Text("World")
            }
            .environment(\.dynamicTypeSize, .accessibility2)
        }
        .previewLayout(.sizeThatFits)
    }
}
