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
    private(set) var desc: String
    private(set) var location: houseLocation
    private(set) var frequency : Int
    private(set) var water : Int
    private var light:String
    private(set) var image: String
    private(set) var watered:Bool
    
    var module:PlantsModuleDataClass?
    
    init(name: String, desc: String = "",location:houseLocation, frequency: Int, water: Int, light: String = "", image: String = "",watered:Bool = false) {
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
    func setWater(a:Int){
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
    
    static let plantA = PlantModel(name: "Kvet",location: .kitchen, frequency: 3, water: 250)
    static let plantB = PlantModel(name: "Kvet A",location: .bathroom, frequency: 4, water: 300)
    static let plantC = PlantModel(name: "Kvet B",location: .diningRoom, frequency: 2, water: 500)
    static let plantD = PlantModel(name: "Kvet C",location: .bathroom, frequency: 1, water: 150)
    
    static let mockedPlants:[PlantModel] = [plantA,plantB,plantC,plantD]
}


