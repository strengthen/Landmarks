//
//  ContentView.swift
//  Landmarks
//
//  Created by strengthen on 2025/1/1.
//

import SwiftUI

// 结构:符合协议View并描述视图的内容和布局。
// 应用程序主体中定义的 WindowGroup 场景将 ContentView 声明为应用程序的根视图。
struct ContentView: View {
    // 为选项卡选择添加一个状态变量，并赋予其默认值。
    @State private var selection: Tab = .featured

    // 接下来，您将修改应用程序的主内容视图以显示一个选项卡视图，让用户可以在您刚刚创建的类别视图和现有的地标列表之间进行选择。
    // 取消固定预览，切换到 ContentView 并添加要显示的选项卡的枚举。
    enum Tab {
        case featured
        case list
    }

    var body: some View {
        // 创建一个包装 LandmarkList 的标签视图以及新的 CategoryHome。
        // 每个视图上的 tag(_:) 修饰符与 select 属性可以采用的可能值之一相匹配，因此当用户在用户界面中进行选择时，TabView 可以协调显示哪个视图。
        TabView(selection: $selection) {
            CategoryHome()
                .tabItem {
                    // 为每个Tab赋予一个标签。
                    Label("Featured", systemImage: "star")
                }
                .tag(Tab.featured)

            LandmarkList()
                .tabItem {
                    // 为每个Tab赋予一个标签。
                    Label("List", systemImage: "list.bullet")
                }
                .tag(Tab.list)
        }
    }
}

// 预览声明会为该视图创建预览。
#Preview {
    // 如果画布不可见，请选择编辑器 > 画布来显示它。
    // 快捷键command + Option + Enter
    // ContentView()

    // 更新 ContentView 预览以将模型对象添加到环境中，这使得该对象可供任何子视图使用。
    // 如果任何子视图需要环境中的模型对象，但您正在预览的视图没有 environment(_:) 修饰符，则预览失败。
    ContentView()
        .environment(ModelData())
}

// 画布默认以实时模式显示预览，以便您与它们进行交互，但您也可以使用可选模式来启用编辑。
// 将预览设置回实时模式。在实时模式下工作可以让您在源中进行编辑时轻松跟踪视图行为。
// 在右侧预览中，按住 Command-Control 键并单击问候语以调出结构化编辑弹出窗口，然后选择“显示 SwiftUI 检查器”。
// 在左侧代码编辑，通过按住 Control 键并单击Text代码编辑器中的声明来打开检查器。
// 通过从库中拖动视图将文本视图添加到堆栈：通过单击 Xcode 窗口右上角的加号按钮 (+) 打开库，然后将视图拖到Text代码中“Turtle Rock”文本视图正下方的位置。
