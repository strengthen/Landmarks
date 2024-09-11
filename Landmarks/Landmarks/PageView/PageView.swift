//
//  PageView.swift
//  Landmarks
//
//  Created by strengthen on 2025/1/1.
//


import SwiftUI

/*
 接下来，您将创建一个自定义视图来呈现您的 UIViewControllerRepresentable 视图。
 创建一个名为 PageView.swift 的新 SwiftUI 视图文件，并更新 PageView 类型以将 PageViewController 声明为子视图。
 预览失败，因为 Xcode 无法推断 Page 的类型。
 */
struct PageView<Page: View>: View {
    var pages: [Page]
    // 在 PageView 中声明 @State 变量，并在创建子 PageViewController 时将绑定传递给该属性。
    // 请记住使用 $ 语法创建与存储为状态的值的绑定。
    @State private var currentPage = 0

    var body: some View {
        // 用页面控件替换文本框，从 VStack 切换到 ZStack 进行布局。由于您正在传递页数和绑定到当前页面，因此页面控件已经显示正确的值。
        ZStack(alignment: .bottomTrailing) {
            PageViewController(pages: pages, currentPage: $currentPage)
            PageControl(numberOfPages: pages.count, currentPage: $currentPage)
                .frame(width: CGFloat(pages.count * 18))
                .padding(.trailing)
        }
        .aspectRatio(3 / 2, contentMode: .fit)
    }
}

#Preview {
    // 添加纵横比修改器并更新预览以传递所需的视图数组，然后预览开始工作。
    PageView(pages: ModelData().features.map { FeatureCard(landmark: $0) })
}
