//
//  StockColors.swift
//  InAccessibility
//
//  Created by Ryan Lintott on 2022-05-26.
//

import SwiftUI

enum StockColors: String, CaseIterable {
    case greenRed
    case redGreen
    case greenBlue
    case blueGreen
    
    var name: String {
        switch self {
        case .greenRed:
            return "Green/Red"
        case .redGreen:
            return "Red/Green"
        case .greenBlue:
            return "Green/Blue"
        case .blueGreen:
            return "Blue/Green"
        }
    }
    
    var up: Color {
        switch self {
        case .greenRed, .greenBlue:
            return .green
        case .redGreen:
            return .red
        case .blueGreen:
            return .blue
        }
    }
    
    var down: Color {
        switch self {
        case .greenRed:
            return .red
        case .greenBlue:
            return .blue
        case .redGreen, .blueGreen:
            return .green
        }
    }
    
    var text: Text {
        Text(name)
    }
    
    
    static let all: [Self] = [.greenRed, .redGreen, .greenBlue, .blueGreen]
}

private struct StockColorsKey: EnvironmentKey {
    static let defaultValue = StockColors.greenRed
}

extension EnvironmentValues {
    var stockColors: StockColors {
        get { self[StockColorsKey.self] }
        set { self[StockColorsKey.self] = newValue }
    }
}
