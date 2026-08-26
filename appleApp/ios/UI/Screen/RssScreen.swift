import FlareAppleCore
import FlareAppleUI
import KotlinSharedUI
import SwiftUI

struct RssScreen: View {
    @StateObject private var presenter = KotlinPresenter(presenter: RssListWithTabsPresenter())
    @State private var showAddSheet = false
    @State private var selectedEditItem: UiRssSource? = nil
    @State private var importOpmlUrl: URL? = nil
    @State private var exportedOPMLContent = ""
    @State private var showingExportedOPML = false

    var body: some View {
        List {
            ForEach(presenter.state.sources, id: \.id) { item in
                FlareNavigationLink(value: Route.timeline(
                    presenter.state.timelineTabItem(item: item)
                )) {
                    HStack {
                        UiRssView(data: item)
                        Spacer()
                        Button {
                            selectedEditItem = item
                        } label: {
                            Image(fontAwesome: .pen)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .swipeActions {
                    Button(role: .destructive) {
                        presenter.state.delete(id: Int32(item.id))
                    } label: {
                        Label {
                            Text("delete")
                        } icon: {
                            Image(fontAwesome: .trash)
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showingExportedOPML) {
            NavigationView {
                ScrollView {
                    Text(exportedOPMLContent)
                        .textSelection(.enabled)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .navigationTitle("flare_export.opml")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button {
                            showingExportedOPML = false
                        } label: {
                            Image(fontAwesome: .xmark)
                        }
                    }
                }
            }
        }
        .navigationTitle("rss_title")
        .toolbar {
            ToolbarItem {
                if !presenter.state.sources.isEmpty {
                    Button {
                        Task {
                            exportedOPMLContent = (try? await ExportOPMLPresenter().export()) ?? ""
                            showingExportedOPML = !exportedOPMLContent.isEmpty
                        }
                    } label: {
                        Image(fontAwesome: .fileExport)
                    }
                }
            }

            ToolbarItem(placement: .primaryAction) {
                Button {
                    showAddSheet = true
                } label: {
                    Image(fontAwesome: .plus)
                }
            }
        }
        .sheet(isPresented: $showAddSheet) {
            FlareNavigationStack {
                EditRssSheet(id: nil, onImportOPML: { url in
                    showAddSheet = false
                    importOpmlUrl = url
                })
            }
        }
        .sheet(item: $selectedEditItem) { item in
            FlareNavigationStack {
                EditRssSheet(
                    id: Int(item.id),
                    initialUrl: item.url,
                    initialDisplayMode: item.displayMode,
                    onImportOPML: { url in
                        importOpmlUrl = url
                    }
                )
            }
        }
        .sheet(item: $importOpmlUrl) { url in
            FlareNavigationStack {
                ImportOPMLScreen(url: url)
            }
        }
    }
}

extension URL: Identifiable {
    public var id: String { absoluteString }
}
