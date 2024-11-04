////
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
    private(set) var prepared:Bool = false
    private(set) var waterDate:Date = Date.now
    
    var module:PlantsModuleDataClass?
    
    init(name: String, desc: String = "",location:houseLocation = .bathroom, frequency: Int = 0, water: String = "", light: String = "", image: String = "",watered:Bool = false,waterDate:Date = Date.now) {
        self.name = name
        self.desc = desc
        self.location = location
        self.frequency = frequency
        self.water = water
        self.light = light
        self.image = image
        self.watered = watered
        self.waterDate = waterDate
    }
    
    func setName(a:String){
        self.name = a
    }
    func getDesc() -> String{
       return self.desc
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
        self.watered = true
    }
    func toggleNotWatered(){
        self.watered = false
    }
    func setWaterDate(a:Date){
        self.waterDate = a
    }
    
    func prepare(){
        self.prepared = true
    }
    func unPrepare(){
        self.prepared = false
    }
    func waterPlant() {
        if Calendar.current.isDate(waterDate, inSameDayAs: Date.now) {
            toggleWatered()
            if let dateIncrease = Calendar.current.date(
                byAdding: .day, value: frequency,
                to: waterDate)
            {
                setWaterDate(a: dateIncrease)
            }
        }
        
    }
    
    
    
}

struct MockPlants {
    
    static let plantA = PlantModel(name: "Kvet",location: .kitchen, frequency: 3,watered: true)
    static let plantB = PlantModel(name: "Kvet A",location: .bathroom)
    static let plantC = PlantModel(name: "Kvet B",location: .diningRoom)
    static let plantD = PlantModel(name: "Kvet C",location: .bathroom)
    static let plantE = PlantModel(name: "Kvet D",location: .livingRoom)
    
    static let mockedPlants:[PlantModel] = [plantA,plantB,plantC,plantD,plantE,plantA,plantA]
}

struct DefaultPlants {
    static let monstera = PlantModel(name: "Monstera",desc: "Kvet monstera, známy ako „monstera deliciosa“, je obľúbená izbová rastlina s veľkými listami a charakteristickými otvormi. Pôvodom je z tropických oblastí Strednej a Južnej Ameriky. Kvitne zriedkavo a je známa svojou estetikou a schopnosťou čistiť vzduch.",image: "monstera")
    
    static let orchidea = PlantModel(name: "Orchidea",desc: "Orchidea je exotická rastlina známa svojimi pôsobivými kvetmi, ktoré sa vyskytujú v širokej palete farieb a tvarov. Väčšina orchideí pochádza z tropických oblastí, kde rastú na stromoch (epifyticky) alebo v pôde. Vyžadujú vysokú vlhkosť a jemné, rozptýlené svetlo, čo im pripomína prostredie dažďových pralesov. Orchidey sú symbolom krásy, elegancie a lásky a vďaka svojej dlhej životnosti kvetov sú obľúbenými izbovými rastlinami po celom svete.",image: "orchid")
    
    static let zzPlant = PlantModel(name: "ZZ Plant",desc: "The ZZ plant (Zamioculcas zamiifolia) is a hardy, low-maintenance indoor plant known for its glossy, dark green leaves and upright, wand-like stems. Native to East Africa, it's drought-tolerant and thrives in low to bright indirect light. This plant is popular for its ability to withstand neglect, making it ideal for beginners or low-light spaces. The ZZ plant also has air-purifying qualities and can grow up to 2-3 feet indoors with minimal watering.",image: "zz-plant")
    
    static let presetPlants:[PlantModel] = [monstera,orchidea,zzPlant]
}
