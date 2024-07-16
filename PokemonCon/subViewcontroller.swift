//
//  subViewcontroller.swift
//  PokemonCon
//
//  Created by bloom on 7/15/24.
//

import UIKit
import SnapKit

class subview: UITableViewCell {
    private let img: UIImageView = {

        let imgView = UIImageView()

        imgView.image = UIImage(named: "icon")
        imgView.backgroundColor = .white
        imgView.layer.cornerRadius = 30
        imgView.layer.borderColor = UIColor.black.cgColor
        imgView.layer.borderWidth = 1

        return imgView

    }()
    private let nameLabel: UILabel = {

        let label = UILabel()

        label.text = "name"
        label.textAlignment = .right

        label.textColor = UIColor.black
        

        return label

    }()
    private let phoneNumberLabel = {
        let label = UILabel()
        label.text = "010-0000-0000"
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureUI()

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
    


        

    required init?(coder aDecoder: NSCoder) {

        fatalError("init(coder:) has not been implemented")

    }
}
