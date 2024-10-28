//
//  PlantModel.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 28/10/2024.
//

import Foundation
import SwiftData


@Model
class PlantModel {
    private(set) var name: String
    private var desc: String
    private(set) var location: houseLocation
    private(set) var frequency : Int
    private var water : String
    private var light:String
    private(set) var image: String
    private(set) var watered:Bool
    
    var module:PlantsModuleDataClass?
    
    init(name: String, desc: String = "",location:houseLocation = .bathroom, frequency: Int = 0, water: String = "", light: String = "", image: String = "",watered:Bool = false) {
        self.name = name
        self.desc = desc
        self.location = location
        self.frequency = frequency
        self.water = water
        self.light = light
        self.image = image
        self.watered = watered
    }
    
    func setName(a:String){
        self.name = a
    }
    func setDesc(a:String){
        self.desc = a
    }
    func setLocation(a:houseLocation){
        self.location = a
    }
    func setFrequency(a:Int){
        self.frequency = a
    }
    func setWater(a:String){
        self.water = a
    }
    func setImage(a:String){
        self.image = a
    }
    func toggleWatered(){
        watered.toggle()
    }
    
}

struct MockPlants {
    
    static let plantA = PlantModel(name: "Kvet",location: .kitchen, frequency: 3,watered: true)
    static let plantB = PlantModel(name: "Kvet A",location: .bathroom)
    static let plantC = PlantModel(name: "Kvet B",location: .diningRoom)
    static let plantD = PlantModel(name: "Kvet C",location: .bathroom)
    static let plantE = PlantModel(name: "Kvet D",location: .livingRoom)
    
    static let mockedPlants:[PlantModel] = [plantA,plantB,plantC,plantD,plantE]
}

struct DefaultPlants {
    static let monstera = PlantModel(name: "Monstera",desc: "Kvet monstera, známy ako „monstera deliciosa“, je obľúbená izbová rastlina s veľkými listami a charakteristickými otvormi. Pôvodom je z tropických oblastí Strednej a Južnej Ameriky. Kvitne zriedkavo a je známa svojou estetikou a schopnosťou čistiť vzduch. Jej starostlivosť je jednoduchá.",image: "bird.fill")
    
    static let orchidea = PlantModel(name: "Orchidea",desc: "Orchidea je exotická rastlina známa svojimi pôsobivými kvetmi, ktoré sa vyskytujú v širokej palete farieb a tvarov. Väčšina orchideí pochádza z tropických oblastí, kde rastú na stromoch (epifyticky) alebo v pôde. Vyžadujú vysokú vlhkosť a jemné, rozptýlené svetlo, čo im pripomína prostredie dažďových pralesov. Orchidey sú symbolom krásy, elegancie a lásky a vďaka svojej dlhej životnosti kvetov sú obľúbenými izbovými rastlinami po celom svete.",image: "cat.fill")
    
    static let presetPlants:[PlantModel] = [monstera,orchidea,monstera]
}
