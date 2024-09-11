//
//  LandmarkList.swift
//  Landmarks
//
//  Created by strengthen on 2025/1/1.
//

// 使用 SwiftUI 的List类型时，您可以显示特定于平台的视图列表。列表的元素可以是静态的，例如您迄今为止创建的堆栈的子视图，也可以是动态生成的。您甚至可以混合使用静态和动态生成的视图。
import SwiftUI

// 点击Resume按钮或快捷键Command+Option+P刷新画布。当对视图进行添加或修改属性等结构性改变时，画布会自动刷新。
// 显示画布： Editor - Canvas
struct LandmarkList: View {
    // 在LandmarkList中，向视图添加一个属性包装器，并向预览添加一个修饰符@Environmentenvironment(_:)。
    @Environment(ModelData.self) var modelData

    // 添加一个名为showFavoritesOnly的@State属性，并将其初始值设置为false。
    // 因为您使用状态属性来保存特定于视图及其子视图的信息，所以您始终将状态创建为private。
    @State private var showFavoritesOnly = false // 使用实时预览，并通过点击切换按钮来尝试此新功能。
    // 添加过滤器状态变量，默认为全部情况。通过将过滤器状态存储在列表视图中，用户可以打开多个列表视图窗口，每个窗口都有自己的过滤器设置，以便能够以不同的方式查看数据。
    @State private var filter = FilterCategory.all
    // 菜单现在包含您的新命令，但您需要设置 selectedLandmark 聚焦绑定才能使其工作。
    @State private var selectedLandmark: Landmark?

    // 添加 FilterCategory 枚举来描述过滤器状态。 将案例字符串与 Landmark 结构中的 Category 枚举进行匹配，以便您可以比较它们，并包含一个全部案例以关闭过滤。
    enum FilterCategory: String, CaseIterable, Identifiable {
        case all = "All"
        case lakes = "Lakes"
        case rivers = "Rivers"
        case mountains = "Mountains"

        var id: FilterCategory { self }
    }

    var filteredLandmarks: [Landmark] {
        // 过滤地标时使用 modelData.landmarks 作为数据。
        modelData.landmarks.filter { landmark in
            // 通过检查showFavoritesOnly属性和每一个地标的isFavorite属性值来过滤地标列表所展示的内容
            (!showFavoritesOnly || landmark.isFavorite)
            // 更新filteredLandmarks以考虑新的过滤器设置，并结合给定地标的类别。
            && (filter == .all || filter.rawValue == landmark.category.rawValue)
        }
    }

    // 更新导航标题以匹配过滤器的状态。此更改将在 iOS 应用中有用。
    var title: String {
        let title = filter == .all ? "Landmarks" : filter.rawValue
        return showFavoritesOnly ? "Favorite \(title)" : title
    }

    // 在 LandmarkList 中，为选定的地标添加一个状态变量和一个指示选定地标索引的计算属性。
    var index: Int? {
        modelData.landmarks.firstIndex(where: { $0.id == selectedLandmark?.id })
    }

