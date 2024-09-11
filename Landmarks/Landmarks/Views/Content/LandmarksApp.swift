//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by strengthen on 2025/1/1.
//  SwiftUI Tutorials https://developer.apple.com/tutorials/swiftui

import SwiftUI

// @main属性标识应用的入口点。
@main
struct LandmarksApp: App {
    // 使用 @State 属性初始化模型对象的方式与使用它初始化视图内的属性的方式相同。就像 SwiftUI 在视图的生命周期内只初始化一次视图中的状态一样，它在应用程序的生命周期内只初始化一次应用程序中的状态。
    @State private var modelData = ModelData()

    // body属性返回一个或多个场景，而这些场景又提供要显示的内容
    var body: some Scene {
        WindowGroup {
            // 更新 LandmarksApp 以创建模型实例并使用 environment(_:) 修饰符将其提供给 ContentView。
            ContentView()
                .environment(modelData)
        }

        // 在命令修饰符周围添加一个条件，以便在 watchOS 应用中省略它。watchOS 应用将再次构建。
#if !os(watchOS)
        //        // 打开 LandmarksApp 文件，并使用命令（内容：）场景修改器应用 LandmarkCommands。场景修改器的工作方式与视图修改器类似，只不过您将其应用于场景而不是视图。
        //        // 再次运行 macOS 应用程序，您会发现可以使用“视图”>“显示侧边栏”菜单命令来恢复列表视图。
        .commands {
            LandmarkCommands()
        }
#endif

        // 转到 LandmarksApp 并使用 LandmarkNear 类别添加 WKNotificationScene。
        // 该场景仅适用于 watchOS，因此请添加条件编译。
#if os(watchOS)
        WKNotificationScene(controller: NotificationController.self, category: "LandmarkNear")
#endif

        // 在 LandmarksApp 中，将设置场景添加到您的应用，但仅适用于 macOS。
#if os(macOS)
        Settings {
            LandmarkSettings()
        }
#endif
    }
}


// 在声明自定义SwiftUI视图时，视图布局要声明的在哪里？body属性中，View协议中要求实现body属性，每一个SwiftUI视图都遵循View协议。
// 除了List外，下面哪种类型可以从集合数据中展示动态列表视图？ ForEach
// 可以从遵循了Identifiable协议的集合数据创建列表视图。但如果集合数据不遵循Identifiable协议，还有什么办法可以创建列表视图？给List(_:id:)类型传入集合数据的同时，使用keypath指定一个唯一标识符字段
// 使用什么类型才能让列表的行实现点击跳转到其它视图页面？NavigationLink
// 下面哪种方式不是用来设置预览设备的？在画面设置中设置一个不同的预览设备
// environmentObject(_:)修改器：可以把数据按视图层级关系传递下去？
// 绑定(binding)的作用是：绑定是值和改变值的方法
