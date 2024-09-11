//
//  LandmarkRow.swift
//  Landmarks
//
//  Created by strengthen on 2025/1/1.
//

// 更新改善了 macOS 的外观，但您还需要考虑使用该列表的其他平台。首先考虑 watchOS。

import SwiftUI
// 共享的 LandmarkRow 视图在 macOS 中有效，但值得重新审视，以寻找在新的视觉环境中有所改进的方法。由于此视图在所有三个平台上都使用，因此您需要小心，确保您所做的任何更改都适用于所有平台。
struct LandmarkRow: View {
    // 加landmark为的存储属性。
    // 当您添加该landmark属性时，画布中的预览将停止工作，因为该类型在初始化期间需要一个地标实例。LandmarkRow
    var landmark: Landmark

    var body: some View {
        // 将现有的文本视图嵌入到中HStack。
        HStack {
            //  在Text视图前面添加一个图片视图
            landmark.image
                .resizable()
                .frame(width: 50,height: 50)
            // 打开 LandmarkRow 并为图像添加角半径，以获得更精致的外观。
                .cornerRadius(5)

            // 将地标名称包装在 VStack 中，并将公园添加为次要信息。
            VStack(alignment: .leading) {
                // 修改文本视图以使用该landmark属性的name。
                Text(landmark.name)
                    .bold()
                // 返回 LandmarkRow 并添加 #if 条件以防止次要文本出现在 watchOS 版本中。对于该行，使用条件编译是合适的，因为差异很小。
#if !os(watchOS)
                Text(landmark.park)
                    .font(.caption)
                    .foregroundStyle(.secondary)
#endif
            }
            // 在Text视图后面添加Spacer视图,
            // 通过在文本视图前添加图像并在其后添加分隔符来完成该行。
            Spacer()
            // 在空白占位后面添加一个if表达式，if表达式判断是否当前地标是用户喜欢的，如果用户标记当前地标为喜欢就显示星标。可以在SwitUI的代码块中使用if语句来条件包含视图
            if landmark.isFavorite { // 在 SwiftUI 块中，您可以使用if语句有条件地包含视图。
                Image(systemName: "star.fill")
                // 由于系统图片是矢量类型的，可以使用foregroundColor(_:)来改变它的颜色。当地标landmark的isFavorite属性为真时，星标显示，稍后会讲怎么修改属性值。
                    .foregroundStyle(.yellow)
            }
        }
        // 在行内容周围添加垂直填充，使每行有更多的空间。
        .padding(.vertical, 4)
    }
}

// 将该行的两个版本包装在 中Group。
#Preview {
    //    // Group是用于对视图内容进行分组的容器。Xcode 会将该组的子视图堆叠起来，在画布中呈现为一个预览。
    //    Group {
    //        LandmarkRow(landmark: landmarks[0])
    //        LandmarkRow(landmark: landmarks[1])
    //    }

    // 更新 LandmarkRow 预览以使用 ModelData 对象。
    let landmarks = ModelData().landmarks
    return Group {
        LandmarkRow(landmark: landmarks[0])
        LandmarkRow(landmark: landmarks[1])
    }
}


//// 为每个预览指定一个名称以帮助区分它们。
//#Preview("Turtle Rock") {
//    //添加landmark属性做为LandmarkRow视图的一个存储属性。当添加landmark属性后，预览视图可能会停止工作，因为LandmarkRow视图初始化时需要有一个landmark实例。要想修复预览视图，需要修改Preview Provider
//    // 在LandmarkRow_Previews的静态属性previews中给LandmarkRow初始化器中传入landmark参数，这个参数使用landmarkData数组的第一个元素。预览视图当前显示Hello, World
//    LandmarkRow(landmark: landmarks[0])
//}
//
//// 画布一次只显示一个预览，但您可以定义多个预览并在画布中选择。或者，您可以将视图组合在一起以创建视图多个版本的单个预览。
//// 添加使用数组中第二个元素的第二个预览宏landmarks。
//// 为每个预览指定一个名称以帮助区分它们。
//#Preview("Salmon") {
//    // 添加预览可以让您看到视图如何处理不同的数据。
//    // 默认情况下，画布标签使用其出现的行号进行预览。
//    LandmarkRow(landmark: landmarks[1])
//}
