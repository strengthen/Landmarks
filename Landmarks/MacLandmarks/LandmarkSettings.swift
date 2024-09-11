//
//  LandmarkSettings.swift
//  Landmarks
//
//  Created by strengthen on 2025/1/1.
//

import SwiftUI

// 接下来，您将创建一个控制存储的缩放值的“设置”场景。
// 创建一个名为 LandmarkSettings 的新 SwiftUI 视图，该视图仅针对 macOS 应用。
struct LandmarkSettings: View {
    // 添加一个 @AppStorage 属性，该属性使用与您在地图视图中使用的相同键。
    @AppStorage("MapView.zoom")
    private var zoom: MapView.Zoom = .medium

    var body: some View {
        // 添加一个通过绑定控制缩放值的选择器。您通常使用表单来排列设置视图中的控件。
        Form {
            Picker("Map Zoom:", selection: $zoom) {
                ForEach(MapView.Zoom.allCases) { level in
                    Text(level.rawValue)
                }
            }
            .pickerStyle(.inline)
        }
        .frame(width: 300)
        .navigationTitle("Landmark Settings")
        .padding(80)
    }
}

#Preview {
    LandmarkSettings()
}
