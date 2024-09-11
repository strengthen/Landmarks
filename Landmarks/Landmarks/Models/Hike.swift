//
//  Hike.swift
//  Landmarks
//
//  Created by strengthen on 2025/1/1.
//

import Foundation

// 与 Landmark 结构一样，Hike 结构符合 Codable 并且具有与相应数据文件中的键匹配的属性。
struct Hike: Codable, Hashable, Identifiable {
    var id: Int
    var name: String
    var distance: Double
    var difficulty: Int
    var observations: [Observation]

    static var formatter = LengthFormatter()

    var distanceText: String {
        Hike.formatter
            .string(fromValue: distance, unit: .kilometer)
    }

    struct Observation: Codable, Hashable {
        var distanceFromStart: Double

        var elevation: Range<Double>
        var pace: Range<Double>
        var heartRate: Range<Double>
    }
}
