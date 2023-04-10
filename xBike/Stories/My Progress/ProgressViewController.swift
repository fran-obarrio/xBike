//
//  ViewController.swift
//  xBike
//
//  Created by Francisco Obarrio on 16/02/2023.
//

import UIKit
import SnapKit

class ProgressViewController: UIViewController {

    var coordinator: ProgressCoordinator?
    
    public lazy var viewModel: ProgressViewModel = {
        let viewModel = ProgressViewModel()
        return viewModel
    }()
    
    private lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProgressCell.self, forCellReuseIdentifier: String(describing: ProgressCell.self))
        tableView.separatorColor = .clear
        return tableView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func setupNavigationBar() {
        navigationBarOrange()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
}

