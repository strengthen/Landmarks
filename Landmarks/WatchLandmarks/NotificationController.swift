//
//  NotificationController.swift
//  Landmarks
//
//  Created by strengthen on 2025/1/1.
//

import WatchKit
import SwiftUI
import UserNotifications

// 创建一个名为 NotificationController.swift 的新 Swift 文件，并添加包含地标、标题和消息属性的托管控制器结构。
// 这些属性存储有关传入通知的值。
class NotificationController: WKUserNotificationHostingController<NotificationView> {
    var landmark: Landmark?
    var title: String?
    var message: String?

    // 定义地标索引键。您可以使用此键从通知中提取地标索引。
    let landmarkIndexKey = "landmarkIndex"

    override var body: NotificationView {
        // 更新 body() 方法以使用这些属性。此方法实例化您之前创建的通知视图。
        NotificationView(title: title,
            message: message,
            landmark: landmark)
    }

    // 添加 didReceive(_:) 方法来解析通知中的数据。
    // 此方法更新控制器的属性。调用此方法后，系统会使控制器的 body 属性无效，从而更新通知视图。然后系统会在 Apple Watch 上显示通知。
    override func didReceive(_ notification: UNNotification) {
        let modelData = ModelData()

        let notificationData =
            notification.request.content.userInfo as? [String: Any]

        let aps = notificationData?["aps"] as? [String: Any]
        let alert = aps?["alert"] as? [String: Any]

        title = alert?["title"] as? String
        message = alert?["body"] as? String

        if let index = notificationData?[landmarkIndexKey] as? Int {
            landmark = modelData.landmarks[index]
        }
    }
}
