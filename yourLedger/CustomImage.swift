//
//  CustomImage.swift
//  yourLedger
//
//  Created by Sonal on 04/06/25.
//

import SwiftUI

enum ImageName: String {
    case square
    case star
    case plus
    case pluscirclefill = "plus.circle.fill"
    case checkmarksquarefill = "checkmark.square.fill"
    // Add more as needed
}

enum ImageKind {
    case asset(ImageName)
    case system(ImageName)
}

extension Image {
    static func getImg(_ imageKind: ImageKind) -> Image {
        switch imageKind {
        case .asset(let name):
            return Image(name.rawValue)
        case .system(let name):
            return Image(systemName: name.rawValue)
        }
    }
}
