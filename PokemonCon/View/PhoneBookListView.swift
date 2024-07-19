//
//  MainView.swift
//  PokemonCon
//
//  Created by bloom on 7/17/24.
//

import Foundation
import UIKit
import SnapKit

class PhoneBookListView: UIView { // PhoneBookListView

  let tableView = UITableView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureTableViewUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureTableViewUI() {
    tableView.rowHeight = 80
    addSubview(tableView)
    tableView.snp.makeConstraints{
      $0.edges.equalTo(self.safeAreaLayoutGuide)
      
    }
  }
  
}
