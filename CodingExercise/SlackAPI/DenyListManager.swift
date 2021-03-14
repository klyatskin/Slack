//
//  DenyListManager.swift
//  CodingExercise
//
//  Copyright © 2021 slack. All rights reserved.
//

import Foundation


class DenyListManager {
    
    
    
    static let shared = DenyListManager()
    private var deniedList: [String: Int] = [:]
    
    
    private var listFilePath: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory.appendingPathComponent("denyList.plist")
    }

    
    private init() {
        loadList()
    }

    
    func loadList() {
        guard let savedList = NSKeyedUnarchiver.unarchiveObject(withFile: listFilePath.path) as? [String:Int] else {
                initListFromTxt()
                return
        }
        deniedList = savedList
    }
    
    
    func initListFromTxt() {
        guard
            let url = Bundle.main.url(forResource: "denylist", withExtension: "txt"),
            let data = try? Data(contentsOf: url) else {
            deniedList = [:]
                return
            }
        let string = String(decoding: data, as: UTF8.self).lowercased()
        let keys = string.components(separatedBy: "\n")
        for key in keys {
            if key.count != 0 {
                deniedList[key] = 1
            }
        }
    }
    
    
    func saveList() {
        print("Deny list saved to \(listFilePath.path)")
        NSKeyedArchiver.archiveRootObject(deniedList, toFile: listFilePath.path)
 
    }
    
    
    
    func isDenied(string: String) -> Bool {
        var prefix = ""
        for c in string.lowercased() {
            prefix = prefix + String(c)
            if (deniedList[prefix] != nil) {
                print("Denied as \(prefix)")
                return true
            }
        }
        return false
    }
    
    
    func addToList(string: String) {
        deniedList[string.lowercased()] = 1
    }
    
}
