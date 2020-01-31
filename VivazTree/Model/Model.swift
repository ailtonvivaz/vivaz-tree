//
//  Model.swift
//  VivazTree
//
//  Created by Ailton Vieira Pinto Filho on 30/01/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import Foundation

class Model {
    static var shared = Model()

    private(set) var family: Family

    private init() {
        let person = Person.Builder(name: "Ailton")
            .marry(with: "Salete", children: [
                Person.Builder(name: "Claudeires")
                    .marry(children: [
                        Person.Builder(name: "Taina Crislaine")
                            .marry(with: "Christian", children: [
                                Person.Builder(name: "Lorena").build(),
                            ])
                            .build(),
                    ])
                    .marry(with: "Wagner", children: [
                        Person.Builder(name: "Grayce Rosa")
                            .marry(children: [
                                Person.Builder(name: "Heloísa").build(),
                            ])
                            .build(),
                        Person.Builder(name: "Kasyllen Karla").build(),
                        Person.Builder(name: "Wagner Júnior").build(),
                        Person.Builder(name: "Gustavo").build(),
                    ])
                    .marry(with: "Alexandre", children: [
                        Person.Builder(name: "Henrique").build(),
                    ])
                    .build(),
                Person.Builder(name: "Clailton")
                    .marry(children: [
                        Person.Builder(name: "Kayky").build(),
                    ])
                    .marry(children: [
                        Person.Builder(name: "Murilo").build(),
                    ])
                    .marry(with: "Jaqueline", children: [
                        Person.Builder(name: "Clailton Júnior").build(),
                    ])
                    .build(),
                Person.Builder(name: "Clodoaldo")
                    .marry(with: "Eula", children: [
                        Person.Builder(name: "Wesllen").build(),
                        Person.Builder(name: "Wellignton").build(),
                    ])
                    .build(),
                Person.Builder(name: "Lilian")
                    .marry(with: "Saulo", children: [
                        Person.Builder(name: "Lara").build(),
                    ])
                    .build(),
                Person.Builder(name: "William")
                    .marry(with: "Geolsiane", children: [
                        Person.Builder(name: "William Júnior").build(),
                        Person.Builder(name: "Wictor").build(),
                    ])
                    .build(),
                Person.Builder(name: "Claudemir")
                    .marry(with: "Carla", children: [
                        Person.Builder(name: "Maria Júlia").build(),
                        Person.Builder(name: "Arthur").build(),
                    ])
                    .build(),
                Person.Builder(name: "Ailton Filho")
                    .marry(with: Person.Builder(name: "Miguel")
                        .marry(children: [
                            Person.Builder(name: "Lupita").build(),
                            Person.Builder(name: "Boris").build(),
                        ])
                        .build(), children: [
                            Person.Builder(name: "Toddy").build(),
                        ])
                    .build(),
            ])
            .build()

        self.family = person.families.first!
    }
}
