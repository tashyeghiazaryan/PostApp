//
//  CustomPicker.swift
//  PostApp
//
//  Created by Artashes Yeghiazaryan on 25.11.2024.
//

import SwiftUI

struct CustomPicker<SelectionValue: Hashable, Content: View>: View {
    @Namespace var nameSpace
    @Binding var selection: SelectionValue
    @ViewBuilder let content: Content

    public var body: some View {
        let contentMirror = Mirror(reflecting: content)
        let blocksCount = Mirror(reflecting: contentMirror.descendant("value")!).children.count
        
        HStack {
            ForEach(0..<blocksCount, id: \.self) { index in
                let tupleBlock = contentMirror.descendant("value", ".\(index)")
                let contentText = Mirror(reflecting: tupleBlock!).descendant("content") as! Text
                let tag = Mirror(reflecting: tupleBlock!).descendant("modifier", "value", "tagged") as! SelectionValue

                Button {
                    selection = tag
                } label: {
                    contentText
                        .frame(width: UIScreen.main.bounds.width / 2)
                }
                .background(
                    Group {
                        if tag == selection {
                            Color.white.frame(height: 4)
                                .matchedGeometryEffect(id: "selector", in: nameSpace)
                        }
                    },
                    alignment: .bottom
                )
                .accentColor(.white)
                .animation(.easeInOut(duration: 0.3))
            }
        }
    }
}
