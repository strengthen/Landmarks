//
//  CategoryItem.swift
//  Landmarks
//
//  Created by strengthen on 2025/1/1.
//


import SwiftUI

struct CategoryItem: View {
    var landmark: Landmark

    var body: some View {
        VStack(alignment: .leading) {
            landmark.image
            // 通过应用 renderMode(_:) 和 foregroundStyle(_:) 修饰符来更改类别项的导航外观。
            // 您作为导航链接标签传递的文本将使用环境的强调色进行渲染，而图像则可能渲染为模板图像。您可以修改任一行为以最适合您的设计。
                .renderingMode(.original)
                .resizable()
                .frame(width: 155, height: 155)
                .cornerRadius(5)
            Text(landmark.name)
            // 通过应用 renderMode(_:) 和 foregroundStyle(_:) 修饰符来更改类别项的导航外观。
            // 您作为导航链接标签传递的文本将使用环境的强调色进行渲染，而图像则可能渲染为模板图像。您可以修改任一行为以最适合您的设计。
                .foregroundStyle(.primary)
                .font(.caption)
        }
        .padding(.leading, 15)
    }
}

#Preview {
    CategoryItem(landmark: ModelData().landmarks[0])
}
