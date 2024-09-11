//
//  Landmark.swift
//  Landmarks
//
//  Created by strengthen on 2025/1/1.
//

import Foundation
import SwiftUI
import CoreLocation

// 定义一个Landmark具有一些属性的结构，与数据文件landmarkData中某些键的名称匹配。
// 添加Codable一致性使得在结构和数据文件之间移动数据更加容易。您将在本节后面依赖协议Decodable的组件Codable从文件中读取数据。

// 声明Landmark类型遵循Identifiable协议，因为Landmark类型已经定义了id属性，正好满足Identifiable协议，所以不需要添加其它代码
struct Landmark: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var park: String
    var state: String
    var description: String
    // 添加属性
    // 该文件为每个地标都提供了一个同名的键。由于符合Codable，您可以通过创建与键同名的新属性来读取与键关联的值。
    var isFavorite: Bool
    // 接下来，您将在视图顶部添加特色地标。您需要从地标数据中获取更多信息才能执行此操作。
    // 在 Landmark 中，添加一个新的 isFeatured 属性。与您添加的其他地标属性一样，此布尔值已经存在于数据中 - 您只需要声明一个新属性。
    var isFeatured: Bool

    // 在 Landmark 中，向 Landmark 结构添加一个 Category 枚举和一个 Category 属性。
    // LandmarkData 文件已包含每个地标的类别值，其中包含三个字符串值之一。通过匹配数据文件中的名称，您可以依靠结构的 Codable 一致性来加载数据。
    var category: Category
    enum Category: String, CaseIterable, Codable {
        case lakes = "Lakes"
        case rivers = "Rivers"
        case mountains = "Mountains"
    }

    // 添加一个属性来从数据中读取图像的名称，以及一个从资产目录中加载图像的计算属性。
    // 将该属性设为私有，因为Landmarks结构的用户只关心图像本身。
    private var imageName: String
    var image: Image {
        Image(imageName)
    }

    // 向 Landmark 结构添加一个计算属性，如果存在则返回特征图像。
    var featureImage: Image? {
        isFeatured ? Image(imageName + "_feature") : nil
    }
    
    // 计算与 MapKit 框架交互有用的属性。locationCoordinate
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }

    // coordinates使用嵌套类型向结构添加一个属性Coordinates，该属性反映 JSON 数据结构中的存储。
    // 将此属性标记为私有，因为您将在下一步中仅使用它来创建公共计算属性。
    private var coordinates: Coordinates
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
}
