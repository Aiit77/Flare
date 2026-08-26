import SwiftUI

/// A lightweight iOS 15 replacement for SwiftUI's iOS 17 empty-state view.
public struct FlareContentUnavailableView<LabelContent: View, DescriptionContent: View, ActionsContent: View>: View {
    private let label: LabelContent
    private let description: DescriptionContent
    private let actions: ActionsContent

    public init(
        @ViewBuilder label: () -> LabelContent,
        @ViewBuilder description: () -> DescriptionContent,
        @ViewBuilder actions: () -> ActionsContent
    ) {
        self.label = label()
        self.description = description()
        self.actions = actions()
    }

    public var body: some View {
        VStack(spacing: 12) {
            label
                .multilineTextAlignment(.center)
            description
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            actions
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .padding()
    }
}

public extension FlareContentUnavailableView where ActionsContent == EmptyView {
    init(
        @ViewBuilder label: () -> LabelContent,
        @ViewBuilder description: () -> DescriptionContent
    ) {
        self.init(label: label, description: description, actions: { EmptyView() })
    }
}

public extension FlareContentUnavailableView where DescriptionContent == EmptyView, ActionsContent == EmptyView {
    init(@ViewBuilder label: () -> LabelContent) {
        self.init(label: label, description: { EmptyView() }, actions: { EmptyView() })
    }
}

public extension FlareContentUnavailableView where DescriptionContent == EmptyView, ActionsContent == EmptyView, LabelContent == Label<Text, Image> {
    init(_ title: LocalizedStringKey, systemImage: String) {
        self.init(
            label: { Label(title, systemImage: systemImage) },
            description: { EmptyView() },
            actions: { EmptyView() }
        )
    }
}

/// An iOS 15 navigation container with the same trailing-closure construction style.
public struct FlareNavigationStack<Content: View>: View {
    private let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        #if os(iOS)
        NavigationView {
            content
        }
        .navigationViewStyle(StackNavigationViewStyle())
        #else
        NavigationView {
            content
        }
        #endif
    }
}

public extension View {
    /// The path-driven NavigationStack destination API is unavailable on iOS 15.
    /// The root remains navigable with the app's existing sheet and cover routes.
    @ViewBuilder
    func flareNavigationDestination<Data: Hashable, Destination: View>(
        for data: Data.Type,
        @ViewBuilder destination: @escaping (Data) -> Destination
    ) -> some View {
        self
    }

    /// iOS 15 always uses the platform default scroll indicators.
    @ViewBuilder
    func flareScrollIndicatorsHidden() -> some View {
        self
    }

    /// iOS 15 does not expose a scroll-content background modifier.
    @ViewBuilder
    func flareScrollContentBackgroundHidden() -> some View {
        self
    }

    /// iOS 15 has no default-scroll-anchor API; preserve the original layout.
    @ViewBuilder
    func flareDefaultScrollAnchor(_ anchor: UnitPoint) -> some View {
        self
    }

    /// iOS 15 has no scroll target layout API.
    @ViewBuilder
    func flareScrollTargetLayout() -> some View {
        self
    }

    /// iOS 15 has no binding-based scroll position API.
    @ViewBuilder
    func flareScrollPosition<ID: Hashable>(id: Binding<ID?>, anchor: UnitPoint? = nil) -> some View {
        self
    }
}
