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

class ManageProfileViewController: UIViewController {
  
  let appDelegate = UIApplication.shared.delegate as! AppDelegate
  private var tempImgUrl: String = ""
  let manageProfileView = ManageProfileView()
  
  
  
  override func viewDidLoad() {
    view.backgroundColor = .white
    
    
    configureUI()
  }
  
  
  private func configureUI(){
    deleteData(name: "Ddd")
    let applyBtn = UIBarButtonItem(title: "적용", style: .plain, target: self, action: #selector(apply))
    self.navigationItem.rightBarButtonItem = applyBtn
    
    self.title = " 연락처 추가 "
    view.addSubview(manageProfileView)
    
    manageProfileView.randomBtn.addTarget(self, action: #selector(makeRandomImage), for: .touchDown)
    
    manageProfileView.snp.makeConstraints{
      $0.edges.equalToSuperview()
    }
    
  }
  
  
  
  @objc func makeRandomImage(){ // use kingfisher
    tempImgUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(Int.random(in: 0...1000)).png"
  
    manageProfileView.imageLabel.kf.setImage(with: URL(string: tempImgUrl))
    
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
//      } request ->
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
//        completion(decodedData) -> response
//      } else {
//        print("응답 오류")
//        completion(nil)
//      }
//    }.resume()
//  }
  // 네트워킹의 4단계
  //1 번 url 생성이
  //2번 urlsession
  //3번 url datatask
  // 4번 .resume() -> 네트워킹 의 과정
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
  
  
  

  
  func createData(name:String, phoneNumber:String, image: String){
    guard let entity = NSEntityDescription.entity(forEntityName: "PhoneBook", in: appDelegate.persistentContainer.viewContext) else { return }
    let newPhoneBook = NSManagedObject(entity: entity, insertInto: appDelegate.persistentContainer.viewContext)
    newPhoneBook.setValue(name, forKey: "name")
    newPhoneBook.setValue(phoneNumber, forKey: "phoneNumber")
    newPhoneBook.setValue(image, forKey: "imgURL")
    do {
      try appDelegate.persistentContainer.viewContext.save()
      print("Success")
    } catch {
      print("Failure:\(error)")
    }
    
    
  }
  
  func deleteData(name: String) {
    let fetchRequest = PhoneBook.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "name == %@", name)
    // name == %@ -> compare  검색조건형식
    do {
      let result = try? appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
      
      for data in result! as [NSManagedObject] {
        appDelegate.persistentContainer.viewContext.delete(data)
        print(data)
      }
      try? appDelegate.persistentContainer.viewContext.save()
      
    }
  }
  

  func readAllData() {
         do {
           let phoneBooks = try appDelegate.persistentContainer.viewContext.fetch(PhoneBook.fetchRequest())
             
             for phoneBook in phoneBooks as [NSManagedObject] {
                 if let name = phoneBook.value(forKey: "name") as? String,
                    let phoneNumber = phoneBook.value(forKey: "phoneNumber") as? String,
                    let imgurl = phoneBook.value(forKey: "imgURL"){
                     print("name: \(name), phoneNumber: \(phoneNumber)\nimgurl:\(imgurl)")
                 }
             }
             
         } catch {
             print("데이터 읽기 실패")
         }
     }
 
  
  
  @objc func apply(){
    let name = manageProfileView.nameTextView.text!
    let phoneNum = manageProfileView.numTextView.text!
    let image = tempImgUrl
    readAllData()
    
    createData(name: name, phoneNumber: phoneNum,image: image)
    tempImgUrl = ""
    self.navigationController?.popViewController(animated: false)
    
    print("적용완료")
  }
}
