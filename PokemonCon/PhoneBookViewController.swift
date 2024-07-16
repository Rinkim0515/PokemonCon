//
//  PhoneBookViewController.swift
//  PokemonCon
//
//  Created by bloom on 7/15/24.
//

import UIKit

class PhoneBookViewController: UIViewController {
    let imageLabel = {
        let img = UIImageView()
        return img
    }()
    let randomBtn = {
        let btn = UIButton()
        btn.setTitle("랜덤 이미지 생성", for: .normal)
        return  btn
    }()
    let nameTextLabel = {
        let lb = UITextView()
        return lb
    }()
    let numTextLabel = {
        let lb = UITextView()
        return lb
    }()
    
    
}
