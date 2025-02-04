//
//  String+Extension.swift
//  Notes
//
//  Created by Alfonso Gonzalez Miramontes on 03/02/25.
//

import Foundation

extension String {
    var isEmptyOrWhitespaces: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
