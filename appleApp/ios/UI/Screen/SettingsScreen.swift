import SwiftUI
import FlareAppleUI
import KotlinSharedUI
import FlareAppleCore

struct SettingsScreen: View {
    var body: some View {
        List {
            FlareNavigationLink(value: Route.accountManagement) {
                Label {
                    Text("account_management_title")
                    Text("account_management_description")
                } icon: {
                    Image(fontAwesome: .circleUser)
                }
            }

            Section {
                FlareNavigationLink(value: Route.appearanceTheme) {
                    Label {
                        Text("appearance_theme")
                        Text("appearance_theme_group_subtitle")
                    } icon: {
                        Image(fontAwesome: .palette)
                    }
                }
                FlareNavigationLink(value: Route.appearanceLayout) {
                    Label {
                        Text("appearance_layout_group_title")
                        Text("appearance_layout_group_subtitle")
                    } icon: {
                        Image(fontAwesome: .tableList)
                    }
                }
                FlareNavigationLink(value: Route.appearanceDisplay) {
                    Label {
                        Text("appearance_display_group_title")
                        Text("appearance_display_group_subtitle")
                    } icon: {
                        Image(fontAwesome: .newspaper)
                    }
                }
                FlareNavigationLink(value: Route.appearanceMedia) {
                    Label {
                        Text("appearance_media_group_title")
                        Text("appearance_media_group_subtitle")
                    } icon: {
                        Image(fontAwesome: .photoFilm)
                    }
                }
                FlareNavigationLink(value: Route.appIconSettings) {
                    Label {
                        Text("App Icon")
                        Text("Choose the icon shown on your Home Screen")
                    } icon: {
                        Image(fontAwesome: .palette)
                    }
                }
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    Button {
                        UIApplication.shared.open(url)
                    } label: {
                        Label {
                            Text("system_settings_title")
                            Text("system_settings_description")
                        } icon: {
                            Image(fontAwesome: .gear)
                        }
                    }
                }
                
//                StateView(state: presenter.state.user) { _ in
//                    FlareNavigationLink(value: Route.moreMenuCustomize) {
//                        Label {
//                            Text("more_panel_customize")
//                        } icon: {
//                            Image(fontAwesome: .tableList)
//                        }
//                    }
//                }
            }

            Section {
                FlareNavigationLink(value: Route.behavior) {
                    Label {
                        Text("settings_behavior_title")
                        Text("settings_behavior_description")
                    } icon: {
                        Image(fontAwesome: .sliders)
                    }
                }
            }

            Section {
                FlareNavigationLink(value: Route.localFilter) {
                    Label {
                        Text("local_filter_title")
                        Text("local_filter_description")
                    } icon: {
                        Image(fontAwesome: .filter)
                    }
                }
                FlareNavigationLink(value: Route.storage) {
                    Label {
                        Text("storage_title")
                        Text("storage_description")
                    } icon: {
                        Image(fontAwesome: .database)
                    }
                }
            }

            Section {
                FlareNavigationLink(value: Route.aiConfig) {
                    Label {
                        Text("AI")
                        Text("ai_config_description")
                    } icon: {
                        Image(fontAwesome: .robot)
                    }

                }
                FlareNavigationLink(value: Route.translationConfig) {
                    Label {
                        Text("settings_translation_title")
                        Text("settings_translation_description")
                    } icon: {
                        Image(fontAwesome: .language)
                    }
                }
            }

            Section {
                FlareNavigationLink(value: Route.about) {
                    Label {
                        Text("about_title")
                        Text("about_description")
                    } icon: {
                        Image(fontAwesome: .circleInfo)
                    }
                }
            }
        }
        .navigationTitle("settings_title")
    }
}

struct BehaviorSettingsScreen: View {
    var body: some View {
        List {
            BehaviorSettingsSection {
                FlareNavigationLink(value: Route.linkOpenDefaults) {
                    Label {
                        Text("settings_link_open_defaults_title")
                        Text("settings_link_open_defaults_description")
                    } icon: {
                        EmptyView()
                    }
                }
            }
        }
        .navigationTitle("settings_behavior_title")
    }
}

struct LinkOpenDefaultsSettingsScreen: View {
    var body: some View {
        List {
            LinkOpenDefaultsSettingsSection()
        }
        .navigationTitle("settings_link_open_defaults_title")
    }
}
