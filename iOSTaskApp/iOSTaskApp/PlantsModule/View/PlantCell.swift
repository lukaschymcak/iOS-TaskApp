//
//  PlantCell.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 28/10/2024.
//

import SwiftUI

struct PlantCell: View {
    @EnvironmentObject var plantsModuleModel: PlantsModuleHomeView.ViewModel
    @State var plantCell: PlantModel
    @State var showWaterAlert: Bool = false
    @State var showDeletePlantAlert: Bool = false
    @State var alertMessage: String = ""
    var body: some View {
        GeometryReader { GeometryProxy in
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(hex: "697442"))

                HStack {
                    VStack(alignment: .leading) {
                        HStack(spacing: 1) {
                            Image("\(plantCell.image)")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .padding()
                            VStack(alignment: .leading, spacing: 5) {
                                Text(plantCell.location.rawValue)
                                    .font(.footnote)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color(hex: "FEFAE0"))
                                    .padding(0)
                                Text(plantCell.name)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color(hex: "FEFAE0"))
                                    .lineLimit(2)
                                HStack {
                                    Image(systemName: "drop")
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color(hex: "FEFAE0"))
                                    Text(
                                        plantCell.waterDate,
                                        format: .dateTime.month().day()
                                    )
                                    .font(.title2)
                                    .foregroundStyle(Color(hex: "FEFAE0"))
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
                                        .foregroundStyle(Color(hex: "FEFAE0"))
                                        .offset(x: -3)
                                }
                                .alert(isPresented: $showDeletePlantAlert) {
                                    Alert(
                                        title: Text("Remove Plant ?"),
                                        primaryButton: .destructive(
                                            Text("Confirm"),
                                            action: {
                                                plantsModuleModel.toast = Toast(
                                                    style: .success,
                                                    message: "Plant Removed",
                                                    doOutsideFunctonImage: "")
                                                plantsModuleModel.selectedModule
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
                    plantCell.prepare()
                    plantsModuleModel.toast = Toast(
                        style: .success, message: "Plant Watered",
                        doOutsideFunctonImage: "arrow.uturn.backward")
                    plantsModuleModel.selectedPlants = plantCell
                }
            } label: {
                HStack {
                    Text(showWaterAlert.description)

                }.frame(width: 0, height: 0)
                Image(
                    systemName: plantCell.prepared
                        ? "checkmark.circle" : "drop.circle"
                )
                .font(.system(size: 50))
                .foregroundStyle(Color(hex: "FEFAE0"))
            }.padding(.horizontal)
                .alert(isPresented: $showWaterAlert) {
                    Alert(
                        title: Text(
                            "You forgot to water this plant , once watered next watering date will be calculated from today"
                        ),
                        primaryButton: .destructive(
                            Text("Water"),
                            action: {
                                plantCell.prepare()
                                plantsModuleModel.toast = Toast(
                                    style: .success, message: "Plant Watered",
                                    doOutsideFunctonImage:
                                        "arrow.uturn.backward")
                                plantsModuleModel.selectedPlants = plantCell
                                plantCell.setWaterDate(a: Date())
                            }), secondaryButton: .cancel())
                }.disabled(plantCell.prepared)
        } else {
            Image(
                systemName: "clock"
            )
            .font(.system(size: 50))
            .foregroundStyle(Color(hex: "FEFAE0"))
            .padding(.horizontal)
        }
    }

}
