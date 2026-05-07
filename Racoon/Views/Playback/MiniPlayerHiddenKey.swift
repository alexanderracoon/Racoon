//
//  MiniPlayerHiddenKey.swift
//  Racoon
//
//  Created by Александр Переславцев on 06.05.2026.
//
import SwiftUI


///Ключ, передающий значение вверх по иерархии View
struct MiniPlayerHiddenKey: PreferenceKey {
    static var defaultValue = false
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = value || nextValue()
    }
}
