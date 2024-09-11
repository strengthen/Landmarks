//
//  MapView.swift
//  Landmarks
//
//  Created by strengthen on 2025/1/1.
//

import SwiftUI
// 当您在同一个文件中导入 SwiftUI 和某些其他框架时，您可以访问该框架提供的 SwiftUI 特定功能。
import MapKit

// 在静态模式下预览时，只会渲染swiftUI视图的部分，因为MKMapView是UIView的子类，所以需要切换到实时预览模式下才能看到地图被完全渲染出来
struct MapView: View {
    // 添加一个coordinate属性，并使用这个属性来替换写死的经纬度坐标
    // 此更改还会影响构建，因为详细视图有一个需要新参数的地图视图。您很快就会修复详细视图。
    var coordinate: CLLocationCoordinate2D

    // 添加一个名为 zoom 的 @AppStorage 属性，默认情况下采用中等缩放级别。
    // 使用唯一标识参数的存储键，就像在 UserDefaults 中存储项目时一样，因为这是 SwiftUI 所依赖的底层机制。
    @AppStorage("MapView.zoom")
    private var zoom: Zoom = .medium

    // 首先，在 MapView 中添加一个控件，将初始缩放比例设置为以下三个级别之一：近、中或远。
    // 在 MapView 中，添加一个 Zoom 枚举来描述缩放级别。
    enum Zoom: String, CaseIterable, Identifiable {
        case near = "Near"
        case medium = "Medium"
        case far = "Far"

        var id: Zoom {
            return self
        }
    }

    // 将用于构建区域属性的经度和纬度增量更改为取决于缩放的值。
    private var delta: CLLocationDegrees {
        switch zoom {
        case .near: return 0.02
        case .medium: return 0.2
        case .far: return 2
        }
    }

    var body: some View {
        // 默认视图:Map采用该区域初始化的相机位置的视图。
        // Map(initialPosition: .region(region))

        // 将地图的初始化程序更改为接受位置输入的初始化程序，以便它在值改变时更新。
        // 这个新的初始化程序需要指向Binding某个位置的 ，这是指向值的双向连接。.constant()在这里使用绑定是因为不需要检测何时有人通过与地图交互来更改位置。
        Map(position: .constant(.region(region)))
    }

    // 创建一个私有计算变量来保存地图的区域信息。
    private var region: MKCoordinateRegion {
        // 将用于构建区域属性的经度和纬度增量更改为取决于缩放的值。
        MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
        )
    }
}

#Preview {
    // Live Preview(实时预览)按钮，在实时预览模式下可以编辑视图，最新的改动也可以实时的刷新出来。
    // 在预览中看到一张以 Turtle Rock 为中心的地图。
    // 您可以在实时预览中操作地图，将其缩小一点，然后使用 Option-单击-拖动控件查看周围区域。
    // MapView()

    // 并传入每一个地标的经纬度数据
    MapView(coordinate: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868))

}
