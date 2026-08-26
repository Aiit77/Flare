import SwiftUI
@preconcurrency import KotlinSharedUI
import PhotosUI
import FlareAppleCore

struct CreateListScreen: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var presenter: KotlinPresenter<CreateListState>
    @State private var avatarData: Data? = nil
    @State private var avatarFileName: String? = nil
    @State private var listName: String = ""
    @State private var listDescription: String = ""
    @State private var selectedImage: Image?
    @State private var loading = false
    
    init(accountType: AccountType) {
        self._presenter = .init(wrappedValue: .init(presenter: CreateListPresenter(accountType: accountType)))
    }
    
    var body: some View {
        Form {
            StateView(state: presenter.state.supportedMetaData) { metadata in
                if metadata.contains(ListMetaDataType.avatar) {
                    Section("list_edit_avatar") {
                        if #available(iOS 16.0, *) {
                            CreateListAvatarPicker(
                                avatarData: $avatarData,
                                avatarFileName: $avatarFileName,
                                selectedImage: $selectedImage
                            )
                        } else {
                            createListAvatarPreview
                        }
                    }
                }
            }
            Section("list_edit_name") {
                TextField("list_edit_name", text: $listName)
            }
            StateView(state: presenter.state.supportedMetaData) { metadata in
                if metadata.contains(ListMetaDataType.theDescription) {
                    Section("list_description") {
                        TextField("list_description", text: $listDescription)
                    }
                }
            }
        }
        .navigationTitle("list.create.title")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    Task {
                        loading = true
                        let imageByteArray = avatarData.map { KotlinByteArray.from(data: $0) }
                        if let imageByteArray {
                            try? await presenter.state.createList(
                                listMetaData: .init(
                                    title: self.listName,
                                    description: self.listDescription.isEmpty ? nil : self.listDescription,
                                    avatar: .init(name: avatarFileName, data: imageByteArray, type: .image)
                                )
                            )
                        } else {
                            try? await presenter.state.createList(
                                listMetaData: .init(
                                    title: self.listName,
                                    description: self.listDescription.isEmpty ? nil : self.listDescription,
                                )
                            )
                        }
                        loading = false
                        dismiss()
                    }
                } label: {
                    Image(fontAwesome: .check)
                }
                .disabled(listName.isEmpty)
            }
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    dismiss()
                } label: {
                    Image(fontAwesome: .xmark)
                }
            }
        }
        .disabled(loading)
    }

    @ViewBuilder
    private var createListAvatarPreview: some View {
        if let selectedImage {
            selectedImage
                .resizable()
                .scaledToFit()
                .frame(width: 96, height: 96)
        } else {
            Image(fontAwesome: .squareRss)
                .resizable()
                .scaledToFit()
                .frame(width: 96, height: 96)
        }
    }
}

@available(iOS 16.0, *)
private struct CreateListAvatarPicker: View {
    @Binding var avatarData: Data?
    @Binding var avatarFileName: String?
    @Binding var selectedImage: Image?
    @State private var selectedItem: PhotosPickerItem?

    var body: some View {
        PhotosPicker(selection: $selectedItem, matching: .images) {
            if let selectedImage {
                selectedImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 96, height: 96)
            } else {
                Image(fontAwesome: .squareRss)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 96, height: 96)
            }
        }
        .onChange(of: selectedItem) { item in
            Task {
                guard let item else { return }
                do {
                    if let data = try await item.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        avatarData = data
                        avatarFileName = item.itemIdentifier
                        selectedImage = Image(uiImage: uiImage)
                    }
                } catch {
                }
            }
        }
    }
}
