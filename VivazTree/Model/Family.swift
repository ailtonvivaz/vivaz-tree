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
