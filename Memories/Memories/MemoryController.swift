//
//  MemoryController.swift
//  Memories
//
//  Created by Andrew Liao on 8/1/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import Foundation

class MemoryController {
    
    //MARK: - Persistence
    func saveToPersistentStore(){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(memories)
            guard let fileURL = persistentFileURL else {return}
            try data.write(to: fileURL)
        } catch {
            NSLog("Trouble Encoding")
        }

    }
    
    func loadFromPersistentStore(){
        let decoder = PropertyListDecoder()
        let fm = FileManager()
        
        guard let fileURL = persistentFileURL, fm.fileExists(atPath: fileURL.path) else {return}
        
        do{
            //try using contents(atPath:) later
            let data = try Data(contentsOf: fileURL)
            memories = try decoder.decode([Memory].self, from: data)
        } catch {
            NSLog("Trouble Decoding")
        }
    }
    
    //MARK: - CRUD
    
    func createMemory(withTitle title: String, bodyText: String, imageData: Data){
        let newMemory = Memory(title: title, bodyText: bodyText, imageData: imageData)
        memories.append(newMemory)
        saveToPersistentStore()
    }
    
    func update(for memory: Memory, title: String, bodyText: String, imageData: Data){
        guard let index = memories.index(of:memory) else {return}
        
        memories[index].title = title
        memories[index].bodyText = bodyText
        memories[index].imageData = imageData
        
        saveToPersistentStore()
    }
    
    func delete(memory: Memory){
        guard let index = memories.index(of:memory) else {return}
        memories.remove(at: index)
        saveToPersistentStore()
    
    }
    //MARK: - Properties
    var persistentFileURL: URL? {
        let fm = FileManager()
        
        //We used a guard let here in class. Why do I not need it?
        let documentDir = fm.urls(for: .documentDirectory, in: .userDomainMask).first
        let filename = "memories.plist"
        
        return documentDir?.appendingPathComponent(filename)
        
    }
    private(set) var memories = [Memory]()
}
