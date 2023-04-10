//
//  ProgressViewController+Delegate.swift
//  xBike
//
//  Created by Francisco Obarrio on 16/02/2023.
//

import UIKit

extension ProgressViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ProgressCell", for: indexPath) as? ProgressCell {
            cell.cellData = viewModel.tableData[indexPath.row]
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

