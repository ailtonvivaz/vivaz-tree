//
//  Card.swift
//  VivazTree
//
//  Created by Ailton Vieira Pinto Filho on 29/01/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import Foundation

//class Family: Hashable {
//    var name: String
//    var members: Set<Family>
//    private(set) var parents: Family?
//    private(set) var children: Set<Family>
//
//    init(name: String) {
//        self.name = name
//        self.parents = nil
//        self.children = []
//    }
//
//    func add(child: Family) {
//        child.parents = self
//        children.insert(child)
//    }
//
//    static func == (lhs: Family, rhs: Family) -> Bool {
//        lhs.name == rhs.name
//    }
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(name)
//    }
//}

struct Card {
    var image: String
    var name: String = ""
    var age: Int = 0
    var kinShip: String = ""
}
