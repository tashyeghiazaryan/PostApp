//
//  BaseNavigationBar.swift
//  PostApp
//
//  Created by Artashes Yeghiazaryan on 26.11.2024.
//

import UIKit
import SwiftUI

struct BaseNavigationBar<SelectionValue: Hashable>: View {
    
    @Binding var selection: SelectionValue

    
    public var body: some View {
        HStack(spacing: 0) {

            CustomPicker(selection: $selection) {
                Text("My Posts").tag(0)
                Text("All Posts").tag(1)
            }
        }
    }
}

extension View {
    
    func toAnyView() -> AnyView {
        AnyView(self)
    }
    
    var customNavigation: some View {
        self.navigationBarColor(UIColor(Color.blue), textColor: UIColor.white)
            .navigationBarTitleDisplayMode(.inline)
            .accentColor(.white)
    }
}

public struct NavigationBarColorModifier: ViewModifier {
  var backgroundColor: UIColor
  var textColor: UIColor

  public init(backgroundColor: UIColor, textColor: UIColor) {
    self.backgroundColor = backgroundColor
    self.textColor = textColor
    let coloredAppearance = UINavigationBarAppearance()
    coloredAppearance.configureWithTransparentBackground()
    coloredAppearance.backgroundColor = .clear
    coloredAppearance.titleTextAttributes = [.foregroundColor: textColor]
    coloredAppearance.largeTitleTextAttributes = [.foregroundColor: textColor]

    UINavigationBar.appearance().standardAppearance = coloredAppearance
    UINavigationBar.appearance().compactAppearance = coloredAppearance
    UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    UINavigationBar.appearance().tintColor = .white
  }

  public func body(content: Content) -> some View {
    ZStack {
       content
        VStack {
          GeometryReader { geometry in
             Color(self.backgroundColor)
                .frame(height: geometry.safeAreaInsets.top)
                .edgesIgnoringSafeArea(.top)
              Spacer()
          }
        }
     }
  }
}

public extension View {
  func navigationBarColor(_ backgroundColor: UIColor, textColor: UIColor) -> some View {
    self.modifier(NavigationBarColorModifier(backgroundColor: backgroundColor, textColor: textColor))
  }
}
