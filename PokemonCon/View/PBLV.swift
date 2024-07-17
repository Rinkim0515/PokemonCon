//
//  MainView.swift
//  PokemonCon
//
//  Created by bloom on 7/17/24.
//

import Foundation
import UIKit
import SnapKit

class PBLV: UIView { // PhoneBookListView

  let tableView = UITableView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureUI() {
    
    tableView.rowHeight = 80
    addSubview(tableView)
    
    tableView.snp.makeConstraints{
      $0.edges.equalTo(self.safeAreaLayoutGuide)
      
    }
  }
  
}
