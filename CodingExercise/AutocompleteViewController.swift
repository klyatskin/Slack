//
//  AutocompleteViewController.swift
//  CodingExercise
//
//  Copyright © 2018 slack. All rights reserved.
//

import UIKit

struct Constants {
    static let textFieldPlaceholder = "Search"
    static let cellIdentifier = "Cell"
    static let cellRowHeight: CGFloat = 50.0
    static let leftSpacing: CGFloat = 20.0
    static let bottomSpacing: CGFloat = 20.0
    static let rightSpacing: CGFloat = -20.0
}

class AutocompleteViewController: UIViewController {
    var viewModel: AutocompleteViewModel

    init(viewModel: AutocompleteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let searchTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.placeholder = Constants.textFieldPlaceholder
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let searchResultsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Constants.cellRowHeight
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let contentView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)

        searchResultsTableView.dataSource = self
        searchResultsTableView.delegate = self

        setupSubviews()
    }

    func setupSubviews() {
        contentView.addSubview(searchTextField)
        contentView.addSubview(searchResultsTableView)
        view.addSubview(contentView)

        setupConstraints()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentView.heightAnchor.constraint(equalToConstant: view.frame.height/3),

            searchTextField.topAnchor.constraint(equalTo: contentView.topAnchor),
            searchTextField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.leftSpacing),
            searchTextField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: Constants.rightSpacing),

            searchResultsTableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: Constants.bottomSpacing),
            searchResultsTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            searchResultsTableView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.leftSpacing),
            searchResultsTableView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: Constants.rightSpacing)
            ])
    }
}

extension AutocompleteViewController: UITextFieldDelegate {
    @objc func textFieldDidChange(textField: UITextField) {
        viewModel.fetchUserNames(searchTextField.text) { [weak self] in
            DispatchQueue.main.async {
                self?.searchResultsTableView.reloadData()
            }
        }
    }
}

extension AutocompleteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: Constants.cellIdentifier)
        cell.textLabel?.text = viewModel.usernames[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.usernames.count
    }
}
