//
//  ProfileEditor.swift
//  Landmarks
//
//  Created by strengthen on 2025/1/1.
//
import SwiftUI

/*
 创建一个名为 ProfileEditor 的新视图，并添加与用户个人资料草稿副本的绑定。
 视图中的第一个控件是 TextField，它控制和更新字符串绑定 — 在本例中为用户选择的显示名称。创建文本字段时，您需要提供标签和与字符串的绑定。
 */
struct ProfileEditor: View {
    @Binding var profile: Profile
    // 最后，在季节选择器下方添加一个 DatePicker，以使地标访问目标日期可修改。
    var dateRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .year, value: -1, to: profile.goalDate)!
        let max = Calendar.current.date(byAdding: .year, value: 1, to: profile.goalDate)!
        return min...max
    }

    var body: some View {
        List {
            HStack {
                Text("Username")
                Spacer()
                TextField("Username", text: $profile.username)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.trailing)
            }
            // 添加与用户接收地标相关事件通知的偏好相对应的切换按钮。切换按钮是打开或关闭的控件，因此它们非常适合布尔值，例如“是”或“否”偏好。
            Toggle(isOn: $profile.prefersNotifications) {
                Text("Enable Notifications")
            }
            // 在 HStack 中放置一个 Picker 控件及其标签，使得地标照片具有可选择的首选季节。
            Picker("Seasonal Photo", selection: $profile.seasonalPhoto) {
                ForEach(Profile.Season.allCases) { season in
                    Text(season.rawValue).tag(season)
                }
            }
            // 最后，在季节选择器下方添加一个 DatePicker，以使地标访问目标日期可修改。
            DatePicker(selection: $profile.goalDate, in: dateRange, displayedComponents: .date) {
                Text("Goal Date")
            }
        }
    }
}

#Preview {
    ProfileEditor(profile: .constant(.default))
}
