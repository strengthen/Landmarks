//
//  ProfileHost.swift
//  Landmarks
//
//  Created by strengthen on 2025/1/1.
//
import SwiftUI

/*
 接下来，在 Views 组下创建一个名为 Profiles 的新组，然后向该组添加一个名为 ProfileHost 的视图，该视图带有一个显示已存储个人资料用户名的文本视图。
 ProfileHost 视图将托管个人资料信息的静态摘要视图和编辑模式。
 注意：您将此处的 draftProfile 设置为默认个人资料作为占位符，直到稍后引入模型数据个人资料。
*/
struct ProfileHost: View {
    /*
     添加一个环境视图属性，该属性由环境的 \.editMode 决定。
     SwiftUI 在环境中提供存储，用于存储您可以使用 @Environment 属性包装器访问的值。之前，您使用 @Environment 检索存储在环境中的类。在这里，您可以使用它来访问内置于环境中的 editMode 值，以读取或写入编辑范围。
     */
    @Environment(\.editMode) var editMode
    //从环境中读取用户的个人资料数据，将数据的控制权传递给个人资料主机。为了避免在确认任何编辑（例如用户输入姓名时）之前更新全局应用状态，编辑视图在其自身的副本上运行。
    @Environment(ModelData.self) var modelData
    @State private var draftProfile = Profile.default

    var body: some View {
        // 更新 ProfileHost 以显示新的摘要视图。
        VStack(alignment: .leading, spacing: 20) {
            // 创建一个编辑按钮，用于打开和关闭环境 editMode 值。编辑按钮控制您在上一步中访问的相同 editMode 环境值。
            HStack {
                // 向 ProfileHost 添加一个取消按钮。与 EditButton 提供的“完成”按钮不同，“取消”按钮不会在其闭包中将编辑应用于实际的配置文件数据。
                if editMode?.wrappedValue == .active {
                    Button("Cancel", role: .cancel) {
                        draftProfile = modelData.profile
                        editMode?.animation().wrappedValue = .inactive
                    }
                }
                Spacer()
                EditButton()
            }

            // 添加一个条件视图，显示静态配置文件或编辑模式视图。您可以通过运行实时预览并点击编辑按钮来查看进入编辑模式的效果。目前，编辑模式视图只是一个静态文本字段。
            if editMode?.wrappedValue == .inactive {
                ProfileSummary(profile: modelData.profile)
            } else {
                ProfileEditor(profile: $draftProfile)
                // 应用 onAppear(perform:) 和 onDisappear(perform:) 修饰符，以使用正确的配置文件数据填充编辑器，并在用户点击“完成”按钮时更新持久配置文件。否则，下次激活编辑模式时将显示旧值。
                    .onAppear {
                        draftProfile = modelData.profile
                    }
                    .onDisappear {
                        modelData.profile = draftProfile
                    }
            }
        }
        .padding()
    }
}

#Preview {
    ProfileHost()
    /*
     选择 ProfileHost 并将模型数据作为环境属性添加到预览中。
     尽管此视图不使用带有 @Environment 属性包装器的属性，但此视图的子级 ProfileSummary 却使用了该属性。因此，如果没有修饰符，预览将失败。
     */
        .environment(ModelData())
}
