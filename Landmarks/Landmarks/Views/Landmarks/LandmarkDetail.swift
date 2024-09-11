//
//  LandmarkDetail.swift
//  Landmarks
//
//  Created by strengthen on 2025/1/1.
//

import SwiftUI

// 从LandmarkDetail的子视图(CircleImage、MapView)开始，需要把它们都改造成为使用传入的数据进行展示，而不是在布局代码中写死数据展示
// ContentView属性的内容body从复制到。LandmarkDetail
struct LandmarkDetail: View {
    @Environment(ModelData.self) var modelData
    // 添加landmark属性。
    var landmark: Landmark

    // 通过将输入地标与模型数据进行比较来计算输入地标的索引。为了支持这一点，您还需要访问环境的模型数据。
    var landmarkIndex: Int {
        modelData.landmarks.firstIndex(where: { $0.id == landmark.id })!
    }

    var body: some View {
        // 在 body 属性中，使用 Bindable 包装器添加模型数据。
        @Bindable var modelData = modelData

        // body属性中嵌入一个VStack视图，它内部包含另一个VStack视图，内部的VStack视图又包含三个Text视图
        // 将容器从VStack更改为ScrollView
        ScrollView {
            // 在外层VStack的顶部添加自定义的地图视图MapView，并使用frame(width:height:)设置视图大小。当只指定高度时，宽度会自动计算为父视图的宽度，在这里就是屏幕宽度
            // 当您仅指定height参数时，视图将自动调整为内容的宽度。在这种情况下，视图将扩展以填充可用空间。MapView
            MapView(coordinate: landmark.locationCoordinate)
                .frame(height: 300).frame(height: 300)
            // 为了让图片视图叠放在地图视图的上面，可以设置图片视图的垂直偏移量为-130，图片视图的底部内边距也为-130，这个效果就是把图片垂直上移了130，同时和下面的文字区域留出了130的空白分隔区
            // 这些调整通过将图像向上移动来为文本腾出空间。
            CircleImage(image: landmark.image)
                .offset(y: -130)
                .padding(.bottom, -130)


            VStack(alignment: .leading) { // 嵌入到垂直栈中(Embed in VStack)
                // 使用新的 FavoriteButton 将地标名称嵌入 HStack；使用美元符号 ($) 提供与 isFavorite 属性的绑定。
                HStack {
                    Text(landmark.name)
                        .font(.title)  // 字体修改器为Title，使用系统字体修饰文字，可以自动按照用户在设备中设置的字体偏好大小进行调整。
                    // 将 LandmarkIndex 与 modelData 对象一起使用，以确保按钮更新存储在模型对象中的地标的 isFavorite 属性。
                    FavoriteButton(isSet: $modelData.landmarks[landmarkIndex].isFavorite)
                }

                HStack { // 嵌入到水平栈中(Embed in HStack)
                    Text(landmark.park)
                    Spacer() // 用来填充两个控件中间的空白部分，并把两个控件分别顶向屏幕的两侧。Spacer是一个可以伸缩的空白控件，他负责占用其它控件布局完成后剩下的所有空间。
                    Text(landmark.state)
                }
                .font(.subheadline) // 字体为子标题样式
                .foregroundStyle(.secondary)
                // 为地标添加分隔线和一些额外的描述性文字。
                Divider()
                Text("About \(landmark.name)")
                    .font(.title2)
                Text(landmark.description)
            }
            .padding()// 内容视图整体加内边距
            // 在外层VStack内部的最下面加上Spacer，可以让上面的视图内容顶到屏幕的上边
            // Spacer()
        }
        // 最后调用navigationBarTitle(_:displayMode:)修改器为地标详情页展示时在导航条上设置一个标题
        // 最后，调用修饰符在显示详细视图时为导航栏提供标题，并调用修饰符使标题以内联方式显示。
        .navigationTitle(landmark.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    // LandmarkDetail(landmark: landmarks[0])
    // 更新 Landmark Detail 视图以使用环境中的 Model Data 对象。
    // LandmarkDetail(landmark: ModelData().landmarks[0])

    let modelData = ModelData()
    return LandmarkDetail(landmark: modelData.landmarks[0])
        .environment(modelData)
}
