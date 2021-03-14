//
//  TrieNode.swift
//  CodingExercise
//
//  Copyright © 2021 slack. All rights reserved.
//

import Foundation

class TrieNode: NSObject, NSCoding {
    
    var children: [String:TrieNode] = [:]
    var isFinal: Bool = false
    var prefixCount: Int = 0

// MARK: - encoding

    func encode(with coder: NSCoder) {
        coder.encode(children , forKey: "children")
        coder.encode(isFinal, forKey: "isFinal")
        coder.encode(prefixCount, forKey: "prefixCount")
    }
    
    required init?(coder: NSCoder) {
        children = coder.decodeObject(forKey: "children") as! [String:TrieNode]
        isFinal = coder.decodeBool(forKey: "isFinal")
        prefixCount = coder.decodeInteger(forKey: "prefixCount")
    }

    
    override init() {
        super.init()
    }

    
// MARK: - tree operations

    func createChildFor(_ character: Character) -> TrieNode {
        let node = TrieNode()
        children[String(character)] = node
        return node
    }
    

    func getOrCreateChildFor(_ character: Character) -> TrieNode {
        if let child = children[String(character)] {
           return child
        } else {
           return createChildFor(character)
        }
    }

    func getChildFor(_ character: Character) -> TrieNode? {
        if let child = children[String(character)] {
           return child
        } else {
           return nil
        }
    }

  
    
}

