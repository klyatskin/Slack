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
    func fetchUsers(_ searchTerm: String?, completionHandler: @escaping ([UserSearchResult]) -> Void)

    /*
     * Updates usernames according to given update string.
     */
    func updateSearchText(text: String?)

    /*
    * Returns a username at the given position.
    */
    func user(at index: Int) -> UserSearchResult

    /*
     * Returns the count of the current usernames array.
     */
    func usernamesCount() -> Int

    /*
     Delegate that allows to send data updates through callback.
 */
    var delegate: AutocompleteViewModelDelegate? { get set }
}

class AutocompleteViewModel: AutocompleteViewModelInterface {
    
    private let resultsDataProvider: UserSearchResultDataProviderInterface
    private var users: [UserSearchResult] = []
    public weak var delegate: AutocompleteViewModelDelegate?

    init(dataProvider: UserSearchResultDataProviderInterface) {
        self.resultsDataProvider = dataProvider
    }

    func updateSearchText(text: String?) {
        self.fetchUsers(text) { [weak self] users in
            DispatchQueue.main.async {
                self?.users = users
                self?.delegate?.usersDataUpdated()
            }
        }
    }

    func usernamesCount() -> Int {
        return users.count
    }

    func user(at index: Int) -> UserSearchResult {
        return users[index]
    }
    

    func fetchUsers(_ searchTerm: String?, completionHandler: @escaping ([UserSearchResult]) -> Void) {
        guard let term = searchTerm, !term.isEmpty else {
            completionHandler([])
            return
        }
        self.resultsDataProvider.fetchUsers(term) { users in
            completionHandler(users)
        }
    }
}
