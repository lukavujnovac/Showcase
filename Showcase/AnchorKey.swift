//
//  AnchorKey.swift
//  Showcase
//
//  Created by Luka Vujnovac on 23.12.2023..
//

import SwiftUI

struct HighlightAnchorKey: PreferenceKey {
    static var defaultValue: [Int: Highlight] = [:]
    
    static func reduce(value: inout [Int : Highlight], nextValue: () -> [Int : Highlight]) {
        value.merge(nextValue()) { $1 }
    }
}
