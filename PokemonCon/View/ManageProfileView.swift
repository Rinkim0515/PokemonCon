//
//  ManageProfileView.swift
//  PokemonCon
//
//  Created by bloom on 7/18/24.
//

import UIKit
import SnapKit

class ManageProfileView: UIView {
  let imageLabel = {
    let img = UIImageView()
    img.backgroundColor = .white
    img.layer.cornerRadius = 100
    img.clipsToBounds = true
    img.layer.borderWidth = 1
    img.layer.borderColor = UIColor.black.cgColor
    return img
  }()
  
   let randomBtn = {
    let btn = UIButton()
    btn.setTitle("랜덤 이미지 생성", for: .normal)
    btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    btn.titleLabel?.textColor = .gray
    btn.setTitleColor(.gray, for: .normal)
    
    return  btn
  }()
  
  let nameTextView = {
    let lb = UITextView()
    lb.layer.borderColor = UIColor.lightGray.cgColor
    lb.layer.borderWidth = 1
    lb.layer.cornerRadius = 10
    lb.textContainer.maximumNumberOfLines = 1
    lb.font = UIFont.systemFont(ofSize: 16)
    return lb
  }()
  
  let numTextView = {
    let lb = UITextView()
    lb.layer.borderColor = UIColor.lightGray.cgColor
    lb.layer.borderWidth = 1
    lb.layer.cornerRadius = 10
    lb.textContainer.maximumNumberOfLines = 1
    lb.font = UIFont.systemFont(ofSize: 16)
    return lb
  }()
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //protocol 통한 확장으로
  private func configureUI(){
    [
      imageLabel,
      randomBtn,
      nameTextView,
      numTextView
    ].forEach{self.addSubview($0)}
    
    
    imageLabel.snp.makeConstraints{
      $0.top.equalTo(safeAreaLayoutGuide).offset(30)
      $0.centerX.equalTo(safeAreaLayoutGuide)
      $0.width.equalTo(200)
      $0.height.equalTo(200)
    }
    randomBtn.snp.makeConstraints{
      $0.centerX.equalTo(safeAreaLayoutGuide)
      $0.top.equalTo(imageLabel.snp.bottom).offset(15)
      $0.width.equalTo(100)
      $0.height.equalTo(20)
    }
    nameTextView.snp.makeConstraints{
      $0.top.equalTo(randomBtn.snp.bottom).offset(15)
      $0.centerX.equalTo(safeAreaLayoutGuide)
      $0.height.equalTo(40)
      $0.width.equalTo(340)
      
    }
    numTextView.snp.makeConstraints{
      $0.top.equalTo(nameTextView.snp.bottom).offset(10)
      $0.centerX.equalTo(safeAreaLayoutGuide)
      $0.height.equalTo(40)
      $0.width.equalTo(340)
    }
  }
  
}
