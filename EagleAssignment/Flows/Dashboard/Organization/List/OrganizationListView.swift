//
//  OrganizationListView.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 26.05.2024.
//

import UIKit

final class OrganizationListView: UIView {
  // MARK: - Properties
  @IBOutlet weak var tableView: UITableView!
  private var models: [EmployeeCardDisplayable] = []
  
  // MARK: - ViewLifeCycle
  override func awakeFromNib() {
    super.awakeFromNib()
    setupView()
  }
  
  // MARK: - Public Methods
  func fill(with models: [EmployeeCardDisplayable]) {
    self.models = models
    tableView.reloadData()
  }
  
  // MARK: - Private Methods
  private func setupView() {
    tableView.register(EmployeeTableViewCell.self)
    tableView.estimatedSectionHeaderHeight = .leastNonzeroMagnitude
  }
}

extension OrganizationListView: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    models.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: EmployeeTableViewCell = tableView.dequeueReusableCell(at: indexPath)
    cell.fill(with: models[indexPath.row])
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    .leastNonzeroMagnitude
  }
}
