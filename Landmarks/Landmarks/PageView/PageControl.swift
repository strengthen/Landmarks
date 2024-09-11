//
//  PageControl.swift
//  Landmarks
//
//  Created by strengthen on 2025/1/1.
//


import SwiftUI
import UIKit

/*
 创建一个新的 SwiftUI 视图文件，名为 PageControl.swift。更新 PageControl 类型以符合 UIViewRepresentable 协议。
 UIViewRepresentable 和 UIViewControllerRepresentable 类型具有相同的生命周期，其方法与其底层 UIKit 类型相对应。
 */
struct PageControl: UIViewRepresentable {
    var numberOfPages: Int
    @Binding var currentPage: Int

    // 接下来，使页面控件具有交互性，以便用户可以点击一侧或另一侧在页面之间移动。
    // 在 PageControl 中创建嵌套的 Coordinator 类型，并添加 makeCoordinator() 方法来创建并返回新的协调器。
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = numberOfPages
        // 将协调器添加为 valueChanged 事件的目标，并指定 updateCurrentPage(sender:) 方法作为要执行的操作。
        control.addTarget(
            context.coordinator,
            action: #selector(Coordinator.updateCurrentPage(sender:)),
            for: .valueChanged)

        return control
    }

    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }

    class Coordinator: NSObject {
        var control: PageControl

        init(_ control: PageControl) {
            self.control = control
        }
        // 由于 UIControl 子类（如 UIPageControl）使用目标操作模式而不是委托，因此此 Coordinator 实现了 @objc 方法来更新当前页面绑定。
        @objc
        func updateCurrentPage(sender: UIPageControl) {
            control.currentPage = sender.currentPage
        }
    }
}

/*
 您使用哪种协议将 UIKit 视图控制器桥接到 SwiftUI？
 UIViewControllerRepresentable
 创建符合 UIViewControllerRepresentable 的结构并实现协议要求以将 UIViewController 包含在您的 SwiftUI 视图层次结构中。
*/
