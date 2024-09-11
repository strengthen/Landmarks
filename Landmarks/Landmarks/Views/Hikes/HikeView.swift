//
//  HikeView.swift
//  Landmarks
//
//  Created by strengthen on 2025/1/1.
//

import SwiftUI

extension AnyTransition {
    // 将刚刚添加的过渡提取为 AnyTransition 的静态属性，并在视图的过渡修饰符中访问新属性。当您扩展自定义转换时，这会让您的代码保持整洁。
    static var moveAndFade: AnyTransition {
        // 使用 asymmetric(insertion:removal:) 修饰符为视图出现和消失时提供不同的转换。
        .asymmetric(
            // 切换到使用 move(edge:) 转换，以便图形从同一侧滑入和滑出。
            insertion: .move(edge: .trailing).combined(with: .opacity),
            removal: .scale.combined(with: .opacity)
        )
    }
}

struct HikeView: View {
    var hike: Hike
    @State private var showDetail = false

    var body: some View {
        VStack {
            HStack {
                HikeGraph(hike: hike, path: \.elevation)
                    .frame(width: 50, height: 30)

                VStack(alignment: .leading) {
                    Text(hike.name)
                        .font(.headline)
                    Text(hike.distanceText)
                }

                Spacer()

                Button {
                    // 将对 showDetail.toggle() 的调用与对 withAnimation 函数的调用结合起来。
                    // 受 showDetail 属性影响的两个视图（公开按钮和 HikeDetail 视图）现在都有动画转换。
                    withAnimation {
                        showDetail.toggle()
                    }

                    // 将一个四秒长的根本动画传递给 withAnimation 函数。您可以将相同类型的动画传递给与 animation(_:value:) 修饰符相同的 withAnimation 函数。
                    // withAnimation(.easeInOut(duration: 4)) {
                    //     showDetail.toggle()
                    // }
                } label: {
                    Label("Graph", systemImage: "chevron.right.circle")
                        .labelStyle(.iconOnly)
                        .imageScale(.large)
                        .rotationEffect(.degrees(showDetail ? 90 : 0))
                    // 尝试通过在 scaleEffect 修改器上方添加另一个动画修改器来关闭旋转动画。尝试一下 SwiftUI。尝试组合不同的动画效果，看看有什么可能。
                    // .animation(nil, value: showDetail)
                    // 当图形可见时，通过使按钮变大来添加另一个可动画的变化。
                    // 动画修改器适用于其包装的视图内的所有可动画的变化。
                        .scaleEffect(showDetail ? 1.5 : 1)
                        .padding()
                    // 在 HikeView 中，通过添加从 showDetail 值的变化开始的动画修改器来打开按钮旋转的动画。
                    // .animation(.easeInOut, value: showDetail)
                    // 将动画类型从 easeInOut 更改为 spring()。SwiftUI 包含具有预定义或自定义缓动的基本动画，以及弹簧动画和流体动画。您可以调整动画的速度、设置动画开始前的延迟或指定动画重复。
                    // .animation(.spring(), value: showDetail)
                }
            }

            if showDetail {
                HikeDetail(hike: hike)
                // 将刚刚添加的过渡提取为 AnyTransition 的静态属性，并在视图的过渡修饰符中访问新属性。当您扩展自定义转换时，这会让您的代码保持整洁。
                    .transition(.moveAndFade)
                // 向有条件可见的 HikeView 添加 transition（_:) 修饰符。现在，图形通过滑入和滑出视线而出现和消失。
                // .transition(.slide)
            }
        }
    }
}

#Preview {
    VStack {
        HikeView(hike: ModelData().hikes[0])
            .padding()
        Spacer()
    }
}
