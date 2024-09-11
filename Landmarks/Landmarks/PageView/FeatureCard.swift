//
//  FeatureCard.swift
//  Landmarks
//
//  Created by strengthen on 2025/1/1.
//

import SwiftUI
/*
 添加一个新的 SwiftUI 视图文件，名为 FeatureCard.swift，用于显示地标的特色图像。
 包括纵横比修改器，以便它模仿 FeatureCard 最终将在稍后预览的视图的纵横比。
 */
struct FeatureCard: View {
    var landmark: Landmark

    var body: some View {
        landmark.featureImage?
            .resizable()
            .overlay {
                TextOverlay(landmark: landmark)
            }
    }
}

// 在图像上叠加有关地标的文本信息。
struct TextOverlay: View {
    var landmark: Landmark

    var gradient: LinearGradient {
        .linearGradient(
            Gradient(colors: [.black.opacity(0.6), .black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .center)
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            gradient
            VStack(alignment: .leading) {
                Text(landmark.name)
                    .font(.title)
                    .bold()
                Text(landmark.park)
            }
            .padding()
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    FeatureCard(landmark: ModelData().features[0])
        .aspectRatio(3 / 2, contentMode: .fit)
}
