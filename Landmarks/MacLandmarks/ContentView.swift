//
//  ProfileHost.swift
//  Landmarks
//
//  Created by strengthen on 2025/1/1.
//

/*
 在项目导航器中，从 MacLandmarks 组中删除 MacLandmarksApp 文件。系统提示时，选择“移至废纸篓”。
 与 watchOS 应用一样，您不需要默认的应用结构，因为您将重复使用已有的结构。
*/

import SwiftUI

// 在 MacLandmarks 组的 ContentView 中，添加 LandmarkList 作为顶层视图，并对框架大小进行限制。
struct ContentView: View {
    var body: some View {
        LandmarkList()
            .frame(minWidth: 700, minHeight: 300)
    }
}

#Preview {
    // 预览不再构建，因为 LandmarkList 使用 LandmarkDetail，但您尚未为 macOS 应用定义详细视图。您将在下一节中处理这个问题。
    ContentView()
        .environment(ModelData())
}


// 用户希望能够使用标准“设置”菜单项调整 macOS 应用的设置。您将通过添加“设置”场景向 MacLandmarks 添加首选项。场景的视图定义首选项窗口的内容，您将使用该窗口来控制 MapView 的初始缩放级别。您可以使用 @AppStorage 属性包装器将该值传达给地图视图，并将其持久存储。
