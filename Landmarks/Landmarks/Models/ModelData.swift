//
//  ModelData.swift
//  Landmarks
//
//  Created by strengthen on 2025/1/1.
//

import Foundation

// 要实现用户标记哪个地标为自己喜爱的地标这个功能，需要使用可观察对象(observalble object)存放地标数据
// 可观察对象是一种可以绑定到具体SwifUI视图环境中的数据对象。SwiftUI可以察觉它影响视图展示的任何变化，并在这种变化发生后及时更新对应视图的展示内容
// 使用宏声明一个新的模型类型Observable()。SwiftUI 仅当可观察属性发生变化且视图主体直接读取该属性时才会更新视图。
@Observable
class ModelData {
    // 将landmarks数组移入模型。可以使用 Command + Option + { 或 } 分别向上或向下移动选定的代码行。
    var landmarks: [Landmark] = load("landmarkData.json")
    // 将远足数组加载到模型中。
    var hikes: [Hike] = load("hikeData.json")
    // 更新 ModelData 类以包含用户配置文件的实例，该实例即使在用户关闭配置文件视图后仍然存在。
    var profile = Profile.default

    // 在 ModelData 中，添加一个新的计算特征数组，其中仅包含 isFeatured 设置为 true 的地标。
    var features: [Landmark] {
        landmarks.filter { $0.isFeatured }
    }
    
    // 在 ModelData 中，添加一个计算类别字典，其中类别名称作为键，并为每个键添加一个相关地标数组。
    var categories: [String: [Landmark]] {
        Dictionary(
            grouping: landmarks,
            by: { $0.category.rawValue }
        )
    }
}


// 创建一个地标数组，并从中初始化它。landmarkData.json
// var landmarks: [Landmark] = load("landmarkData.json")

// 创建一个load(_:)方法，从应用程序的主包中获取具有给定名称的 JSON 数据。
// 加载方法依赖于返回类型对Decodable协议的符合性，它是协议的一个组成部分Codable。
func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
