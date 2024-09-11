//
//  ContentView.swift
//  Landmarks
//
//  Created by strengthen on 2025/1/1.
//

import SwiftUI
import UserNotifications

// 首先，删除 watchOS 应用的入口点。你不需要它，因为你将重用 LandmarksApp 中定义的入口点。
/*
 接下来，选择您的 watchOS 目标可以与现有 iOS 目标共享的所有文件（包括应用程序的入口点）。
 在项目导航器中，按住 Command 键并单击以选择以下文件：LandmarksApp、LandmarkList、LandmarkRow、CircleImage、MapView。
 其中第一个是共享应用程序定义。其他是应用程序可以在 watchOS 上显示的视图，无需进行任何更改。
 */

// 在 WatchLandmarks Watch App 文件夹中选择 ContentView。与 LandmarkDetail 一样，watchOS 目标的内容视图与 iOS 目标的内容视图同名。保持名称和界面相同，便于在目标之间共享文件。
struct ContentView: View {
    var body: some View {
        // 修改 ContentView 以使其显示列表视图。
        LandmarkList()
        // 转到 ContentView 并请求授权以启用来自通知中心的通知。
        // 您可以使用异步任务修改器发出请求，SwiftUI 在内容视图首次出现时会调用该修改器。
            .task {
                let center = UNUserNotificationCenter.current()
                _ = try? await center.requestAuthorization(
                    options: [.alert, .sound, .badge]
                )
            }
    }
}
// 将新的通知模拟文件添加到 WatchLandmarks Watch App 文件夹中，文件名为 PushNotificationPayload.apns。
// 不要将 PushNotificationPayload 文件添加到任何目标，因为它不是应用程序的一部分。
// 在模拟器上构建并运行 WatchLandmarks Watch App 方案。
// 首次运行该应用时，系统会请求发送通知的权限。选择“允许”。


#Preview {
    // 确保将模型数据作为环境提供给预览。 LandmarksApp 已经在运行时在应用级别提供了此功能，就像 iOS 一样，但您还必须为需要它的任何预览提供它。
    ContentView()
        .environment(ModelData())
}
