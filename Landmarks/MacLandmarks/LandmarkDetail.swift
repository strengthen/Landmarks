//
//  ProfileHost.swift
//  Landmarks
//
//  Created by strengthen on 2025/1/1.
//

import SwiftUI
import MapKit

// 在 MacLandmarks 组中创建一个名为 LandmarkDetail 的新自定义视图，该视图针对 macOS。
// 现在您有三个名为 LandmarkDetail 的文件。每个文件在视图层次结构中都具有相同的用途，但提供针对特定平台量身定制的体验。

struct LandmarkDetail: View {
    // 将 iOS 详细视图内容复制到 macOS 详细视图中。
    // 预览失败，因为 macOS 中没有 navigationBarTitleDisplayMode(_:) 方法。
    @Environment(ModelData.self) var modelData
    var landmark: Landmark

    var landmarkIndex: Int {
        modelData.landmarks.firstIndex(where: { $0.id == landmark.id })!
    }

    var body: some View {
        @Bindable var modelData = modelData

        ScrollView {
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                MapView(coordinate: landmark.locationCoordinate)
                    .frame(height: 300)
                // 在 ZStack 中添加“在地图中打开”按钮，使其显示在地图右上角。确保包含 MapKit，以便能够创建发送到地图的 MKMapItem。
                Button("Open in Maps") {
                    let destination = MKMapItem(placemark: MKPlacemark(coordinate: landmark.locationCoordinate))
                    destination.name = landmark.name
                    destination.openInMaps()
                }
                .padding()
            }
            // 将 MapView 下方的所有内容放在 VStack 中，然后将 CircleImage 和其余标题放在 HStack 中。
            VStack(alignment: .leading, spacing: 20) {
                HStack(spacing: 24) {
                    // 为图像添加一个 resizable() 修饰符，并将 CircleImage 限制得稍微小一些。
                    CircleImage(image: landmark.image.resizable())
                        .frame(width: 160, height: 160)
                    // 您将在接下来的几个步骤中进行的更改将改善 Mac 更大显示屏的布局。
                    // 将保存停放和状态的 HStack 更改为具有前导对齐的 VStack，并移除 Spacer。
                    VStack(alignment: .leading) {
                        HStack {
                            Text(landmark.name)
                                .font(.title)
                            FavoriteButton(isSet: $modelData.landmarks[landmarkIndex].isFavorite)
                            // 将“收藏夹”按钮更改为使用普通按钮样式。在此处使用普通样式可使按钮看起来更像 iOS 版按钮。
                                .buttonStyle(.plain)
                        }

                        VStack(alignment: .leading) {
                            Text(landmark.park)
                            Text(landmark.state)
                        }
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    }
                }

                Divider()

                Text("About \(landmark.name)")
                    .font(.title2)
                Text(landmark.description)
            }
            .padding()
            .frame(maxWidth: 700)
            // 从圆中移除偏移，并将较小的偏移应用到整个 VStack。
            .offset(y: -50)
        }
        .navigationTitle(landmark.name)
    }
}

#Preview {
    let modelData = ModelData()
    return LandmarkDetail(landmark: modelData.landmarks[0])
        .environment(modelData)
    // 删除 navigationBarTitleDisplayMode(_:) 修饰符并向预览添加一个框架修饰符，以便您可以看到更多内容。
        .frame(width: 850, height: 700)
}
