import SwiftUI

public struct ListCardView<Content: View>: View {
    @Environment(\.isMultipleColumn) private var isMultipleColumn
    private let index: Int
    private let totalCount: Int
    @ViewBuilder
    private let content: () -> Content
    private let cornerRadius: CGFloat = 32

    public init(
        index: Int,
        totalCount: Int,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.index = index
        self.totalCount = totalCount
        self.content = content
    }

    public var body: some View {
        content()
            .background(
                RoundedRectangle(cornerRadius: resolvedCornerRadius, style: .continuous)
                    .fill(Color.flareSecondarySystemGroupedBackground)
            )
    }

    private var resolvedCornerRadius: CGFloat {
        isMultipleColumn || (index == 0 && index == totalCount - 1) ? cornerRadius : 8
    }
}

public extension ListCardView {
    init(
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.init(index: 0, totalCount: 1, content: content)
    }
}
