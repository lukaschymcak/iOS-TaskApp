//
//  ViewModifiers.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 01/12/2024.
//

import Foundation
import SwiftUI

struct DragToDelete: ViewModifier {
    @Binding var cardOffset: CGSize
    @State var showDeleteAlert: Bool = false
    var deleteAction: () -> Void
    
    
    func body(content: Content) -> some View {
        content
        .offset(x: cardOffset.width )
        .gesture(DragGesture().onChanged { gesture in
            if gesture.translation.width < 0 {
                cardOffset = gesture.translation
                if cardOffset.width < -150 {
                    withAnimation {
                        showDeleteAlert.toggle()
                        cardOffset = .zero
                    }
                }
                                      }
         
        }.onEnded({ _ in
            if cardOffset.width < -170 { print("less than \(cardOffset.width)")
                withAnimation {
                    showDeleteAlert.toggle()
                    cardOffset = .zero
                    
                    
                }
            } else {
                withAnimation {
                    cardOffset = .zero
                    
                }
            }
        })
        ).alert("Remove?", isPresented: $showDeleteAlert) {
            Button("Confirm", role: .destructive) {
                deleteAction()
            }
            
        }
    }
}

struct DeleteCardSlow: ViewModifier {
    @Binding var cardOffset: CGSize
    var customHeight: CGFloat
    
    func body(content: Content) -> some View {
        content
            .opacity(Double(abs(cardOffset.width / 150)))
            .frame(width: -cardOffset.width, height: customHeight)
            .overlay {
                Image(systemName: "trash")
                    .font(.title)
                    .opacity(Double(abs(cardOffset.width / 150)))
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
            }
    }
}

extension View {
    func dragToDelete(cardOffset: Binding<CGSize>, perform: @escaping () -> Void ) -> some View {
        self.modifier(DragToDelete(cardOffset: cardOffset,deleteAction: perform))
    }
    func deleteCardSlow(cardOffset: Binding<CGSize>,customHeight: CGFloat) -> some View {
        self.modifier(DeleteCardSlow(cardOffset: cardOffset,customHeight: customHeight))
    }

}
