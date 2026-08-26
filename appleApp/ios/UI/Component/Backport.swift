import SwiftUI
import SwiftUIBackports

public extension Backport where Wrapped: View {
    func labelIconToTitleSpacing(_ spacing: CGFloat) -> some View {
        wrapped.labelStyle(BackportLabelStyle(spacing: spacing))
    }
    
    func navigationSubtitle(_ subtitle: Text) -> some View {
        wrapped
    }
    
    func navigationSubtitle<S>(_ subtitle: S) -> some View where S : StringProtocol {
        wrapped
    }
}

struct BackportLabelStyle: LabelStyle {
    let spacing: CGFloat
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: spacing) {
            configuration.icon
            configuration.title
        }
    }
}

public extension Backport where Wrapped: View {
    @available(iOS 17.0, macOS 14.0, *)
    @ViewBuilder
    func textRenderer<T>(_ renderer: T) -> some View where T : TextRenderer {
        if #available(iOS 18.0, macOS 15.0, *) {
            wrapped.textRenderer(renderer)
        } else {
            wrapped
        }
    }
}
