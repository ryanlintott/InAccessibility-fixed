//
//  ContentView.swift
//  InAccessibility
//
//  Created by Jordi Bruin on 19/05/2022.
//

import SwiftUI

struct MainView: View {
    
    @State var showDetailStock: Stock?
    @State var isShowingSettings: Bool = false
    @AppStorage("StockColors") var stockColors: StockColors = .greenRed
    
    func changeColors(to colors: StockColors) {
        stockColors = colors
    }
    
    var body: some View {
        NavigationView {
            List {
                favoriteStocksSection
                allStocksSection
            }
            .environment(\.stockColors, stockColors)
            .navigationTitle("Stocks")
            .toolbar {
                toolbarItems
            }
            .sheet(item: $showDetailStock) { stock in
                DetailView(stock: stock)
            }
            .actionSheet(isPresented: $isShowingSettings) {
                ActionSheet(
                    title: Text("Color Settings"),
                    message: Text("Choose color pair for up/down stock directions."),
                    buttons: StockColors.all.map { stockColors in
                            .default(stockColors.text) {
                                changeColors(to: stockColors)
                            }
                    } + [.cancel()]
                )
            }
        }
    }
    
    var favoriteStocksSection: some View {
        Section {
            ForEach(Stock.favorites) { stock in
                StockCell(stock: stock)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        showDetailStock = stock
                    }
            }
        } header: {
            HStack {
                Text("Favorite Stocks")
                Spacer()
                Button {
                    
                } label: {
                    Text("Tap for more")
                }
                
            }
        } footer: {
            Text("Favorite stocks are updated every 1 minute.")
        }
        
    }
    
    var allStocksSection: some View {
        Section {
            ForEach(Stock.all) { stock in
                StockCell(stock: stock)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        showDetailStock = stock
                    }
            }
        } header: {
            Text("All Stocks")
        }
    }
    
    var toolbarItems: some ToolbarContent {
        Group {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    isShowingSettings = true
                } label: {
                    Image(systemName: "gearshape.fill")
                    /// Without the label this image would just read as "gear" or similar
                        .accessibilityLabel(Text("Settings"))
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView()
                .previewInterfaceOrientation(.landscapeRight)
            
            MainView()
                .environment(\.dynamicTypeSize, .xxxLarge)
                .previewInterfaceOrientation(.landscapeLeft)
            
            MainView()
                .environment(\.dynamicTypeSize, .accessibility5)
        }
    }
}
