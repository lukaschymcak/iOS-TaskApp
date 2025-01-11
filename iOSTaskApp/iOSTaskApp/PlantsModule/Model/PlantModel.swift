////
//  PlantModel.swift
//  iOSTaskApp
//
//  Created by Lukas Chymcak on 28/10/2024.
//

import Foundation
import SwiftData


@Model
class PlantModel:Hashable,Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    private(set) var name: String
    private var desc: String
    private(set) var location: houseLocation
    private(set) var frequency : Int
    private(set) var water : String
    private(set) var light:String
    private(set) var temp:String
    private(set) var image: String
    private(set) var watered:Bool
    private(set) var prepared:Bool = false
    private(set) var waterDate:Date = Date.now
    private(set) var isCustom:Bool = false
    
    var module:PlantsModuleDataClass?
    
    init(name: String, desc: String = "",location:houseLocation = .bathroom, frequency: Int = 0, water: String = "", light: String = "",temp:String = "", image: String = "",watered:Bool = false,waterDate:Date = Date.now,isCustom:Bool = false) {
        self.name = name
        self.desc = desc
        self.location = location
        self.frequency = frequency
        self.water = water
        self.light = light
        self.temp = temp
        self.image = image
        self.watered = watered
        self.waterDate = waterDate
        self.isCustom = isCustom
        
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
    func setLight(a:String){
        self.light = a
    }
    func setTemp(a:String){
        self.temp = a
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
    func getWaterDate() -> Date {
        return self.waterDate
    }
        func prepare(){
            self.prepared = true
        }
        func unPrepare(){
            self.prepared = false
        }
        func waterPlantAndIncreaseDate() {
                if let dateIncrease = Calendar.current.date(
                    byAdding: .day, value: frequency,
                    to: waterDate)
                {
                    setWaterDate(a: dateIncrease)
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
    static let monstera = PlantModel(name: "Monstera",desc: NSLocalizedString("monsterra_desc", comment: ""),water:"300", light: NSLocalizedString("monsterra_light", comment: ""),temp: "18-29°C" ,image: "monstera")
    
    static let orchidea = PlantModel(name: "Orchidea",desc: NSLocalizedString("orchidea_desc", comment: ""),water:"100", light:NSLocalizedString("orchidea_light", comment: ""),temp: "18-29°C" ,image: "orchid")
    
    static let zzPlant = PlantModel(name: "ZZ Plant",desc: NSLocalizedString("zzPlant_desc", comment: ""),water:"250", light: NSLocalizedString("zzPlant_light", comment: ""),temp: "18-29°C" ,image: "zz-plant")
    static let snakePlant = PlantModel(
        name: "Snake Plant",
        desc: NSLocalizedString("snakePlant_desc", comment: ""),
        water: "300",
        light: NSLocalizedString("snakePlant_light", comment: ""),
        temp: "15-27°C",
        image: "snake-plant"
    )
    static let spiderPlant = PlantModel(
        name: "Spider Plant",
        desc: NSLocalizedString("spiderPlant_desc", comment: ""),
        water: "300",
        light: NSLocalizedString("spiderPlant_light", comment: ""),
        temp: "15-24°C",
        image: "spider-plant"
    )
    static let aloeVera = PlantModel(
        name: "Aloe Vera",
        desc: NSLocalizedString("aloeVera_desc", comment: ""),
        water: "200",
        light: NSLocalizedString("aloeVera_light", comment: ""),
        temp: "13-27°C",
        image: "aloe-vera"
    )
    static let africanViolet = PlantModel(
        name: "African Violet",
        desc: NSLocalizedString("africanViolet_desc", comment: ""),
        water: "200",
        light: NSLocalizedString("africanViolet_light", comment: ""),
        temp: "18-24°C",
        image: "african-violet"
    )
    
    static let plantImages = ["monstera","orchid","zz-plant","snake-plant","spider-plant","aloe-vera","african-violet"]
    
    static let presetPlants:[PlantModel] = [monstera,orchidea,zzPlant,snakePlant,spiderPlant,aloeVera,africanViolet]
}



