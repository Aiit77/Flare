import SwiftUI
import KotlinSharedUI
import FlareAppleCore

struct AppLogScreen: View {
    @StateObject private var presenter = KotlinPresenter(presenter: DevModePresenter())
    @State private var selectedMessage: String? = nil
    @State private var exportedLogContent = ""
    @State private var showingExportedLog = false
    var body: some View {
        List {
            Section {
                Toggle(isOn: Binding(get: {
                    presenter.state.enabled
                }, set: { enabled in
                    presenter.state.setEnabled(value: enabled)
                }), label: {
                    Text("app_log_network_toggle")
                })
            }
            ForEach(presenter.state.messages) { message in
                Text(message)
                    .lineLimit(3)
                    .onTapGesture {
                        selectedMessage = message
                    }
            }
        }
        .toolbar {
            ToolbarItem {
                Button {
                    presenter.state.clear()
                } label: {
                    Image(fontAwesome: .trash)
                }
            }
            ToolbarItem {
                Button {
                    exportedLogContent = presenter.state.printMessageToString()
                    showingExportedLog = true
                } label: {
                    Image(fontAwesome: .floppyDisk)
                }
            }
        }
        .sheet(isPresented: $showingExportedLog) {
            NavigationView {
                ScrollView {
                    Text(exportedLogContent)
                        .textSelection(.enabled)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .navigationTitle("flare_log.txt")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button {
                            showingExportedLog = false
                        } label: {
                            Image(fontAwesome: .xmark)
                        }
                    }
                }
            }
        }
        .navigationTitle("app_log")
        .sheet(item: $selectedMessage) { message in
            NavigationView {
                ScrollView {
                    Text(message)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button {
                            selectedMessage = nil
                        } label: {
                            Image(fontAwesome: .xmark)
                        }
                    }
                }
            }
        }
    }
}
