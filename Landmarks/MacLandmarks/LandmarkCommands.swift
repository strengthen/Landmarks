//
//  ProfileHost.swift
//  Landmarks
//
//  Created by strengthen on 2025/1/1.
//

//当您使用 SwiftUI 生命周期创建应用时，系统会自动创建一个菜单，其中包含常用项目，例如用于关闭最前面的窗口或退出应用的项目。SwiftUI 允许您添加具有内置行为的其他常用命令以及完全自定义的命令。
// 在本节中，您将添加一个系统提供的命令，允许用户切换侧边栏，以便能够在将其拖动关闭后将其恢复。

// 导入 SwiftUI 并添加符合 Commands 协议的 LandmarkCommands 结构，该结构具有计算的 body 属性。
import SwiftUI
// 添加一个名为 LandmarkCommands.swift 的新 Swift 文件，并将其目标设置为同时包含 macOS 和 iOS。
// 您还将 iOS 作为目标，因为共享的 LandmarkList 最终将依赖于您在此文件中定义的某些类型。

// 与 View 结构一样，Commands 结构需要使用构建器语义的计算 body 属性，但使用的是命令而不是视图。
struct LandmarkCommands: Commands {
    // 添加 @FocusedBinding 属性包装器来跟踪当前选定的地标。您在这里读取值。稍后您将在列表视图中设置它，用户可在其中进行选择。
    @FocusedBinding(\.selectedLandmark) var selectedLandmark

    var body: some Commands {
        // 向正文添加 SidebarCommands 命令。此内置命令集包括用于切换侧边栏的命令。
        SidebarCommands()
        // 向您的命令添加一个名为 Landmarks 的新 CommandMenu。接下来您将定义菜单的内容。
        CommandMenu("Landmark") {
            // 在菜单中添加一个按钮，切换所选地标的收藏状态，其外观会根据当前所选地标及其状态而变化。
            Button("\(selectedLandmark?.isFavorite == true ? "Remove" : "Mark") as Favorite") {
                selectedLandmark?.isFavorite.toggle()
            }
            // 使用 keyboardShortcut(_:modifiers:) 修饰符为菜单项添加键盘快捷键。
            // SwiftUI 会自动在菜单中显示键盘快捷键。
            .keyboardShortcut("f", modifiers: [.shift, .option])
            .disabled(selectedLandmark == nil)
        }
    }
}

// 在 LandmarkCommands 中，使用名为 SelectedLandmarkKey 的自定义键，用 selectedLandmark 值扩展 FocusedValues 结构。
private struct SelectedLandmarkKey: FocusedValueKey {
    typealias Value = Binding<Landmark>
}

// 定义聚焦值的模式类似于定义新环境值的模式：使用私钥在系统定义的 FocusedValues 结构上读取和写入自定义属性。
extension FocusedValues {
    var selectedLandmark: Binding<Landmark>? {
        get { self[SelectedLandmarkKey.self] }
        set { self[SelectedLandmarkKey.self] = newValue }
    }
}
