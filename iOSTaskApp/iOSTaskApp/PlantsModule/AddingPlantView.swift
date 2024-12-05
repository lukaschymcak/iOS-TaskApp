//
//  AddingPlantView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 28/10/2024.
//

import SwiftUI

struct AddingPlantView: View {
    @EnvironmentObject var plantsModule: PlantsModuleHomeView.ViewModel
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @State var cancelHit: Bool = false
    @State var presetView: Bool = true
    @State var addingCustomPlant: Bool = false
    var body: some View {

        NavigationStack {
            ZStack {

                Color(hex: "FEFAE0")
                
                .ignoresSafeArea()
                VStack {
                    VStack {
                
                            Text("Choose from a preset")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(Color(hex: "D19252"))
                                .padding(.top, 30)
                                .multilineTextAlignment(.leading)

                            ScrollView {
                                VStack(spacing: 20) {
                                    ForEach(DefaultPlants.presetPlants) {
                                        plant in
                                        NavigationLink {

                                            PresetAddView(
                                                plantModel: plant,
                                                cancelHit: $cancelHit
                                            )
                                            .onDisappear {
                                                if !cancelHit {

                                                    dismiss()
                                                }
                                            }
                                            .navigationBarBackButtonHidden(true)
                                        } label: {
                                            PresetViewCell(plantCell: plant)
                                        }

                                    }
                                }.padding(.top, 20)
                             
                             

                            }.frame(height: 500)

                      
                        Spacer()
                    }
                    Button {
                        addingCustomPlant.toggle()
                    } label: {

                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(hex: "9DA091").opacity(0.4))
                                
                                .frame(
                                    maxWidth: .infinity,
                                    alignment: .center
                                )
                                .frame(height: 80)
                                .padding()
                                .overlay {
                                    HStack {
                                        Image(systemName: "pencil")
                                            .font(.largeTitle)
                                            .fontWeight(.bold)
                                            .foregroundStyle(.white)
                                        Text("Add a custom plant")
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .foregroundStyle(.white)
                                    }
                                }
                        
                    }

                    VStack {
                        Button {
                            dismiss()
                        } label: {

                            RoundedRectangle(cornerRadius: 20)
                                .fill(.clear)
                                .frame(width: 250, height: 60)
                                .overlay {
                                    HStack(alignment: .center, spacing: 5) {
                                        Image(systemName: "house.fill")
                                            .font(.largeTitle)
                                            .fontWeight(.bold)
                                            .foregroundStyle(
                                                Color(hex: "D19252"))
                                        Text("Go Home")
                                            .font(.largeTitle)
                                            .fontWeight(.bold)
                                            .foregroundStyle(
                                                Color(hex: "D19252"))

                                    }

                                }
                        }.padding(.bottom, 30)
                        Spacer()
                    }
                    
                }
            }.sheet(isPresented: $addingCustomPlant) {
                AddingCustomPlantView(cancelHit: $cancelHit)
                    .environmentObject(plantsModule)
                    
            }
        }
    }
}


#Preview {
    AddingPlantView()
}
