//
//  CategoryRow.swift
//  Landmarks
//
//  Created by strengthen on 2025/1/1.
//


import SwiftUI

// 定义一个新的自定义视图 CategoryRow 用于保存一行的内容。
struct CategoryRow: View {
    var categoryName: String
    var items: [Landmark]

    var body: some View {
        // 将类别的项目放入 HStack 中，并将其与类别名称分组放入 VStack 中。
        VStack(alignment: .leading) {
            // 显示类别的名称。
            Text(categoryName)
                .font(.headline)
            // 通过指定高框架（宽度：高度：）、添加填充以及将 HStack 包装在滚动视图中，为内容提供一些空间。
                .padding(.leading, 15)
                .padding(.top, 5)

            ScrollView(.horizontal, showsIndicators: false) {
                // 将类别的项目放入 HStack 中
                HStack(alignment: .top, spacing: 0) {
                    ForEach(items) { landmark in
                        // 在 CategoryRow 中，用 NavigationLink 包装现有的 CategoryItem。
                        // 类别项本身是按钮的标签，其目的地是卡片所代表的地标的地标详细视图。
                        NavigationLink {
                            LandmarkDetail(landmark: landmark)
                        } label: {
                            // 在类别行中，用新的类别项目视图替换包含地标名称的文本。
                            CategoryItem(landmark: landmark)
                        }
                    }
                }
            }
            // 通过指定高框架（宽度：高度：）、添加填充以及将 HStack 包装在滚动视图中，为内容提供一些空间。
            .frame(height: 185)
        }
    }
}

#Preview {
    // 添加类别名称和该类别中的项目列表的属性。
    let landmarks = ModelData().landmarks
    return CategoryRow(
        categoryName: landmarks[0].category.rawValue,
        // 使用更大的数据样本更新视图预览可以更容易地确保滚动行为正确。
        items: Array(landmarks.prefix(4))
    )
}
