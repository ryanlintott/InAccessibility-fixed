//
//  DetailView.swift
//  InAccessibility
//
//  Created by Jordi Bruin on 19/05/2022.
//

import SwiftUI

enum AlertItem: String, Identifiable {
    case share
    case favorite
    
    var id: String { self.rawValue }
}

struct DetailView: View {
    
    let stock: Stock
    @State var selectedAlertItem: AlertItem?
    
    /// Dynamic type size and horizontal size class are used to determine when there isn't enough horizontal space and we should use a VStack
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var useVStack: Bool {
        dynamicTypeSize > .accessibility1 && horizontalSizeClass == .compact
    }
    
    var body: some View {
        /// Got rid of the navigation view as it felt redundant
        VStack(alignment: .leading, spacing: 16) {
            ScrollView {
                companyInfo
                description
            }
            buttons
        }
        .padding()
        .alert(item: $selectedAlertItem, content: { item in
            if item == .share {
                return Alert(title: Text("Thanks for sharing!"))
            } else {
                return Alert(title: Text("Thanks for favoriting (but not really)!"))
            }
        })
    }
    
    var companyInfo: some View {
        HVStack(useVStack: useVStack, alignment: .trailing) {
            VStack(alignment: .leading) {
                Text("Company Name")
                    .font(.subheadline)
                /// Hid this and applied "Company name" as a hint
                    .accessibilityHidden(true)
                
                Text(stock.name)
                    .font(.title)
                    .bold()
                
                Text(stock.shortName)
                    .font(.caption)
                /// Changed the label to lowercased and set to read out characters so VoiceOver can read it better.
                    .accessibilityLabel(stock.shortName.lowercased())
                    .speechSpellsOutCharacters()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            /// Combined these accessibility elements into one so they are read together.
            .accessibilityElement(children: .combine)
            .accessibilityHint("Company Name")
            /// Header property added so it's easy to get back to the top.
            .accessibilityAddTraits(.isHeader)
            
            StockGraph(stock: stock)
        }
    }
    
    var description: some View {
        VStack(alignment: .leading) {
            Text("Company Description")
                .font(.subheadline)
            
            /// Scrollview added to account for long text on smaller devices.
            Text("This is a company that was founded at some point in time by some people with some ideas. The company makes products and they do other things as well. Some of these things go well, some don't. The company employs people, somewhere between 10 and 250.000. The exact amount is not currently available.")
        }
        /// Font changed from manual size to title2 for automatic dynamic type size.
        .font(.title2)
    }
    
    var buttons: some View {
        VStack {
            /// Changed from tap gesture to button for automatic accessibility features
            Button {
                selectedAlertItem = .share
            } label: {
                Text(dynamicTypeSize.isAccessibilitySize ? "Share" : "Tap to share")
                    .bold()
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(15)
            }
            
            Button {
                selectedAlertItem = .favorite
            } label: {
                Text("Favorite")
                    .bold()
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                ///  Changed text color to black as white on yellow is hard to read for most users.
                    .foregroundColor(.black)
                    .background(.yellow)
                    .cornerRadius(15)
            }
        }
        .buttonStyle(.plain)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DetailView(stock: .example)
            
            DetailView(stock: .example)
                .environment(\.dynamicTypeSize, .xxxLarge)
            
            DetailView(stock: .example)
                .environment(\.dynamicTypeSize, .accessibility5)
        }
    }
}
