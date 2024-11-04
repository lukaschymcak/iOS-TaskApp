//
//  AddingPlantView.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 28/10/2024.
//

import SwiftUI

struct AddingPlantView: View {
    @State var plantsModule: PlantsModuleDataClass
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @State var cancelHit: Bool = false
    @State var presetView: Bool = true
    var body: some View {

        NavigationStack {
            ZStack {

                Color(hex: "FEFAE0")
                
                .ignoresSafeArea()
                VStack {
                    VStack {
                        if presetView {
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
                                                plantModule: plantsModule,
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
                                GeometryReader { GeometryProxy in
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color(hex: "9DA091").opacity(0.4))

                                        .frame(
                                            width: GeometryProxy.size.width
                                                - 50, height: 80
                                        )
                                        .frame(
                                            maxWidth: .infinity,
                                            alignment: .center
                                        )
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

                            }.frame(height: 500)

                        } else {
                            Text("Add a plant")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .padding(.top, 20)

                        }
                        Spacer()
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
            }
        }
    }
}

struct addPresetPlant: View {
    var body: some View {
        Text("Hello")
    }
}
struct addCustomPlant: View {
    var body: some View {
        Text("Hello")
    }
}

#Preview {
    AddingPlantView(plantsModule: MockPlantsModule.moduleA)
}
