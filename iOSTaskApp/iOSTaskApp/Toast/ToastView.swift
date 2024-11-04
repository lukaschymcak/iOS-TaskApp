//
//  ToastView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 27/10/2024.
//

import Foundation
import SwiftUI

struct ToastView: View {
    
    
    var style: ToastStyle
    var message: String
    var width = CGFloat.infinity
    let doOutsideFunction: () -> Void
    var doOutsideFunctonImage: String
    var onCancelTapped: (() -> Void)
    
    
    var body: some View {
      HStack(alignment: .center, spacing: 12) {
        Image(systemName: style.iconFileName)
              .foregroundColor(.white)
        Text(message)
              .font(.title3)
              .fontWeight(.bold)
          .foregroundColor(Color.white)
          .multilineTextAlignment(.leading)
        
        Spacer(minLength: 10)
          Button {
              doOutsideFunction()
              onCancelTapped()
          } label: {
              Image(systemName: doOutsideFunctonImage)
                  .foregroundColor(.white)
          }.padding(.horizontal,10)
        Button {
          onCancelTapped()
        } label: {
          Image(systemName: "xmark")
                .foregroundColor(.white)
        }
      }
      .padding()
      .frame(minWidth: 0, maxWidth: width)
      .background(Color.green)
      .cornerRadius(8)
      .overlay(
        RoundedRectangle(cornerRadius: 8)
          //.stroke(style.themeColor, lineWidth: 0.5)
          .stroke(style.themeColor, lineWidth: 1)
          .opacity(0.6)
          //.glow(color: style.themeColor, radius: 4)
      )
      .padding(.horizontal, 16)
    }
  }

extension View {

    func toastView(toast: Binding<Toast?>,someAction: @escaping () -> Void) -> some View {
        self.modifier(ToastModifier(toast: toast,someAction:someAction))
  }
}
