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

    private(set) var person: Person

    private init() {
        let person = Person.Builder(name: "Ailton")
            .birthdate(.from(year: 1949, month: 11, day: 9))
            .marry(with: Person.Builder(name: "Salete")
                .birthdate(.from(year: 1965, month: 10, day: 28))
                .build(), children: [
                    Person.Builder(name: "Claudeires")
                        .birthdate(.from(year: 1984, month: 9, day: 26))
                        .marry(children: [
                            Person.Builder(name: "Taina Crislaine")
                                .birthdate(.from(year: 1999, month: 2, day: 14))
                                .marry(with: "Christian", children: [
                                    Person.Builder(name: "Lorena")
                                        .birthdate(.from(year: 2018, month: 4, day: 16))
                                        .build(),
                                ])
                                .build(),
                        ])
                        .marry(children: [
                            Person.Builder(name: "Grayce Rosa")
                                .birthdate(.from(year: 2000, month: 5, day: 27))
                                .marry(children: [
                                    Person.Builder(name: "Heloísa").build(),
                                ])
                                .build(),
                            Person.Builder(name: "Kasyllen Karla")
                                .birthdate(.from(year: 2001, month: 11, day: 13))
                                .build(),
                            Person.Builder(name: "Wagner Júnior")
                                .birthdate(.from(year: 2002, month: 10, day: 18))
                                .build(),
                            Person.Builder(name: "Gustavo")
                                .birthdate(.from(year: 2014, month: 8, day: 17))
                                .build(),
                        ])
                        .marry(with: "Alexandre", children: [
                            Person.Builder(name: "Henrique")
                                .build(),
                        ])
                        .build(),
                    Person.Builder(name: "Clailton")
                        .birthdate(.from(year: 1986, month: 6, day: 20))
                        .marry(children: [
                            Person.Builder(name: "Kayky")
                                .build(),
                        ])
                        .marry(children: [
                            Person.Builder(name: "Murilo")
                                .build(),
                        ])
                        .marry(with: "Jaqueline", children: [
                            Person.Builder(name: "Clailton Júnior")
                                .build(),
                        ])
                        .build(),
                    Person.Builder(name: "Clodoaldo")
                        .birthdate(.from(year: 1988, month: 5, day: 6))
                        .marry(with: "Eula", children: [
                            Person.Builder(name: "Wesllen")
                                .build(),
                            Person.Builder(name: "Wellignton")
                                .build(),
                        ])
                        .build(),
                    Person.Builder(name: "Lilian")
                        .birthdate(.from(year: 1990, month: 5, day: 7))
                        .marry(with: "Saulo", children: [
                            Person.Builder(name: "Lara")
                                .birthdate(.from(year: 1018, month: 8, day: 6))
                                .build(),
                        ])
                        .build(),
                    Person.Builder(name: "William")
                        .birthdate(.from(year: 1990, month: 5, day: 7))
                        .marry(with: "Geolsiane", children: [
                            Person.Builder(name: "William Júnior")
                                .birthdate(.from(year: 2016, month: 1, day: 27))
                                .build(),
                            Person.Builder(name: "Wictor")
                                .birthdate(.from(year: 2020, month: 1, day: 2))
                                .build(),
                        ])
                        .build(),
                    Person.Builder(name: "Claudemir")
                        .birthdate(.from(year: 1992, month: 1, day: 17))
                        .marry(with: "Carla", children: [
                            Person.Builder(name: "Maria Júlia")
                                .birthdate(.from(year: 2014, month: 10, day: 9))
                                .build(),
                            Person.Builder(name: "Arthur")
                                .birthdate(.from(year: 2019, month: 3, day: 23))
                                .build(),
                        ])
                        .build(),
                    Person.Builder(name: "Ailton Filho")
                        .birthdate(.from(year: 1996, month: 9, day: 17))
                        .marry(with: Person.Builder(name: "Miguel")
                            .birthdate(.from(year: 1982, month: 9, day: 12))
                            .marry(children: [
                                Person.Builder(name: "Lupita")
                                    .birthdate(.from(year: 2014, month: 11, day: 30))
                                    .build(),
                                Person.Builder(name: "Boris")
                                    .birthdate(.from(year: 2014, month: 11, day: 30))
                                    .build(),
                            ])
                            .build(), children: [
                                Person.Builder(name: "Toddy")
                                    .birthdate(.from(year: 2016, month: 8, day: 12))
                                    .build(),
                            ])
                        .build(),
                ])
            .build()

        self.person = person
        print(person.peopleWidth)
    }
}
