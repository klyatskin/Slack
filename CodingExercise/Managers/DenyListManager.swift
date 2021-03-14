//
//  DenyListManager.swift
//  CodingExercise
//
//  Copyright © 2021 slack. All rights reserved.
//

import Foundation


class DenyListManager {
    
    static let shared = DenyListManager()
    private var deniedList = WordTrie()
    
    
    private var listFilePath: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory.appendingPathComponent("denyList.plist")
    }

    
    private init() {
        loadList()
    }

    
    func loadList() {
        if FileManager.default.fileExists(atPath: listFilePath.path) {
            guard let savedList = NSKeyedUnarchiver.unarchiveObject(withFile: listFilePath.path) as? WordTrie else {
                    initListFromTxt()
                    return
            }
            deniedList = savedList
        } else {
            initListFromTxt()
        }
    }
    
    
    func initListFromTxt() {
        guard
            let url = Bundle.main.url(forResource: "denylist", withExtension: "txt"),
            let data = try? Data(contentsOf: url) else {
                return
            }
        let string = String(decoding: data, as: UTF8.self).lowercased()
        let keys = string.components(separatedBy: "\n")
        for key in keys {
            if key.count != 0 {
                deniedList.insert(key)
            }
        }
    }
    
    
    func saveList() {
        print("Deny list saved to \(listFilePath.path)")
        NSKeyedArchiver.archiveRootObject(deniedList, toFile: listFilePath.path)
 
    }
    
    
    func addToList(string: String) {
        deniedList.insert(string.lowercased())
    }
  
    
    func isDenied(string: String) -> Bool {
        let deny = deniedList.hasPrefix(for:string.lowercased())
        if (deny) {
            print("Denied")
        }
        return deny
    }
    
    
}
