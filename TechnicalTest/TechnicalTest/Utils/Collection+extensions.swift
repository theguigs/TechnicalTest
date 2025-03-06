//
//  Collection+extensions.swift
//  TechnicalTest
//
//  Created by Guillaume Audinet on 06/03/2025.
//

extension Collection {
    /// Access elements by index if exists else return nil but not crash
    @inlinable public subscript (safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
