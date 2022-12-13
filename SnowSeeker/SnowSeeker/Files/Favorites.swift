//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Alpay Calalli on 02.12.22.
//

import Foundation

@MainActor class Favorites: ObservableObject {
    
    
    private var resorts: Set<String>
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")
    
    
    init(){
        do{
            let data = try Data(contentsOf: savePath)
            resorts = try JSONDecoder().decode(Set<String>.self, from: data)
        }catch{
            resorts = []
        }
    
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        do{
            let data = try JSONEncoder().encode(resorts)
            try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
            print("Data succesfully saved")
        }catch{
            print("Unable to save data")
        }
    }
}
