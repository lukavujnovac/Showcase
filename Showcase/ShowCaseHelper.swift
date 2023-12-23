//
//  ShowCaseHelper.swift
//  Showcase
//
//  Created by Luka Vujnovac on 23.12.2023..
//

import SwiftUI

struct ShowCaseRoot: ViewModifier {
    @State private var highlightOrder: [Int] = []
    @State private var currentHighlight: Int = 0
    @State private var showView: Bool = true
    @State private var showTitle: Bool = false
    @Namespace private var animation
    
    var showHighlights: Bool
    var onFinished: () -> ()
    
    func body(content: Content) -> some View {
        content
            .onPreferenceChange(HighlightAnchorKey.self) { value in
                highlightOrder = Array(value.keys).sorted()
            }
            .overlayPreferenceValue(HighlightAnchorKey.self) { preferences in
                if highlightOrder.indices.contains(currentHighlight),
                   showHighlights,
                   showView,
                   let highlight = preferences[highlightOrder[currentHighlight]] {
                    highlightView(for: highlight)
                }
            }
    }
    
    @ViewBuilder
    func highlightView(for highlight: Highlight) -> some View {
        GeometryReader { proxy in
            let highlightRect = proxy[highlight.anchor]
            let safeArea = proxy.safeAreaInsets
            
            Rectangle()
                .fill(.black.opacity(0.5))
                .reverseMask {
                    Rectangle()
                        .matchedGeometryEffect(id: "Highlight", in: animation)
                        .frame(width: highlightRect.width + 5, height: highlightRect.height + 5)
                        .clipShape(RoundedRectangle(cornerRadius: highlight.cornerRadius, style: highlight.style))
                        .scaleEffect(highlight.scale)
                        .offset(x: highlightRect.minX - 2.5, y: highlightRect.minY + safeArea.top - 2.5)
                }
                .ignoresSafeArea()
                .onTapGesture {
                    if currentHighlight >= highlightOrder.count - 1 {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            showView = false
                        }
                        onFinished()
                    } else {
                        withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.7, blendDuration: 0.7)) {
                            showTitle = false
                            currentHighlight += 1
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) {
                            showTitle = true
                        }
                    }
                }
                .task {
                    showTitle = true
                }
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: highlightRect.width + 20, height: highlightRect.height + 20)
                .clipShape(RoundedRectangle(cornerRadius: highlight.cornerRadius, style: highlight.style))
                .popover(isPresented: $showTitle) {
                    Text(highlight.title)
                        .padding(.horizontal, 10)
                        .presentationCompactAdaptation(.popover)
                        .interactiveDismissDisabled()
                }
                .scaleEffect(highlight.scale)
                .offset(x: highlightRect.minX - 10, y: highlightRect.minY - 10)
        }
    }
}
