//
//  Collection+SafeSubscript.swift
//  ToDocu
//
//  Created by Vlad Katsubo on 13.07.23.
//

extension Collection {
    subscript(safe index: Index) -> Iterator.Element? {
        return index >= startIndex && index < endIndex ? self[index] : nil
    }
}
