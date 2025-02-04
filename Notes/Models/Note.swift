//
//  Note.swift
//  Notes
//
//  Created by Alfonso Gonzalez Miramontes on 03/02/25.
//

import Foundation
import SwiftData
import UIKit

@Model
final class Note{
    var id = UUID().uuidString
    var title: String
    var body: String
    var date: Date = Date()
    @Attribute(.transformable(by: UIColorValueTransformer.self)) var color: UIColor
    @Transient var allowsHitTesting: Bool = true
    
    init(title: String, body: String, color: UIColor){
        self.title = title
        self.body = body
        self.color = color
    }
    
}
