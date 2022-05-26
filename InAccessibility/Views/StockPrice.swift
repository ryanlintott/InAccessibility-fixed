//
//  StockPrice.swift
//  InAccessibility
//
//  Created by Jordi Bruin on 19/05/2022.
//

import SwiftUI

struct StockPrice: View {
    
    let stock: Stock
    
    @Environment(\.stockColors) var stockColors
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    
    /// Stoke price and change are moved into parameters so they can also be used in the accessibility value.
    var stockPrice: String {
        String(format: "%.2f",stock.stockPrice)
    }
    
    var stockChange: String {
        /// + sign added to positive values
        (stock.change > 0 ? "+" : "") +
        String(format: "%.2f",stock.change)
    }
    
    /// Accessibility value summarizes the stock price information in a single value.
    /// The punctuation helps suggest pauses to VoiceOver so its easier to listen to.
    /// Instead of positive and negative values, absolute value is used and up/down is added to the text.
    var accessibilityValue: Text {
        Text(stockPrice)
        + Text(". ")
        + Text(stock.goingUp ? "Up " : "Down ")
        + Text(String(format: "%.2f", abs(stock.change)))
        + Text("points.")
    }
    
    var stockChangeBackground: some View {
        Group {
            if differentiateWithoutColor {
                RoundedRectangle(cornerRadius: 6)
                    .strokeBorder(lineWidth: 2)
            } else {
                RoundedRectangle(cornerRadius: 6)
            }
        }
        .foregroundColor(stock.goingUp ? stockColors.up : stockColors.down)
    }
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 2) {
            Text(stockPrice)
                .lineLimit(1)
            
            Text(stockChange)
                .font(.caption)
                .bold()
                .lineLimit(1)
                .padding(4)
                .background(stockChangeBackground)
                .foregroundColor(.white)
            /// Inverting is disabled to ensure color scheme stays the same.
                .accessibilityIgnoresInvertColors()
        }
        /// Ignores child accessibility elements and uses a custom label
        .accessibilityElement(children: .ignore)
        .accessibilityValue(accessibilityValue)
    }
}


struct StockPrice_Previews: PreviewProvider {
    static var previews: some View {
        StockPrice(stock: .example)
    }
}
