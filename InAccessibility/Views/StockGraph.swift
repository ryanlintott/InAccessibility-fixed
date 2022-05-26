//
//  StockGraph.swift
//  InAccessibility
//
//  Created by Jordi Bruin on 19/05/2022.
//

import SwiftUI

/// StockPoint is ExpressibleByIntegerLiteral for easy init from Int values
/// Also made comparable so a max can be found
struct StockPoint: Identifiable, Hashable, ExpressibleByIntegerLiteral, Comparable {
    static func < (lhs: StockPoint, rhs: StockPoint) -> Bool {
        lhs.value < rhs.value
    }
    
    let id = UUID()
    let value: Int
    
    init(integerLiteral value: Int) {
        self.value = value
    }
}

struct StockGraph: View {
    
    let stock: Stock
    
    /// Points changed to a new type so it can be identifiable
    let points: [StockPoint] = [10, 20, 30, 40, 30, 25, 44]
    
    /// Size will scale with font size
    @ScaledMetric(relativeTo: .title) var size: CGFloat = 100
    @State var bigCircles = false
    @State var showDots = false
    
    @Environment(\.stockColors) var stockColors
    
    @Environment(\.legibilityWeight) var legibilityWeight
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    
    var spacing: CGFloat {
        size * 0.04
    }
    
    func pointValue(_ point: StockPoint) -> CGFloat {
        let relativeValue = (CGFloat(point.value) / CGFloat(points.max()?.value ?? point.value))
        
        return size * relativeValue * (stock.goingUp ? 1 : -1) * 0.25
    }
    
    var color: Color {
        stock.goingUp ? stockColors.up : stockColors.down
    }
    
    func action() {
        bigCircles.toggle()
    }
    
    @ViewBuilder
    var pointShape: some View {
        /// Stocks going down will show with an outline if differentiate without color is active
        if differentiateWithoutColor && !stock.goingUp {
            Circle()
                .strokeBorder(lineWidth: 2)
        } else {
            Circle()
        }
    }
    
    var dotOffset: CGFloat {
        /// Slide up offset for animation is removed if reduce motion is on.
        if reduceMotion { return .zero }
        return showDots ? 0 : size * 0.12
    }
    
    var dotSize: CGFloat {
        if legibilityWeight == .bold {
            return bigCircles ? 1.2 : 0.7
        } else {
            return bigCircles ? 1 : 0.5
        }
    }
    
    /// Background Opacity is removed if reduce transparency is on
    var backgroundOpacity: CGFloat {
        reduceTransparency ? 1 : 0.9
    }
    
    /// Summary of the chart with a general direction.
    var accessibilityLabel: String {
        "Chart with values going \(stock.goingUp ? "up" : "down")."
    }
    
    /// All the points on the chart are read as the value.
    var accessibilityValue: String {
        points
            .map { String($0.value) }
            .joined(separator: ", ")
    }
    
    var body: some View {
        Color.black.opacity(backgroundOpacity)
            .cornerRadius(7)
            .overlay(
                HStack(spacing: spacing) {
                    /// Points made identifiable as multiple values were the same causing duplicate ids with \.self
                    ForEach(points) { point in
                        pointShape
                        /// Size removed as it's now based on the size of the frame and spacing. Scale effect is used for big circles
                            .scaleEffect(dotSize)
                            .aspectRatio(1, contentMode: .fit)
                            .foregroundColor(color)
                            .offset(y: -pointValue(point))
                            .animation(.default, value: bigCircles)
                    }
                }
                    .padding(size * 0.1)
                    .opacity(showDots ? 1 : 0)
                    .offset(y: dotOffset)
                    .animation(.default, value: showDots)
                , alignment: stock.goingUp ? .bottom : .top
            )
            .clipped()
            .aspectRatio(2, contentMode: .fit)
            .frame(width: size)
            .onAppear {
                showDots = true
            }
            .onTapGesture(perform: action)
        /// Inverting colours is often used to make the screen darker. As this image is already dark I'm disabling inverting to keep the color scheme
            .accessibilityIgnoresInvertColors()
        /// Elements in the group above are ignored and new values are added
            .accessibilityElement(children: .ignore)
            .accessibilityAddTraits(.isButton)
            .accessibilityLabel(accessibilityLabel)
            .accessibilityValue(accessibilityValue)
        /// Hint added so it's clear what the button does.
            .accessibilityHint("Toggles chart point size.")
    }
}

struct StockGraph_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StockGraph(stock: .example)
            
            StockGraph(stock: .example)
                .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
            
            StockGraph(stock: .example)
                .environment(\.sizeCategory, .extraSmall)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
