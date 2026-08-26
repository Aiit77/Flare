import SwiftUI
import KotlinSharedUI

public struct AvatarView: View {
    @Environment(\.timelineAppearance.avatarShape) private var avatarShape
    private let data: String?
    private let customHeader: [String: String]?

    public init(data: String?, customHeader: [String: String]? = nil) {
        self.data = data
        self.customHeader = customHeader
    }

    @ViewBuilder
    public var body: some View {
        if avatarShape == .circle {
            NetworkImage(data: data, customHeader: customHeader)
                .clipShape(Circle())
        } else {
            NetworkImage(data: data, customHeader: customHeader)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}
