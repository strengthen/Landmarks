//
//  CircleImage.swift
//  Landmarks
//
//  Created by strengthen on 2025/1/1.
//

import SwiftUI

// 直接新建：[Fie] - [New] - [New Empty File]
// 弹框新建：[Fie] - [New] - [File From Template]
struct CircleImage: View {
    // 添加一个存储属性，命名为image。这是一种在构建SwiftUI视图中很常用的模式，常常会包裹或封装一些属性修改器。
    var image: Image

    var body: some View {
        image.clipShape(Circle()) // 给图片添加圆形剪切效果，Circle是一个形状，它可以被用作遮罩、也可以是圆圈，还可以是圆形填充视图。
            .overlay{
                // 把圆形边框的颜色改成白色
                Circle().stroke(.white, lineWidth: 4) // 创建另一个灰色的圆圈并把它作为一个浮层添加到图片上，相当于给图片加了一个灰色边框
            }
            .shadow(radius: 7) // ，添加一个半径为 7 点的阴影。
    }
}

#Preview {
    // 更新预览以传递 Turtle Rock 的图像。
    // 尽管您已经修复了预览逻辑，但由于构建失败，预览仍无法更新。实例化圆形图像的详细视图也需要一个输入参数。
    CircleImage(image: Image("turtlerock"))
}
