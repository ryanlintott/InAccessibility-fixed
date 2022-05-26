//
//  StockName.swift
//  InAccessibility
//
//  Created by Ryan Lintott on 2022-05-26.
//

import SwiftUI

/// This view was added to make StockCell less complex
struct StockName: View {
    let stock: Stock
//    let showInfo: () -> Void
    @State var isShowingInfo = false
    let spacing = 4.0
    
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    /// One label is used for the name content. The period helps with VoiceOver pauses between this and other combined content in the cell.
    var accessibilityLabel: Text {
        Text(stock.name)
        + Text(stock.shortName.lowercased()).speechSpellsOutCharacters()
        + Text(stock.favorite ? "Favourite." : ".")
    }
                                
    var useVStack: Bool {
        dynamicTypeSize > .accessibility4 && horizontalSizeClass == .compact
    }
    
    func showInfo() {
        isShowingInfo = true
    }
    
    var alertMessage: Text {
        Text("The stock price for \(stock.name) (")
        + Text(stock.shortName)
            .accessibilityLabel(stock.shortName.lowercased())
            .speechSpellsOutCharacters()
        + Text(") is ")
        + Text(String(format: "%.2f",stock.stockPrice))
        + Text(".")
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            HVStack(useVStack: useVStack, alignment: .leading, spacing: spacing) {
                Text(stock.shortName)
                    .font(.headline)
                
                HStack(spacing: spacing) {
                    Button(action: showInfo) {
                        Image(systemName: "info.circle.fill")
                            .font(.callout)
                    }
                    .buttonStyle(.plain)
                    
                    if stock.favorite {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        /// As this image is just decorative removing the trait removes the ability to explore this image.
                            .accessibilityRemoveTraits(.isImage)
                            .accessibilityIgnoresInvertColors()
                    }
                }
            }
            
            Text(stock.name)
                .font(.caption2)
                .opacity(0.5)
        }
        /// All info in the VStack is ignored for accessibility and replaced by the label and action below.
        .accessibilityElement(children: .ignore)
        .accessibilityAction(named: "Info", showInfo)
        .accessibilityLabel(accessibilityLabel)
        .alert(isPresented: $isShowingInfo) {
            Alert(title: Text(stock.name), message: alertMessage, dismissButton: .cancel())
        }
    }
}

struct StockName_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StockName(stock: .example)
            
            StockName(stock: .example)
                .environment(\.dynamicTypeSize, .accessibility4)
            
            StockName(stock: .example)
                .environment(\.dynamicTypeSize, .accessibility5)
        }
    }
}
