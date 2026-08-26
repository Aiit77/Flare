import SwiftUI
import KotlinSharedUI
import FlareAppleCore

struct StatusReactionView: View {
    @Environment(\.openURL) private var openURL
    let data: [UiTimelineV2.PostEmojiReaction]
    let isDetail: Bool
    var body: some View {
        if isDetail {
            WrappedHStack {
                reactionContent
            }
        } else {
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    reactionContent
                }
            }
            .flareScrollIndicatorsHidden()
        }
    }
    
    var reactionContent: some View {
        ForEach(data, id: \.name) { item in
            Button {
                item.onClicked(ClickContext(launcher: AppleUriLauncher(openUrl: openURL)))
            } label: {
                HStack(spacing: 4) {
                    if item.isUnicode {
                        Text(item.name)
                    } else {
                        NetworkImage(data: item.url)
                            .scaledToFit()
                            .fixedSize(horizontal: true, vertical: false)
                    }
                    Text(item.count.humanized)
                }
                .foregroundStyle(Color.flareLabel)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(
                    item.me
                        ? Color.accentColor.opacity(0.18)
                        : Color.flareSecondarySystemGroupedBackground,
                    in: Capsule()
                )
                .overlay {
                    Capsule()
                        .stroke(item.me ? Color.accentColor : Color.clear, lineWidth: 1)
                }
            }
            .buttonStyle(.plain)
        }
    }
}



public struct WrappedHStack<Content: View>: View {
    private let horizontalSpacing: CGFloat
    private let verticalSpacing: CGFloat
    private let content: Content

    public init(
        horizontalSpacing: CGFloat = 8,
        verticalSpacing: CGFloat = 8,
        @ViewBuilder content: () -> Content
    ) {
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
        self.content = content()
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: verticalSpacing) {
            content
        }
    }
}
