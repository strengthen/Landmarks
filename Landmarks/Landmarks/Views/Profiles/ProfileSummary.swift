//
//  ProfileSummary.swift
//  Landmarks
//
//  Created by strengthen on 2025/1/1.
//

import SwiftUI
/*
 在 Profiles 组中创建另一个名为 ProfileSummary 的视图，该视图采用 Profile 实例并显示一些基本用户信息。
 个人资料摘要采用 Profile 值而不是与个人资料的绑定，因为父视图 ProfileHost 管理此视图的状态。
 */
struct ProfileSummary: View {
    @Environment(ModelData.self) var modelData
    var profile: Profile

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(profile.username)
                    .bold()
                    .font(.title)

                Text("Notifications: \(profile.prefersNotifications ? "On": "Off" )")
                Text("Seasonal Photos: \(profile.seasonalPhoto.rawValue)")
                Text("Goal Date: ") + Text(profile.goalDate, style: .date)

                // 更新个人资料摘要，添加几种不同色调的徽章以及获得徽章的原因。
                Divider()

                VStack(alignment: .leading) {
                    Text("Completed Badges")
                        .font(.headline)

                    ScrollView(.horizontal) {
                        HStack {
                            HikeBadge(name: "First Hike")
                            HikeBadge(name: "Earth Day")
                                .hueRotation(Angle(degrees: 90))
                            HikeBadge(name: "Tenth Hike")
                                .grayscale(0.5)
                                .hueRotation(Angle(degrees: 45))
                        }
                        .padding(.bottom)
                    }
                }

                // 通过从动画视图和转换中添加 HikeView 来完成配置文件摘要。要使用徒步数据，您还需要添加模型数据环境属性。
                Divider()

                VStack(alignment: .leading) {
                    Text("Recent Hikes")
                        .font(.headline)

                    HikeView(hike: modelData.hikes[0])
                }
            }
            .padding()
        }
    }
}

#Preview {
    ProfileSummary(profile: Profile.default)
        .environment(ModelData())
}
