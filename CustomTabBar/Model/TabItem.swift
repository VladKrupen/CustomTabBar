//
//  TabItem.swift
//  CustomTabBar
//
//  Created by Vlad on 12.08.24.
//

import Foundation

struct TabItem {
    let index: Int
    let tabText: String
    let tabImage: String
}

extension TabItem {
    static var tabItems: [TabItem] = [
        TabItem(index: 0, tabText: "Home", tabImage: "house"),
        TabItem(index: 1, tabText: "Chat", tabImage: "message"),
        TabItem(index: 2, tabText: "Profile", tabImage: "person")
    ]
}
