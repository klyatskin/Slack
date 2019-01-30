//
//  SlackAPIService.swift
//  CodingExercise
//
//  Copyright © 2018 slack. All rights reserved.
//

import Foundation

// MARK: - Interfaces

protocol SlackAPIInterface {
    /*
     * Fetches users from search.team API that match the search term
     */
    func fetchUsers(_ searchTerm: String, completionHandler: @escaping ([UserSearchResult]) -> Void)
}

class SlackApi: SlackAPIInterface {
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?

    private let baseURLString =  "https://slack-users.herokuapp.com/search"

    /**
     A global shared SlackApi Instance.
     */
    static public let shared: SlackApi = SlackApi()

    /**
     Fetch Slack users based on a given search term.

     Parameter searchTerm: A string to match users against.
     Parameter completionHandler: The closure invoked when fetching is completed and the user search results are given.
    */
    func fetchUsers(_ searchTerm: String, completionHandler: @escaping ([UserSearchResult]) -> Void) {
        dataTask?.cancel()

        if var urlComponents = URLComponents(string: baseURLString) {
            let queryItemQuery = URLQueryItem(name: "query", value: searchTerm)
            urlComponents.queryItems = [queryItemQuery]

            guard let url = urlComponents.url else { return }
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil }

                if let error = error {
                    NSLog("Request failed with error: \(error.localizedDescription)")
                    completionHandler([])
                } else if let data = data, let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                    print(String(data: data, encoding: .utf8)!)
                    let decoder = JSONDecoder()
                    do {
                        let result = try decoder.decode(SearchResponse.self, from: data)
                        completionHandler(result.users)
                    } catch { NSLog("Decoding failed with error: \(error.localizedDescription)") }
                }
            }
            dataTask?.resume()
        }
    }
}
