//
//  Family.swift
//  VivazTree
//
//  Created by Ailton Vieira Pinto Filho on 30/01/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import Foundation

class Family: Equatable, Hashable {
    private let id = UUID()
    
    private(set) var partners: Set<Person>
    private(set) var children: Set<Person> = []
    
    var partnersCount: Int { partners.count }
    var childrenCount: Int { children.count }
    
    var childrenWidth: Int {
        var partnersChildren = 0
        if partners.count > 1 {
            partnersChildren = partners.reduce(0) { $0 + $1.families.filter { $0.partners.count == 1 }.reduce(0) { $0 + $1.childrenWidth } }
        }
        return children.reduce(0) { $0 + $1.peopleWidth } + partnersChildren
    }
    
    init(partners: Set<Person>) {
        self.partners = partners
    }
    
    func add(child: Person) {
        child.parents = self
        children.insert(child)
    }
    
    static func == (lhs: Family, rhs: Family) -> Bool { lhs.id == rhs.id }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
