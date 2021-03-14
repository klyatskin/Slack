//
//  WordTrie.swift
//  CodingExercise
//
//  Created by Konstantin Klyatskin on 2021-03-14.
//  Copyright © 2021 slack. All rights reserved.
//

import Foundation


class WordTrie: NSObject, NSCoding {
    
    private var root = TrieNode()

// MARK: - encoding

    func encode(with coder: NSCoder) {
        coder.encode(root, forKey: "root")
    }
    
    
    required init?(coder: NSCoder) {
        root = coder.decodeObject(forKey: "root") as! TrieNode
    }
    
    
    override init() {
        super.init()
    }

// MARK: - tree operations


    func insert(_ word: String) {
        insert(characters: Array(word))
    }

    
    func hasPrefix(for word: String) -> Bool {
        var node = root
        for character in Array(word) {
            if let child = node.getChildFor(character) {
                node = child
                if node.isFinal {
                    return true
                }
            } else {
                return false
            }
        }
        return false
    }
    
    
    private func insert(characters: [Character]) {
        var node = root
        node.prefixCount += 1
        for character in characters {
            node = node.getOrCreateChildFor(character)
            node.prefixCount += 1
        }
        node.isFinal = true //
    }
    
}




