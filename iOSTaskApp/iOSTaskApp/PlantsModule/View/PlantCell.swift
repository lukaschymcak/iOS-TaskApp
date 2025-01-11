//
//  PlantCell.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 28/10/2024.
//

import SwiftUI

struct PlantCell: View {
    @EnvironmentObject var plantsVM: PlantsModuleViewModel
    @State var plantCell: PlantModel
    @State var showWaterAlert: Bool = false
    @State var showDeletePlantAlert: Bool = false
    @State var alertMessage: String = ""
    var body: some View {
        GeometryReader { GeometryProxy in
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.lightGreen)

                HStack {
                    VStack(alignment: .leading) {
                        HStack(spacing: 1) {
                            Image("\(plantCell.image)")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .padding()
                            VStack(alignment: .leading, spacing: 5) {
                                Text(plantCell.location.localizedString())
                                    .font(.footnote)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.lightCream)
                                    .padding(0)
                                Text(plantCell.name)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.lightCream)
                                    .lineLimit(1)
                                HStack {
                                    Image(systemName: "drop")
                                        .fontWeight(.bold)
                                        .foregroundStyle(.lightCream)
                                    Text(
                                        plantCell.getWaterDate(),
                                        format: .dateTime.month().day()
                                    )
                                    .font(.title2)
                                    .foregroundStyle(.lightCream)
                                }

                            }
                            Spacer()
                            VStack(spacing: 10) {
                                Button {
                                    showDeletePlantAlert.toggle()

                                } label: {
                                    HStack {
                                        Text(showDeletePlantAlert.description)

                                    }.frame(width: 0, height: 0)
                                    Image(systemName: "minus")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.lightCream)
                                        .offset(x: -3)
                                }
                                .alert(isPresented: $showDeletePlantAlert) {
                                    Alert(
                                        title: Text(LocalizedStringKey("Remove Plant ?")),
                                        primaryButton: .destructive(
                                            Text(LocalizedStringKey("Confirm")),
                                            action: {
                                                plantsVM.toast = Toast(
                                                    style: .success,
                                                    message: NSLocalizedString("Plant Removed", comment: ""),
                                                    doOutsideFunctonImage: "")
                                                plantsVM.selectedModule
                                                    .removePlant(a: plantCell)

                                            }), secondaryButton: .cancel())
                                }
                                wateringButton

                            }

                        }.frame(maxWidth: .infinity, alignment: .leading)

                    }

                }

            }.frame(width: GeometryProxy.size.width - 10)
                .frame(height: 120)
                .frame(maxWidth: .infinity, alignment: .center)
        }

    }
    @ViewBuilder
    var wateringButton: some View {

        if Calendar.current.isDateInToday(plantCell.waterDate)
            || plantCell.waterDate.isBeforeToday()
        {
            Button {
                if plantCell.waterDate.isBeforeToday() {
                    showWaterAlert.toggle()

                } else {
                    plantCell.toggleWatered()
                    plantCell.waterPlantAndIncreaseDate()
                    plantsVM.toast = Toast(
                        style: .success, message: NSLocalizedString("Plant Watered", comment: ""),
                        doOutsideFunctonImage: "arrow.uturn.backward")
                    plantsVM.selectedPlants = plantCell
          
                }
            } label: {
                HStack {
                    Text(showWaterAlert.description)

                }.frame(width: 0, height: 0)
                Image(
                    systemName: plantCell.watered
                        ? "checkmark.circle" : "drop.circle"
                )
                .font(.system(size: 50))
                .foregroundStyle(.lightCream)
            }.padding(.horizontal)
                .alert(LocalizedStringKey("Water ?"), isPresented: $showWaterAlert, actions: {
                    
                    Button(LocalizedStringKey("Yes")) {
                        plantCell.toggleWatered()
                        plantCell.waterPlantAndIncreaseDate()
                        plantsVM.toast = Toast(
                            style: .success, message: NSLocalizedString("Plant Watered", comment: ""),
                            doOutsideFunctonImage:
                                "arrow.uturn.backward")
                        plantsVM.selectedPlants = plantCell
                
                    }
                    Button("No", role: .cancel) {
                    }
                }, message: {
                    Text(LocalizedStringKey("You forgot to water this plant , once watered next watering date will be calculated from today"))
                })
                .disabled(plantCell.watered)
        } else {
            Image(
                systemName: "clock"
            )
            .font(.system(size: 50))
            .foregroundStyle(.lightCream)
            .padding(.horizontal)
        }
    }

}


