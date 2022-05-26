//
//  StockCell.swift
//  InAccessibility
//
//  Created by Jordi Bruin on 19/05/2022.
//

import SwiftUI

struct StockCell: View {
    
    let stock: Stock
    
    let spacing = 4.0
    
    /// Dynamic type size and horizontal size class are used to determine when there isn't enough horizontal space and we should use a VStack
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    let maxHStackSize: DynamicTypeSize = .large
    var useVStackOverall: Bool {
        dynamicTypeSize > .large && horizontalSizeClass == .compact
    }
    var useVStackGraphPrice: Bool {
        dynamicTypeSize > .accessibility1 && horizontalSizeClass == .compact
    }
    
    var body: some View {
        /// Special stack used to toggle between HStack and VStack based on Boolean
        /// The alignment leading ensures the elements alight to the left in VStack mode.
        HVStack(useVStack: useVStackOverall, alignment: .leading, spacing: 0) {
            /// This view was created to pull out the logic used in StockCell
            StockName(stock: stock)
            
            /// Special stack used to toggle between HStack and VStack based on Boolean
            HVStack(useVStack: useVStackGraphPrice, alignment: .trailing, spacing: spacing) {
                StockGraph(stock: stock)
                /// Hidden as the genral up/down information is in the stock price. Chart info can be found in the details section.
                    .accessibilityHidden(true)
                
                StockPrice(stock: stock)
            }
            /// This ensures the content always sits on the right side of the frame in either the HStack or VStack
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 8))
        /// Accessibility elements are combined so the entire row is read as a single element.
        .accessibilityElement(children: .combine)
    }
}

struct StockCell_Previews: PreviewProvider {
    static var previews: some View {
        List {
            StockCell(stock: .favorites[0])
            
            StockCell(stock: .favorites[0])
                .environment(\.dynamicTypeSize, .accessibility1)
            
            StockCell(stock: .favorites[0])
                .environment(\.dynamicTypeSize, .accessibility5)
        }
        .environment(\.colorScheme, .dark)
    }
}
