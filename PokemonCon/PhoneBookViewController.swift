//
//  PhoneBookViewController.swift
//  PokemonCon
//
//  Created by bloom on 7/15/24.
//

import UIKit
import SnapKit
import CoreData
import Kingfisher

class PhoneBookViewController: UIViewController {
  
  static var container: NSPersistentContainer!
  
  lazy var apiURL = ""
  
  var imgUrl: String = ""
  
  
  let imageLabel = {
    let img = UIImageView()
    img.backgroundColor = .white
    img.layer.cornerRadius = 100
    img.layer.borderWidth = 1
    img.layer.borderColor = UIColor.black.cgColor
    return img
  }()
  lazy var randomBtn = {
    let btn = UIButton()
    btn.setTitle("랜덤 이미지 생성", for: .normal)
    btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    btn.titleLabel?.textColor = .gray
    btn.setTitleColor(.gray, for: .normal)
    btn.addTarget(self, action: #selector(changeImage), for: .touchDown)
    
    return  btn
  }()
  let nameTextLabel = {
    let lb = UITextView()
    lb.layer.borderColor = UIColor.lightGray.cgColor
    lb.layer.borderWidth = 1
    lb.layer.cornerRadius = 10
    lb.textContainer.maximumNumberOfLines = 1
    lb.font = UIFont.systemFont(ofSize: 16)
    return lb
  }()
  let numTextLabel = {
    let lb = UITextView()
    lb.layer.borderColor = UIColor.lightGray.cgColor
    lb.layer.borderWidth = 1
    lb.layer.cornerRadius = 10
    lb.textContainer.maximumNumberOfLines = 1
    lb.font = UIFont.systemFont(ofSize: 16)
    return lb
  }()
  
  override func viewDidLoad() {
    view.backgroundColor = .white
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    PhoneBookViewController.container = appDelegate.persistentContainer
    configureUI()
  }
  
  
  func configureUI(){
    
    let applyBtn = UIBarButtonItem(title: "적용", style: .plain, target: self, action: #selector(apply))
    self.navigationItem.rightBarButtonItem = applyBtn
    
    self.title = " 연락처 추가 "
    [
      imageLabel,
      randomBtn,
      nameTextLabel,
      numTextLabel
    ].forEach{view.addSubview($0)}
    
    
    imageLabel.snp.makeConstraints{
      $0.top.equalToSuperview().offset(120)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(200)
      $0.height.equalTo(200)
    }
    randomBtn.snp.makeConstraints{
      $0.centerX.equalToSuperview()
      $0.top.equalTo(imageLabel.snp.bottom).offset(15)
      $0.width.equalTo(100)
      $0.height.equalTo(20)
    }
    nameTextLabel.snp.makeConstraints{
      $0.top.equalTo(randomBtn.snp.bottom).offset(15)
      $0.centerX.equalToSuperview()
      $0.height.equalTo(40)
      $0.width.equalTo(340)
      
    }
    numTextLabel.snp.makeConstraints{
      $0.top.equalTo(nameTextLabel.snp.bottom).offset(10)
      $0.centerX.equalToSuperview()
      $0.height.equalTo(40)
      $0.width.equalTo(340)
    }
  }
  
  private func makeRandomImage(){ // use kingfisher
    imgUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(Int.random(in: 0...1000)).png"
    let url = URL(string: imgUrl)
    imageLabel.kf.setImage(with: url)
    
  }
  
 
  //원본
//  private func fetchData<T: Decodable>(url: URL, completion: @escaping (T?) -> Void) {
//    let session = URLSession(configuration: .default)
//    print(url)
//    session.dataTask(with: URLRequest(url: url)) { data, response, error in
//      guard let data = data, error == nil else {
//        print("데이터 로드 실패")
//        completion(nil)
//        return
//      }
//      // http status code 성공 범위.
//      let successRange = 200..<300
//      if let response = response as? HTTPURLResponse, successRange.contains(response.statusCode) {
//        print(response.statusCode)
//        
//        guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
//          
//          print("JSON 디코딩 실패")
//          completion(nil)
//          return
//        }
//        completion(decodedData)
//      } else {
//        print("응답 오류")
//        completion(nil)
//      }
//    }.resume()
//  }
//  
//  
//  
//  private func fetchPokeImg() {
//    
//    var urlComponents = URLComponents(string: apiURL + "\(Int.random(in: 0...1000))")
//    imgUrl = urlComponents?.string ?? "none"
//    
//    guard let url = urlComponents?.url else {
//      print("잘못된 URL")
//      return
//    }
//    
//    fetchData(url: url) { [weak self] (result: PokemonModel?) in
//      guard let self, let result else { return }
//      // UI 작업은 메인 쓰레드에서 작업
//      
//      guard let frontDefault = result.sprites.frontDefault, let imageUrl = URL(string: frontDefault) else { return }
//      print(imageUrl)
//      // image 를 로드하는 작업은 백그라운드 쓰레드 작업
//      if let data = try? Data(contentsOf: imageUrl) {
//        if let image = UIImage(data: data) {
//          // 이미지뷰에 이미지를 그리는 작업은 UI 작업이기 때문에 다시 메인 쓰레드에서 작업.
//          DispatchQueue.main.async {
//            self.imageLabel.image = image
//          }
//        }
//      }
//    }
//  }
  //
  
  
  
  @objc func changeImage(){
    
    makeRandomImage()
  }
  
  func createData(name:String, phoneNumber:String, image: String){
    guard let entity = NSEntityDescription.entity(forEntityName: "PhoneBook", in: PhoneBookViewController.container.viewContext) else { return }
    let newPhoneBook = NSManagedObject(entity: entity, insertInto: PhoneBookViewController.container.viewContext)
    newPhoneBook.setValue(name, forKey: "name")
    newPhoneBook.setValue(phoneNumber, forKey: "phoneNumber")
    newPhoneBook.setValue(image, forKey: "imgURL")
    do {
      try PhoneBookViewController.container.viewContext.save()
      print("Success")
    } catch {
      print("Failure:\(error)")
    }
    
    
  }
  
  func deleteData(name: String) {
    let fetchRequest = PhoneBook.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "name == %@", name)
    
    do {
      let result = try? PhoneBookViewController.container.viewContext.fetch(fetchRequest)
      
      for data in result! as [NSManagedObject] {
        PhoneBookViewController.container.viewContext.delete(data)
        print(data)
      }
      try? PhoneBookViewController.container.viewContext.save()
      
    }
  }
  
  // 정리를 코어데이터 이미지 url이 저장이 되어있는지
  // tableViewCell에서 대입해줘야하고
  func readAllData() {
         do {
             let phoneBooks = try PhoneBookViewController.container.viewContext.fetch(PhoneBook.fetchRequest())
             
             for phoneBook in phoneBooks as [NSManagedObject] {
                 if let name = phoneBook.value(forKey: "name") as? String,
                    let phoneNumber = phoneBook.value(forKey: "phoneNumber") as? String,
                    let imgurl = phoneBook.value(forKey: "imgURL"){
                     print("name: \(name), phoneNumber: \(phoneNumber),\(imgurl)")
                 }
             }
             
         } catch {
             print("데이터 읽기 실패")
         }
     }
 
  
  
  @objc func apply(){
    let name = nameTextLabel.text ?? "null"
    let phoneNum = numTextLabel.text ?? "null"
    readAllData()
    
    createData(name: name, phoneNumber: phoneNum,image: imgUrl)
    imgUrl = ""
    
    print("적용완료")
  }
}
