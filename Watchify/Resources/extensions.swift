//
//  extensions.swift
//  Watchify
//
//  Created by User on 09/12/22.
//

import Foundation

extension String{
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
