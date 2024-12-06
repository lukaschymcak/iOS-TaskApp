//
//  PackingOnboarding.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 06/12/2024.
//

import SwiftUI

struct PackingOnboarding: View {
    @State var currentPage = 0
    @AppStorage("isOnboardingShown") var isOnboardingShown: Bool = true
    @Environment(\.dismiss) var dismiss
    @State var lastPageSeen:Bool = false
    var body: some View {
        ZStack {
            Color.darkBlue
                .ignoresSafeArea()
            VStack{
                TabView {
                    ForEach(packingpages) { page in
                        
                        VStack{
                            Image(page.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: page.imageWidth == 0 ? 200 : page.imageWidth, height: page.imageHeight == 0 ? 200 : page.imageHeight)
                              
                            Text(page.title)
                                .font(.system(size: 40))
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .padding(.vertical,5)
                                .multilineTextAlignment(.center)
                            Text(page.description)
                                .font(.title)
                                .foregroundStyle(.white)
                                .padding(.horizontal)
                                .padding(.vertical,5)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                       
                            if page.isLastPage {
                                Button {
                                    dismiss()
                                    isOnboardingShown = false
                                } label: {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(.white)
                                        .frame(width: 200, height: 50)
                                        .overlay {
                                            Text("Got it!")
                                                .font(.title)
                                                .fontWeight(.bold)
                                        }
                                        .padding()
                                }

                            }
                           
   
                        }
                 
                        
                    }
                }.tabViewStyle(PageTabViewStyle()).ignoresSafeArea()

              
                    
                
            }
        }
    }
}

struct PackingPages: Identifiable {
    var id = UUID()
    var title = ""
    var description = ""
    var imageName = ""
    var imageHeight: CGFloat = 0
    var imageWidth: CGFloat = 0
    var isLastPage = false
}

let packingpages = [
    PackingPages(title: "Welcome to the Packing Module", description: "Let me show you how it works!", imageName: "suitcase"),
    PackingPages(title: "Going on a trip ? ", description: "Here you can create a trip , set the date and start packing for it!", imageName: "tripOnboardPage2"),
    PackingPages(title: "Don't forget anything!", description: "Just create a bag , click on it , and start adding stuff!",imageName: "tripOnboardpage3", imageHeight: 450,imageWidth: 350),
    PackingPages(title: "Enjoy!", description: "Remember , everything is still work in progress , so please let us know anyhting that might improve the experience. Thanks a lot!", imageName: "thanks",isLastPage: true)
]
#Preview {
    PackingOnboarding()
}
