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
    * Returns a username at the given position.
    */
    func username(at index: Int) -> String

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

    func usernamesCount() -> Int {
        return usernames.count
    }

    func username(at index: Int) -> String {
        return usernames[index]
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
