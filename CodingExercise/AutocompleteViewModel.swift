//
//  AutocompleteViewModel.swift
//  CodingExercise
//
//  Copyright © 2018 slack. All rights reserved.
//

import Foundation

class AutocompleteViewModel {
    private let resultsDataProvider: UserSearchResultDataProviderInterface
    public var usernames: [String] = []

    init(dataProvider: UserSearchResultDataProviderInterface) {
        self.resultsDataProvider = dataProvider
    }

    func fetchUserNames(_ searchTerm: String?, completionHandler: @escaping () -> Void) {
        guard let term = searchTerm, !term.isEmpty else {
            usernames.removeAll()
            completionHandler()
            return
        }
        
        self.resultsDataProvider.fetchUsers(term) { [weak self] users in
            self?.usernames = users.map { $0.username }
            completionHandler()
        }
    }
}
