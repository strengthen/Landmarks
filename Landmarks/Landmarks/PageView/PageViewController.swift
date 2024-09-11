//
//  PageViewController.swift
//  Landmarks
//
//  Created by strengthen on 2025/1/1.
//


import SwiftUI
import UIKit

/*
 在项目的 Views 文件夹中创建一个 PageView 组，并添加一个名为 PageViewController.swift 的新 Swift 文件；将 PageViewController 类型声明为符合 UIViewControllerRepresentable。
 页面视图控制器存储一个 Page 实例数组，该实例必须是 View 类型。这些是您用来在地标之间滚动的页面。
 */
struct PageViewController<Page: View>: UIViewControllerRepresentable {
    var pages: [Page]
    // 首先将 currentPage 绑定添加为 PageViewController 的属性。
    // 除了声明 @Binding 属性之外，您还更新对 setViewControllers(_:direction:animated:) 的调用，并传递 currentPage 绑定的值。
    @Binding var currentPage: Int

    // 向 PageViewController 添加另一个方法来创建协调器。
    // SwiftUI 在 makeUIViewController(context:) 之前调用此 makeCoordinator() 方法，以便您在配置视图控制器时可以访问协调器对象。
    // 您可以使用此协调器实现常见的 Cocoa 模式，例如委托、数据源以及通过目标操作响应用户事件。
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    // 接下来，添加 UIViewControllerRepresentable 协议的两个要求。
    // 添加一个 makeUIViewController(context:) 方法，该方法使用所需的配置创建 UIPageViewController。
    // 当 SwiftUI 准备好显示视图时，它会调用此方法一次，然后管理视图控制器的生命周期。
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)
        // 添加协调器作为UIPageViewController的数据源。
        pageViewController.dataSource = context.coordinator
        // 除了数据源之外，还将协调器指定为 UIPageViewController 的委托。
        // 通过双向绑定，文本视图会在每次滑动后更新以显示正确的页码。
        pageViewController.delegate = context.coordinator

        return pageViewController
    }
    // 添加一个 updateUIViewController(_:context:) 方法，该方法调用 setViewControllers(_:direction:animated:) 来提供要显示的视图控制器。
    // 现在，您创建 UIHostingController，它在每次更新时托管页面 SwiftUI 视图。稍后，您将通过在页面视图控制器的生命周期内仅初始化一次控制器来提高效率。
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        pageViewController.setViewControllers(
            // 使用视图的页面数组在协调器中初始化控制器数组。协调器是存储这些控制器的好地方，因为系统只会初始化一次，并且在您需要它们来更新视图控制器之前。
            [context.coordinator.controllers[currentPage]], direction: .forward, animated: true)
    }

    /*
     表示 UIKit 视图控制器的 SwiftUI 视图可以定义一个 Coordinator 类型，SwiftUI 会管理该类型并将其作为可表示视图上下文的一部分提供。
     在 PageViewController 内声明一个嵌套的 Coordinator 类。
     SwiftUI 管理您的 UIViewControllerRepresentable 类型的协调器，并在调用您上面创建的方法时将其作为上下文的一部分提供。
     */
    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var parent: PageViewController
        // 使用视图的页面数组在协调器中初始化控制器数组。协调器是存储这些控制器的好地方，因为系统只会初始化一次，并且在您需要它们来更新视图控制器之前。
        var controllers = [UIViewController]()

        init(_ pageViewController: PageViewController) {
            parent = pageViewController
            // 使用视图的页面数组在协调器中初始化控制器数组。 协调器是存储这些控制器的好地方，因为系统只会初始化一次，并且在您需要它们来更新视图控制器之前。
            controllers = parent.pages.map { UIHostingController(rootView: $0) }
        }

        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index == 0 {
                return controllers.last
            }
            return controllers[index - 1]
        }

        // 将 UIPageViewControllerDataSource 符合性添加到 Coordinator 类型，并实现两个必需的方法。
        // 这两个方法建立了视图控制器之间的关系，以便您可以在它们之间来回滑动。
        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index + 1 == controllers.count {
                return controllers.first
            }
            return controllers[index + 1]
        }

        // 将 UIPageViewControllerDataSource 符合性添加到 Coordinator 类型，并实现两个必需的方法。
        // 这两个方法建立了视图控制器之间的关系，以便您可以在它们之间来回滑动。
        func pageViewController(
            /*
             在 PageViewController.swift 中，将协调器与 UIPageViewControllerDelegate 保持一致，并添加 pageViewController(_:didFinishAnimating:previousViewControllers:transitionCompleted done: Bool) 方法。
             因为 SwiftUI 会在页面切换动画完成时调用此方法，所以您可以找到当前视图控制器的索引并更新绑定。
             */
            _ pageViewController: UIPageViewController,
            didFinishAnimating finished: Bool,
            previousViewControllers: [UIViewController],
            transitionCompleted completed: Bool) {
            if completed,
               let visibleViewController = pageViewController.viewControllers?.first,
               let index = controllers.firstIndex(of: visibleViewController) {
                parent.currentPage = index
            }
        }
    }
}
