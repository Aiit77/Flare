import KotlinSharedUI
import SwiftUI

public final class AppleUriLauncher: UriLauncher {
    private let openUrl: OpenURLAction

    public init(openUrl: OpenURLAction) {
        self.openUrl = openUrl
    }

    public func launch(uri: String) {
        guard let url = URL(string: uri) else { return }
        let action = openUrl
        Task { @MainActor in
            action(url)
        }
    }
}
