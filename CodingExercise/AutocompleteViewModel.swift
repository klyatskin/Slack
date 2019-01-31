//
//  AutocompleteViewModel.swift
//  CodingExercise
//
//  Copyright © 2018 slack. All rights reserved.
//

import Foundation

protocol AutocompleteViewModelDelegate: class {
    func usersDataUpdated()
}

// MARK: - Interfaces
protocol AutocompleteViewModelInterface {
    /*
     * Fetches users from that match a given a search term
     */
    func fetchUserNames(_ searchTerm: String?, completionHandler: @escaping () -> Void)

    /*
     * Updates usernames according to given update string.
     */
    func updateSearchText(text: String?)

    /*
    * Returns the list of usernames according to the last update.
    */
    func getUsernames() -> [String]
}

class AutocompleteViewModel: AutocompleteViewModelInterface {
    private let resultsDataProvider: UserSearchResultDataProviderInterface
    private var usernames: [String] = []
    public weak var delegate: AutocompleteViewModelDelegate?

    init(dataProvider: UserSearchResultDataProviderInterface) {
        self.resultsDataProvider = dataProvider
    }

    func updateSearchText(text: String?) {
        fetchUserNames(text) { [weak self] in
            DispatchQueue.main.async {
                self?.delegate?.usersDataUpdated()
            }
        }
    }

    func getUsernames() -> [String] {
        return usernames
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
