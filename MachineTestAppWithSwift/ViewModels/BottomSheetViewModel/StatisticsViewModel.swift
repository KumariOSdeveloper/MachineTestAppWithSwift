//
//  StatisticsViewModel.swift
//  MachineTestAppWithSwift
//
//  Created by Mahesh Kumar on 31/08/24.
//

import Foundation

class StatisticsViewModel: ObservableObject {
    // The available lists with items to analyze
    @Published var lists: [String: [String]] = [
        "List 1": ["apple", "banana", "orange", "blueberry"],
        "List 2": ["strawberry", "kiwi", "grape", "melon"],
        "List 3": ["peach", "plum", "nectarine", "pear"]
    ]
    
    // The currently selected list
    @Published var selectedList: String = "List 1" {
        didSet {
            calculateStatistics()
        }
    }
    
    // The items in the selected list
    public var items: [String] {
        lists[selectedList] ?? []
    }
    
    // The most frequent characters and their counts
    @Published var topCharacters: [Character: Int] = [:]
    
    /// Calculates statistics for the currently selected list.
    func calculateStatistics() {
        var characterCount: [Character: Int] = [:]

        for item in items {
            for char in item {
                characterCount[char, default: 0] += 1
            }
        }

        // Get the top 3 most frequent characters
        topCharacters = characterCount
            .sorted { $0.value > $1.value }
            .prefix(3)
            .reduce(into: [Character: Int]()) { $0[$1.key] = $1.value }
    }
    
    /// Updates the selected list and recalculates statistics.
    func selectList(_ listName: String) {
        guard lists.keys.contains(listName) else { return }
        selectedList = listName
    }
}

