//
//  HikeBadge.swift
//  Landmarks
//
//  Created by strengthen on 2025/1/1.
//

import SwiftUI

/*
 在 Hikes 文件夹中创建一个名为 HikeBadge 的新视图，该视图由绘制路径和形状以及一些有关徒步旅行的描述性文本组成徽章。
 徽章只是一个图形，因此 HikeBadge 中的文本以及 accessibilityLabel(_:) 修饰符使徽章的含义对其他用户更清晰。
 注意：徽章的绘制逻辑产生的结果取决于其渲染框架的大小。为确保所需的外观，请在 300 x 300 点的框架中渲染。要获得最终图形所需的大小，请缩放渲染结果并将其放置在相对较小的框架中。
 */
struct HikeBadge: View {
    var name: String

    var body: some View {
        VStack(alignment: .center) {
            Badge()
                .frame(width: 300, height: 300)
                .scaleEffect(1.0 / 3.0)
                .frame(width: 100, height: 100)
            Text(name)
                .font(.caption)
                .accessibilityLabel("Badge for \(name).")
        }
    }
}

#Preview {
    HikeBadge(name: "Preview Testing")
}
