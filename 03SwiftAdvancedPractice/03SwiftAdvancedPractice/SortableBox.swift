//
//  SortableBox.swift
//  03SwiftAdvancedPractice
//
//  Created by 지영 on 6/9/25.
//

import Foundation

struct SortableBox<T: Comparable> {
    var items: [T] = []
    
    mutating func sortItems() {
        guard !items.isEmpty else {
            print("정렬할 데이터가 없습니다.")
            return
        }
        items.sort(by: <)
        print(items)
    }
}

func testSortableBox() {
    var sortableBox = SortableBox<Int>()
    sortableBox.items = [2, 9, 6, 5]
    sortableBox.sortItems()
}


