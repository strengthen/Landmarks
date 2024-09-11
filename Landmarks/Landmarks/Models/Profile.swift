//
//  Hike.swift
//  Landmarks
//
//  Created by strengthen on 2025/1/1.
//

import Foundation

// 首先在名为 Profile.swift 的新 Swift 文件中定义一个用户配置文件，并将其添加到项目的模型组。
struct Profile {
    var username: String
    var prefersNotifications = true
    var seasonalPhoto = Season.winter
    var goalDate = Date()

    static let `default` = Profile(username: "g_kumar")

    enum Season: String, CaseIterable, Identifiable {
        case spring = "🌷"
        case summer = "🌞"
        case autumn = "🍂"
        case winter = "☃️"

        var id: String { rawValue }
    }
}
