import SwiftUI
import SwiftUIBackports

public extension Backport where Content: View {
    func labelIconToTitleSpacing(_ spacing: CGFloat) -> some View {
        content.labelStyle(BackportLabelStyle(spacing: spacing))
    }
    
    func navigationSubtitle(_ subtitle: Text) -> some View {
        content
    }
    
    func navigationSubtitle<S>(_ subtitle: S) -> some View where S : StringProtocol {
        content
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

public extension Backport where Content: View {
    @ViewBuilder
    func textRenderer<T>(_ renderer: T) -> some View where T : TextRenderer {
        if #available(iOS 18.0, macOS 15.0, *) {
            content.textRenderer(renderer)
        } else {
            content
        }
    }
}
