//
//  PlantsOnboarding.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 06/12/2024.
//

import SwiftUI

struct PlantsOnboarding: View {
        @State var currentPage = 0
        @Environment(\.dismiss) var dismiss
        @State var lastPageSeen:Bool = false
        var body: some View {
            ZStack {
                Color.lightGreen
                    .ignoresSafeArea()
                VStack{
                    TabView {
                        ForEach(plantsPages) { page in
                            
                            VStack{
                                Image(page.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: page.imageWidth == 0 ? 200 : page.imageWidth, height: page.imageHeight == 0 ? 200 : page.imageHeight)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                  
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
                                      UserDefaults.standard.set(false, forKey: "isPlantsOnboarding")
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

let plantsPages:[Pages] = [
    Pages(title: "Welcome to Plants Module", description: "Need to monitor and water your plants ? Let me show you how it works!", imageName: "aloe-vera"),
    Pages(title: "Add your plants", description: "Add your plants to the list by clicking the + button.\n Choose from a preset or add one yourself.",imageName: "plantOnboarding2", imageHeight: 300,imageWidth: 300, isLastPage: false),
    Pages(title: "Preset or Custom", description: "We added some of the most popular plants, but you can also add your own", imageName: "plantOnboarding3",imageHeight: 350,imageWidth: 350, isLastPage: false),
    Pages(title: "All set!", description: "Remember, everything is still work in progress, so please let us know anything that might improve the experience. Thanks a lot!", imageName: "thanks", isLastPage: true)
]


#Preview {
    PlantsOnboarding()
}
