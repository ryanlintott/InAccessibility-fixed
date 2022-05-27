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

# Examples

## Dynamic Type, Layout and Colors
https://user-images.githubusercontent.com/2143656/170584736-b2fbe61b-2025-4a1e-b6ab-594a9acc1bc1.mp4

## Voice Over
https://user-images.githubusercontent.com/2143656/170584726-ca472f04-93cb-45aa-b692-9c2cf3738f26.mp4

# What I Missed
After watching the [Accessibility event](https://youtu.be/anOY0aSxxpQ) I found more accessibility issues I didn't address. I've listed them here:

- Context menu actions. These could make VoiceOver and Switch Control a lot easier. 
- accessibilityChartDescriptor could improve the chart accessibility.
[Alexey Ivashko](https://github.com/Overcot/InAccessibility) implemented both of these.

- Testing long stock names (especially those in other languages like German). They might be truncated as I limited the text to one line.
Good job [Chris Wu](https://github.com/shiftingsand/InAccessibility-cwu) for catching this one.

- "Tap" language in "Tap for more" and "Tap to share" assumes touchscreen interaction. It's better to avoid interaction-specific language.
- Minimum button size should be 44 points.
- Test and improve contrast ratio on a few items like the favourite star.
- Test with Full Keyboard Access
Nice work [Ryan Cole](https://github.com/rcole34/InAccessibility) for addressing these issues and congrats on winning the event!

- Test with Voice Control (and I'm a bit embarrassed about missing it).
Great work [Michelle Lau](https://github.com/mimzivvimzi/InAccessibility) for checking this and providing screenshots.

- Customize focus state to ensure certain elements are accessed first by Voice Over and Switch Control. For example, jumping back to the selected stock when dismissing the detail view.
- Cutsom rotors for quick navitation between stocks.
Glad you implemented these features. [Adi Mathew](https://github.com/mathewa6/InAccessibility)!

- Add a close button to the detail view sheet to make it easier to dismiss. Any gesture-based interactions should have a button alternative.
Thanks [Robin Kanatzar](https://twitter.com/RobinKanatzar) (one of the judges) for this tip.

- Use the caption panel when debugging and screen recording to easily see what VoiceOver is saying.
Thanks [Bas Broek](https://twitter.com/basthomas) (one of the judges) for pointing out this feature.

