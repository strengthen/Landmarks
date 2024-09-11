//
//  CategoryHome.swift
//  Landmarks
//
//  Created by strengthen on 2025/1/1.
//


import SwiftUI

// 在项目的 Views 组中创建一个 Categories 组，并为新组创建一个名为 CategoryHome 的自定义视图。
struct CategoryHome: View {
    // 在 CategoryHome 中，创建一个 modelData 属性。您现在需要访问这些类别，以及稍后访问其他地标数据。
    @Environment(ModelData.self) var modelData
    @State private var showingProfile = false
    
    var body: some View {
        // 添加 NavigationSplitView 来承载不同的类别。
        // 您可以使用导航分割视图以及 NavigationLink 实例和相关修饰符在您的应用中构建分层导航结构。
        NavigationSplitView {
            // 使用列表显示地标中的类别。Landmark.Category 案例名称标识列表中的每个项目，因为它是一个枚举，所以它在其他类别中必须是唯一的。
            List {
                //                // 在 CategoryHome 中，将第一个特色地标的图像添加到列表顶部。
                //                // 在后面的教程中，您将把此视图变成交互式轮播。目前，它显示其中一个特色地标，并带有缩放和裁剪的预览图像。
                //                modelData.features[0].image
                //                    .resizable()
                //                    .scaledToFill()
                //                    .frame(height: 200)
                //                    .clipped()
                
                // 最后，在 CategoryHome 中，用新的页面视图替换占位符功能图像。
                PageView(pages: modelData.features.map { FeatureCard(landmark: $0) })
                // 将两种地标预览的边缘插入设置为零，以便内容可以延伸到显示屏的边缘。
                    .listRowInsets(EdgeInsets())
                ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                    // 更新 CategoryHome 的主体以将类别信息传递给行类型的实例。
                    CategoryRow(categoryName: key, items: modelData.categories[key]!)
                }
                // 将两种地标预览的边缘插入设置为零，以便内容可以延伸到显示屏的边缘。
                .listRowInsets(EdgeInsets())
            }
            // 添加 listStyle 修饰符来选择更适合内容的列表样式。
            .listStyle(.inset)
            // 将导航栏的标题设置为Featured（特色）。视图顶部展示一个或多个特色地标。
            .navigationTitle("Featured")
            // 在 CategoryHome 中，使用工具栏修饰符向导航栏添加用户个人资料按钮，并在用户点击它时显示 ProfileHost 视图。
            .toolbar {
                Button {
                    showingProfile.toggle()
                } label: {
                    Label("User Profile", systemImage: "person.crop.circle")
                }
            }
            .sheet(isPresented: $showingProfile) {
                ProfileHost()
                    .environment(modelData)
            }
        } detail: {
            Text("Select a Landmark")
        }
    }
}

#Preview {
    CategoryHome()
        .environment(ModelData())
}
