//
//  LandmarkDetail.swift
//  Landmarks
//
//  Created by strengthen on 2025/1/1.
//

import SwiftUI
// 更改设备选择器以使预览显示小型手表。
// 通过针对最大和最小的表盘进行测试，您可以看到您的应用缩放以适应显示屏的效果如何。与往常一样，您应该在所有受支持的设备尺寸上测试您的用户界面。
struct LandmarkDetail: View {
    // 将 modelData、landmark 和 skylineIndex 属性添加到新的 LandmarkDetail 结构中。这些属性与您在处理用户输入中添加的属性相同。
    @Environment(ModelData.self) var modelData
    var landmark: Landmark

    var landmarkIndex: Int {
        modelData.landmarks.firstIndex(where: { $0.id == landmark.id })!
    }

    var body: some View {
        @Bindable var modelData = modelData
        // 将垂直堆栈包裹在滚动视图中。这会打开视图滚动，但会产生另一个问题：圆形图像现在会扩展到全尺寸，并且会调整其他 UI 元素的大小以匹配图像大小。您需要调整圆形图像的大小，以便屏幕上只显示圆形和地标名称。
        ScrollView {
            // 将圆形图像嵌入 VStack。在图像下方显示地标名称及其信息。如您所见，信息不太适合手表屏幕，但您可以通过将 VStack 放置在滚动视图中来解决这个问题。
            VStack {
                // 从 body() 方法返回 CircleImage 视图。在这里，您可以重用 iOS 项目中的 CircleImage 视图。由于您创建了一个可调整大小的图像，因此对 scaledToFill() 的调用会调整圆圈的大小，使其填满显示屏。
                CircleImage(image: landmark.image.resizable())
                // 将 scaleToFill() 更改为 scaleToFit() 并添加填充。这会缩放圆形图像以匹配显示屏的宽度，并确保地标名称在圆形图像下方可见。
                    .scaledToFit()

                Text(landmark.name)
                    .font(.headline)
                    .lineLimit(0)

                Toggle(isOn: $modelData.landmarks[landmarkIndex].isFavorite) {
                    Text("Favorite")
                }

                Divider()

                Text(landmark.park)
                    .font(.caption)
                    .bold()
                    .lineLimit(0)

                Text(landmark.state)
                    .font(.caption)
                // 在分隔线后添加 MapView。地图显示在屏幕外，但您可以向下滚动查看。
                Divider()
                MapView(coordinate: landmark.locationCoordinate)
                    .scaledToFit()
            }
            .padding(16)
        }
        // 为后退按钮添加标题。这会将后退按钮的文本设置为“地标”。
        .navigationTitle("Landmarks")
    }
}

#Preview {
    // 在预览中，创建模型数据的实例，并使用它将地标对象传递给 LandmarkDetail 结构的初始化程序。您还需要设置视图的环境。
    let modelData = ModelData()
    return LandmarkDetail(landmark: modelData.landmarks[0])
        .environment(modelData)
}
