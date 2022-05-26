# InAccessibility
A SwiftUI app that's not very accessible (on purpose) now made accessible again!

This app is part of the [Accessibility](https://www.swiftuiseries.com/accessibility) event during the SwiftUI Series.

# Improvements
## Dynamic type
- Fonts all changed to system default versions of the matching sizes like `.title`, `.caption`, etc.
- Info graphic changed from custom image to SFSymbol (this also helps for legibility weight)
- SFSymbol images are sized by font size.
- Chart now scales with dynamic type using `@ScaledMetric`

## Size Class
- Content now fits on any screen size and scrolls when needed.
- `HVStack` view was created so views can change from `HStack` to `VStack` based on `dynamicTypeSize` and `horizontalSizeClass`.

## Legibility Weight
- Chart dot weight is adjusted when `legibilityWeight == .bold`.

## Color
- Chart and stock change appearance is altered if `accessibilityDifferentiateWithoutColor` is active.
- Up/Down colors and star image ignore invert setting.
- Up/Down colors can now be configured in settings. This can help people who have difficulty distinguishing colors or if they want to change the colors to better match their view of positive/negative values.
- Text on Favourite button was changed to black to have better contrast against yellow

## VoiceOver
- Short stock name is `.lowercased()` and read out as characters using `speechSpellsOutCharacters()` to make VoiceOver sound better.
- List cells have been grouped into a single VoiceOver element using `.accessibilityElement(children: .combine)` so the list is easier to navigate.
- List cells have extra accessibility actions for info or opening the details view.
- Punctuation was added to VoiceOver so it reads through values in a natural way.
- Several `.tapGesture` elements were changed to `Button` to gain automatic VoiceOver labels and traits.
- Star image trait removed as it is decorative.
- Stock chart values are all read out on the detail view chart.

## Reduced Motion
- Movement animation of chart dots is dissabled when `accessibilityReduceMotion` is active.

## Reduced Transparency
- Transparency on chart is removed when `accessibilityReduceTransparency` is active.

## Bugfixes
- Chart points changed to an identifiable element

## Dark Mode
- Due to lots of nice defaults, dark mode worked after all these changes.



