//
//  NotificationView.swift
//  Landmarks
//
//  Created by strengthen on 2025/1/1.
//

import SwiftUI

struct NotificationView: View {
    // 向名为 NotificationView.swift 的 WatchLandmarks Watch App 文件夹添加一个新的自定义视图，
    // 并创建一个显示有关地标、标题和消息的信息的视图。
    var title: String?
    var message: String?
    var landmark: Landmark?

    var body: some View {
        VStack {
            if let landmark {
                CircleImage(image: landmark.image.resizable())
                    .scaledToFit()
            }

            Text(title ?? "Unknown Landmark")
                .font(.headline)

            Divider()

            Text(message ?? "You are within 5 miles of one of your favorite landmarks.")
                .font(.caption)
        }
    }
}

#Preview {
    NotificationView()
}

// 添加预览，设置通知视图的标题、消息和地标属性。
// 这会在提供数据时显示通知视图的预览。由于任何通知值都可以为零，因此在未提供任何数据时保留通知视图的默认预览很有用。
#Preview {
    NotificationView(
        title: "Turtle Rock",
        message: "You are within 5 miles of Turtle Rock.",
        landmark: ModelData().landmarks[0])
}
