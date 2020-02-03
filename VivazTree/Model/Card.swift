//
//  Card.swift
//  VivazTree
//
//  Created by Ailton Vieira Pinto Filho on 29/01/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import Foundation

struct Card {
    static var sample: Card { Card(image: "eu") }

    var image: String
    var title: String = ""
    var description: String = ""
    var tree: Bool = false
    
    var videoName: String {
        String(image.split(separator: "/")[1])
    }
}
