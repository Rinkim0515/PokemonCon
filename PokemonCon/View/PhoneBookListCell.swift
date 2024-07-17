//
//  subViewcontroller.swift
//  PokemonCon
//
//  Created by bloom on 7/15/24.
//

import UIKit
import SnapKit
import Kingfisher

class PhoneBookListCell: UITableViewCell {
  static let id0 = "ListCell"
  private let img: UIImageView = {
    let iv = UIImageView()
    iv.backgroundColor = .white
    iv.layer.cornerRadius = 30
    iv.layer.borderColor = UIColor.black.cgColor
    iv.layer.borderWidth = 1
    iv.clipsToBounds = true
    return iv
    
  }()
  private let nameLabel: UILabel = {
    let lb = UILabel()
    lb.text = "name"
    lb.textAlignment = .right
    lb.textColor = UIColor.black
    return lb
  }()
  private let phoneNumberLabel = {
    let lb = UILabel()
    lb.text = "010-0000-0000"
    lb.textColor = .black
    lb.textAlignment = .left
    return lb
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    configureUI()
    
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // delegate datasource의연결 X / count 0이라 그릴필요없다
  
  func setData(phoneBook: PhoneBook){
    self.nameLabel.text = phoneBook.name
    self.phoneNumberLabel.text = phoneBook.phoneNumber
    self.img.kf.setImage(with: URL(string: phoneBook.imgURL ?? "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/132.png" ))
    
  }
  
  
  private func configureUI() {
    
    [ img,
      nameLabel,
      phoneNumberLabel
    ].forEach{contentView.addSubview($0)}
    
    img.snp.makeConstraints{
      $0.leading.equalTo(contentView).offset(16)
      $0.top.equalTo(contentView).offset(10)
      $0.bottom.equalTo(contentView).offset(-10)
      $0.width.equalTo(60)
    }
    nameLabel.snp.makeConstraints{
      $0.leading.equalTo(img.snp.trailing).offset(16)
      $0.centerY.equalTo(contentView)
    }
    phoneNumberLabel.snp.makeConstraints{
      $0.trailing.equalTo(contentView).inset(30)
      $0.centerY.equalTo(contentView)
    }
  }
  
  
  
  
  

}
