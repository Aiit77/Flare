import SwiftUI
import SwiftUIBackports

public extension Backport where Wrapped: View {
    func flareLabelIconToTitleSpacing(_ spacing: CGFloat) -> some View {
        wrapped.labelStyle(FlareBackportLabelStyle(spacing: spacing))
    }
}

private struct FlareBackportLabelStyle: LabelStyle {
    let spacing: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: spacing) {
            configuration.icon
            configuration.title
        }
    }
}
