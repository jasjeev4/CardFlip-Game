//
//  CardFlipModel.swift
//  CardFlip
//
//  Created by Jasjeev on 8/5/21.
//

import Foundation

struct CardGame {
    var rows: Int
    var columns: Int
    
//    var cardImages: [[String]]
//    var cardStatus: [[Bool]]
}

struct Card: Hashable {
    var id: Int
    var frontImage: String
    var displayImage: String
    var showing: Bool
}