    var body: some View {
        // 将 focusedValue(_:_:) 修饰符添加到 NavigationSplitView，提供来自地标数组的值的绑定。
        @Bindable var modelData = modelData

        //        // 提供前两个地标作为列表的子项的实例。
        //        List {
        //            LandmarkRow(landmark: landmarks[0])
        //            LandmarkRow(landmark: landmarks[1])
        //        }

        //        // 可以通过传递数据集合和为集合中的每个元素提供视图的闭包来创建显示集合元素的列表。列表使用提供的闭包将集合中的每个元素转换为子视图。
        //        // 列表适用于可识别数据。您可以通过以下两种方式之一使数据可识别：将数据中的关键路径与唯一标识每个元素的属性一起传递，或者使数据类型符合协议Identifiable。
        //        // 将模型数据的landmarks数组传递给List初始化程序。
        //        List(landmarks, id: \.id){landmark in
        //            LandmarkRow(landmark: landmark)
        //        }

        // 把动态生成的列表视图嵌套进一个NavigationView视图中
        // 导航拆分视图接受第二个输入，即用户做出选择后显示的视图的占位符。在 iPhone 上，拆分视图不需要占位符，但在 iPad 上，详细信息窗格可以在用户做出选择之前显示，正如您将在本教程后面看到的那样。
        NavigationSplitView {
            //            // 移除keypath\.id，因为landmarkData数据集合的元素已经遵循了Identifiable协议，所以在列表初始化器中可以直接使用，不需要手动标明数据的唯一标识符了
            //            List(filteredLandmarks){landmark in
            //                //  在列表的闭包中，将每一个行元素包裹在NavigationLink中返回，并指定LandmarkDetail视图为目标视图
            //                NavigationLink {
            //                    // 换到实时预览模式下可以直接点击地标列表的任意一行，现在就可以跳转到地标详情页了。
            //                    LandmarkDetail(landmark: landmark)
            //                } label: {
            //                    LandmarkRow(landmark: landmark)
            //                }
            //            }

            // 使用与选定值的绑定初始化列表，并向导航链接添加标签。标签将特定地标与 ForEach 中的给定项目相关联，然后驱动选择。
            List(selection: $selectedLandmark) {
                // 创建一个ForEach嵌套组以将地标转换为行。
                // 要将静态和动态视图组合在一个列表中，或者组合两个或多个不同的动态视图组，请使用ForEach类型，而不是将数据集合传递给。
                ForEach(filteredLandmarks) { landmark in
                    NavigationLink {
                        LandmarkDetail(landmark: landmark)
                    } label: {
                        LandmarkRow(landmark: landmark)
                    }
                    // 使用与选定值的绑定初始化列表，并向导航链接添加标签。标签将特定地标与 ForEach 中的给定项目相关联，然后驱动选择。
                    .tag(landmark)
                }
            }
            // 通过添加当filteredLandmarks值改变时开始的修饰符来改进过滤动画。
            .animation(.default, value: filteredLandmarks)
            // 调用navigationBarTitle(_:)修改器设置地标列表显示时的导航条标题
            // .navigationTitle("Landmarks")
            // 更新导航标题以匹配过滤器的状态。此更改将在 iOS 应用中有用。
            .navigationTitle(title)
            // 在修改行之前，请设置列表的预览，因为您所做的更改取决于行在上下文中的外观。
            // 打开 LandmarkList 并添加最小宽度。这不仅能改善预览，还能确保列表在用户调整 macOS 窗口大小时不会变得太小。
            .frame(minWidth: 300)
            // 返回 MacLandmarks 方案，并在针对 iOS 和 macOS 的 LandmarkList 文件中，在新的工具栏修饰符内添加一个包含菜单的 ToolbarItem。
            .toolbar {
                // 将收藏夹切换按钮移至菜单中。
                // 这会以特定于平台的方式将切换按钮移至工具栏，这还有一个好处，就是无论地标列表有多长或用户向下滚动多远，都可以访问它。
                ToolbarItem {
                    Menu {
                        // 在菜单中添加一个选择器来设置过滤器类别。由于过滤器只有几个项目，因此可以使用内联选择器样式使它们全部一起显示。
                        Picker("Category", selection: $filter) {
                            ForEach(FilterCategory.allCases) { category in
                                Text(category.rawValue).tag(category)
                            }
                        }
                        .pickerStyle(.inline)
                        // 添加一个Toggle视图作为视图的第一个子视图List，并将绑定传递给showFavoritesOnly
                        // 可以使用$前缀来访问状态变量的绑定，或者它的某个属性。
                        Toggle(isOn: $showFavoritesOnly) {
                            Label("Favorites only", systemImage: "star.fill")
                        }
                    } label: {
                        Label("Filter", systemImage: "slider.horizontal.3")
                    }
                }
            }
        } detail: {
            Text("Select a Landmark")
        }
        //将 focusedValue(_:_:) 修饰符添加到 NavigationSplitView，提供来自地标数组的值的绑定。
        // 您在此处执行查找，以确保您正在修改存储在模型中的地标，而不是副本。
        .focusedValue(\.selectedLandmark, $modelData.landmarks[index ?? 0])
    }
}

#Preview {
    LandmarkList()
    // 只要将 environment(_:) 修饰符应用于父级，modelData 属性就会自动获取其值。@Environment 属性包装器使您能够读取当前视图的模型数据。添加 environment(_:) 修饰符会将数据对象传递到环境中。
        .environment(ModelData())
}



// 为什么 Landmarks 应用在视图中而不是在模型中定义已筛选的 Landmarks 数组？
// 因此，该应用可以轻松地在不同的窗口中显示不同的过滤列表。
