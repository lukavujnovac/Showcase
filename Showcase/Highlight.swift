//
//  HighLight.swift
//  Showcase
//
//  Created by Luka Vujnovac on 23.12.2023..
//

import SwiftUI

struct Highlight: Identifiable, Equatable {
    var id: UUID = .init()
    var anchor: Anchor<CGRect>
    var title: String
    var cornerRadius: CGFloat
    var style: RoundedCornerStyle = .continuous
    var scale: CGFloat = 1
}
