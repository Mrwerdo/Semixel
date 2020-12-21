//
//  ToolType.swift
//  Semixel
//
//  Created by Andrew Thompson on 21/12/20.
//  Copyright © 2020 Andrew Thompson. All rights reserved.
//

import Foundation

enum ToolType: Equatable {
    case pencil
    case brush
    case shape
    case selection
    case none
    case undo
    case redo
    
    var iconName: String {
        switch self {
        case .brush:
            return "paintbrush"
        case .pencil:
            return "penciltip"
        case .redo:
            return "arrow.uturn.right"
        case .undo:
            return "arrow.uturn.left"
        case .shape:
            return "circle"
        case .selection:
            return "selection.pin.in.out"
        case .none:
            return "questionmark"
        }
    }
}
