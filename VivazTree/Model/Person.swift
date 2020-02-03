//
//  Person.swift
//  VivazTree
//
//  Created by Ailton Vieira Pinto Filho on 30/01/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import Foundation

class Person: Equatable, Hashable {
    private let id = UUID()

    private(set) var name: String
    private(set) var birthdate: Date
    
    private(set) var imageName: String? = nil

    var parents: Family?
    var families: Set<Family> = []

    var familiesSorted: [Family] { families.sorted(by: { $0.order < $1.order }) }

    var familiesCount: Int { families.count }

    var partnersCount: Int {
        Set(families.reduce([]) { $0 + Array([self] + $1.partners) }).count
    }

    init(name: String, birthdate: Date = Date()) {
        self.name = name
        self.birthdate = birthdate
    }

    func marry(with person: Person) -> Family {
        marry(with: Set([person]))
    }

    func marry(with partners: Set<Person> = []) -> Family {
        let newPartners = Set(partners + [self])

        for person in newPartners {
            if let family = person.families.first(where: { $0.partners == newPartners }) {
                add(family: family)
                return family
            }
        }

        let family = Family(partners: newPartners, order: families.count)
        add(family: family)
        return family
    }

    private func add(family: Family) {
        families.insert(family)

        for partner in family.partners {
            if !partner.families.contains(family) {
                _ = partner.marry(with: family.partners)
            }
        }
    }

    func hasChildrenWithout(person: Person) -> Bool {
        !families.filter { !$0.partners.contains(person) }.isEmpty
    }

    static func == (lhs: Person, rhs: Person) -> Bool { lhs.id == rhs.id }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    class Builder {
        private var person: Person

        init(name: String) {
            self.person = Person(name: name)
        }

        func birthdate(_ date: Date) -> Builder {
            person.birthdate = date
            return self
        }
        
        func imageName(_ name: String) -> Builder {
            person.imageName = name
            return self
        }

        func marry(children: Set<Person>) -> Builder {
            let family = person.marry()
            children.forEach(family.add)
            return self
        }

        func marry(with name: String, children: Set<Person>) -> Builder {
            marry(with: Person.Builder(name: name).build(), children: children)
        }

        func marry(with person: Person, children: Set<Person>) -> Builder {
            let family = self.person.marry(with: person)
            children.forEach(family.add)
            return self
        }

        func build() -> Person { person }
    }
}
