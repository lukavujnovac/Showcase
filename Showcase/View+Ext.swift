//
//  View+Ext.swift
//  Showcase
//
//  Created by Luka Vujnovac on 23.12.2023..
//

import SwiftUI

extension View {
    @ViewBuilder
    func showCase(
        order: Int,
        title: String,
        cornerRadius: CGFloat,
        style: RoundedCornerStyle = .continuous,
        scale: CGFloat = 1
    ) -> some View {
        self
            .anchorPreference(key: HighlightAnchorKey.self, value: .bounds) { anchor in
                let highlight = Highlight(anchor: anchor, title: title, cornerRadius: cornerRadius, style: style, scale: scale)
                return [order: highlight]
            }
    }
}


extension View {
    @ViewBuilder
    func reverseMask<Content: View>(
        alignment: Alignment = .topLeading,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self
            .mask {
                Rectangle()
                    .overlay(alignment: .topLeading) {
                        content()
                            .blendMode(.destinationOut)
                    }
            }
    }
}

extension View {
    func showcaseRoot(
        showHighlights: Bool = true,
        onFinished: @escaping () -> Void
    ) -> some View {
        self
            .modifier(ShowCaseRoot(showHighlights: showHighlights, onFinished: onFinished))
    }
}
