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
    
    let order: Int
    private(set) var partners: Set<Person>
    private(set) var children: Set<Person> = []
    
    var partnersCount: Int { partners.count }
    var childrenCount: Int { children.count }
    
    var eldest: Person? { childrenSorted.first }
    var youngest: Person? { childrenSorted.last }
    
    var childrenSorted: [Person] {
        children.sorted(by: { $0.birthdate < $1.birthdate })
    }
    
    var allPeople: Set<Person> {
        Set(Array(children.reduce([]) { $0 + Array($1.allPeople) }))
    }
    
    init(partners: Set<Person>, order: Int) {
        self.order = order
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
