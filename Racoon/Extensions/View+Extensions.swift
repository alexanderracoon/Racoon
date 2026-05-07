//
//  View+Extensions.swift
//  Racoon
//
//  Created by Александр Переславцев on 06.05.2026.
//

import Foundation
import SwiftUI

extension View {
    func hideMiniPlayer(_ hidden: Bool = true) -> some View {
        preference(key: MiniPlayerHiddenKey.self, value: hidden)
    }
}
