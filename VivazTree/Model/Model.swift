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

    let allPeople: Set<Person>

    private init() {
        let person = Person.Builder(name: "Ailton")
            .imageName("ailton")
            .birthdate(.from(year: 1949, month: 11, day: 9))
            .kinship("Pai")
            .marry(with: Person.Builder(name: "Salete")
                .imageName("salete")
                .kinship("Mãe")
                .birthdate(.from(year: 1965, month: 10, day: 28))
                .build(), children: [
                    Person.Builder(name: "Claudeires")
                        .imageName("nena")
                        .kinship("Irmã")
                        .birthdate(.from(year: 1984, month: 9, day: 26))
                        .marry(children: [
                            Person.Builder(name: "Taina Crislaine")
                                .imageName("taina")
                                .kinship("Sobrinha")
                                .birthdate(.from(year: 1999, month: 2, day: 14))
                                .marry(with: Person.Builder(name: "Christian")
                                    .imageName("christian")
                                    .kinship("Cunhado")
                                    .build(), children: [
                                        Person.Builder(name: "Lorena")
                                            .imageName("lorena")
                                            .kinship("Sobrinha-Neta")
                                            .birthdate(.from(year: 2018, month: 4, day: 16))
                                            .build(),
                                    ])
                                .build(),
                        ])
                        .marry(children: [
                            Person.Builder(name: "Grayce Rosa")
                                .imageName("grayce")
                                .kinship("Sobrinha")
                                .birthdate(.from(year: 2000, month: 5, day: 27))
                                .marry(children: [
                                    Person.Builder(name: "Heloísa")
                                        .imageName("heloisa")
                                        .kinship("Sobrinha-Neta")
                                        .birthdate(.from(year: 2018, month: 9, day: 27))
                                        .build(),
                                ])
                                .build(),
                            Person.Builder(name: "Kasyllen Karla")
                                .imageName("kasy")
                                .kinship("Sobrinha")
                                .birthdate(.from(year: 2001, month: 11, day: 13))
                                .build(),
                            Person.Builder(name: "Wagner Júnior")
                                .imageName("juninho")
                                .kinship("Sobrinho")
                                .birthdate(.from(year: 2002, month: 10, day: 18))
                                .build(),
                            Person.Builder(name: "Gustavo")
                                .imageName("gustavo")
                                .kinship("Sobrinho")
                                .birthdate(.from(year: 2014, month: 8, day: 17))
                                .build(),
                        ])
                        .marry(with: Person.Builder(name: "Alexandre")
                            .imageName("xande")
                            .kinship("Cunhado")
                            .build(), children: [
                                Person.Builder(name: "Henrique")
                                    .imageName("henrique")
                                    .kinship("Sobrinho")
                                    .birthdate(.from(year: 2019, month: 12, day: 14))
                                    .build(),
                            ])
                        .build(),
                    Person.Builder(name: "Clailton")
                        .imageName("clailton")
                        .kinship("Irmão")
                        .birthdate(.from(year: 1986, month: 6, day: 20))
                        .marry(children: [
                            Person.Builder(name: "Kayky")
                                .imageName("kayky")
                                .kinship("Sobrinho")
                                .birthdate(.from(year: 2007, month: 7, day: 15))
                                .build(),
                        ])
                        .marry(children: [
                            Person.Builder(name: "Murilo")
                                .imageName("murilo")
                                .kinship("Sobrinho")
                                .birthdate(.from(year: 2008, month: 3, day: 21))
                                .build(),
                        ])
                        .marry(with: Person.Builder(name: "Jaqueline")
                            .imageName("jaque")
                            .kinship("Cunhada")
                            .build(), children: [
                                Person.Builder(name: "Clailton Júnior")
                                    .imageName("clailtinho")
                                    .kinship("Sobrinho")
                                    .birthdate(.from(year: 2016, month: 6, day: 24))
                                    .build(),
                            ])
                        .build(),
                    Person.Builder(name: "Clodoaldo")
                        .imageName("clo")
                        .kinship("Irmão")
                        .birthdate(.from(year: 1988, month: 5, day: 6))
                        .marry(with: Person.Builder(name: "Eula")
                            .imageName("eula")
                            .kinship("Cunhada")
                            .build(), children: [
                                Person.Builder(name: "Wesllen")
                                    .imageName("wesllen")
                                    .kinship("Sobrinho")
                                    .birthdate(.from(year: 2011, month: 3, day: 31))
                                    .build(),
                                Person.Builder(name: "Wellignton")
                                    .imageName("wellignton")
                                    .kinship("Sobrinho")
                                    .birthdate(.from(year: 2015, month: 7, day: 12))
                                    .build(),
                            ])
                        .build(),
                    Person.Builder(name: "Lilian")
                        .imageName("lilian")
                        .kinship("Irmã")
                        .birthdate(.from(year: 1990, month: 5, day: 7))
                        .marry(with: Person.Builder(name: "Saulo")
                            .imageName("saulo")
                            .kinship("Cunhado")
                            .build(), children: [
                                Person.Builder(name: "Lara")
                                    .imageName("lara")
                                    .kinship("Sobrinha")
                                    .birthdate(.from(year: 1018, month: 8, day: 6))
                                    .build(),
                            ])
                        .build(),
                    Person.Builder(name: "William")
                        .imageName("william")
                        .kinship("Irmão")
                        .birthdate(.from(year: 1990, month: 5, day: 7))
                        .marry(with: Person.Builder(name: "Geolsiane")
                            .imageName("geolsiane")
                            .kinship("Cunhada")
                            .build(), children: [
                                Person.Builder(name: "William Júnior")
                                    .imageName("willinha")
                                    .kinship("Sobrinho")
                                    .birthdate(.from(year: 2016, month: 1, day: 27))
                                    .build(),
                                Person.Builder(name: "Wictor")
                                    .imageName("wictor")
                                    .kinship("Sobrinho")
                                    .birthdate(.from(year: 2020, month: 1, day: 2))
                                    .build(),
                            ])
                        .build(),
                    Person.Builder(name: "Claudemir")
                        .imageName("nenem")
                        .kinship("Irmão")
                        .birthdate(.from(year: 1992, month: 1, day: 17))
                        .marry(with: Person.Builder(name: "Carla")
                            .imageName("carla")
                            .kinship("Cunhada")
                            .build(), children: [
                                Person.Builder(name: "Maria Júlia")
                                    .imageName("maju")
                                    .kinship("Sobrinha")
                                    .birthdate(.from(year: 2014, month: 10, day: 9))
                                    .build(),
                                Person.Builder(name: "Arthur")
                                    .imageName("arthur")
                                    .kinship("Sobrinho")
                                    .birthdate(.from(year: 2019, month: 3, day: 23))
                                    .build(),
                            ])
                        .build(),
                    Person.Builder(name: "Ailton Filho")
                        .imageName("ailton_filho")
                        .kinship("Eu")
                        .birthdate(.from(year: 1996, month: 9, day: 17))
                        .marry(with: Person.Builder(name: "Miguel")
                            .imageName("miguel")
                            .kinship("Marido")
                            .birthdate(.from(year: 1982, month: 9, day: 12))
                            .marry(children: [
                                Person.Builder(name: "Lupita")
                                    .imageName("lupita")
                                    .kinship("Filha")
                                    .birthdate(.from(year: 2014, month: 11, day: 30))
                                    .build(),
                                Person.Builder(name: "Boris")
                                    .imageName("boris")
                                    .kinship("Filho")
                                    .birthdate(.from(year: 2014, month: 11, day: 30))
                                    .build(),
                            ])
                            .build(), children: [
                                Person.Builder(name: "Toddy")
                                    .imageName("toddy")
                                    .kinship("Filho")
                                    .birthdate(.from(year: 2016, month: 8, day: 12))
                                    .build(),
                            ])
                        .build(),
                ])
            .build()

        self.person = person

//        person.
//        print(person.allPeople)

        self.allPeople = []
    }
}
