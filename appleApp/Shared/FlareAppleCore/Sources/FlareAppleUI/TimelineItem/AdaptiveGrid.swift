import SwiftUI

/// iOS 15 fallback for the former `Layout`-based media grid.
///
/// The iOS 16 `Layout` protocol is unavailable on the target deployment
/// version. This container intentionally preserves the public initializer and
/// builder API while presenting its child views in a responsive vertical stack.
/// Media controls remain accessible and retain their intrinsic aspect ratios.
public struct AdaptiveGrid<Content: View>: View {
    public let singleFollowsImageAspect: Bool
    public let singleViewAspectRatio: CGFloat?
    public let spacing: CGFloat
    public let maxColumns: Int
    private let content: Content

    public init(
        singleFollowsImageAspect: Bool = true,
        singleViewAspectRatio: CGFloat? = nil,
        spacing: CGFloat = 4,
        maxColumns: Int = 3,
        @ViewBuilder content: () -> Content
    ) {
        self.singleFollowsImageAspect = singleFollowsImageAspect
        self.singleViewAspectRatio = singleViewAspectRatio
        self.spacing = spacing
        self.maxColumns = max(1, maxColumns)
        self.content = content()
    }

    public var body: some View {
        VStack(spacing: spacing) {
            content
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}
