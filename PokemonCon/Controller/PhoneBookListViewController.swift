//
//  ViewController.swift
//  PokemonCon
//
//  Created by bloom on 7/15/24.
//

import UIKit
import SnapKit
import CoreData

class PhoneBookListViewController: UIViewController { //PhoneBookListViewController
  private var container: NSPersistentContainer!
  private let phoneBookListView = PhoneBookListView()
  var phoneBooks: [PhoneBook] = []
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    configureView()
    configureAddButton()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    getPhoneBooks()
  }
  
  
  
  private func configureAddButton(){
    let addButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addFriends))
    self.navigationItem.rightBarButtonItem = addButton
  }
  
  
  
  
  private func configureView() {
    
    self.title = "친구 목록"
    
    navigationController?.navigationBar.titleTextAttributes = [
      NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .bold)
    ]
    
    phoneBookListView.tableView.delegate = self
    phoneBookListView.tableView.dataSource = self
    phoneBookListView.tableView.register(PhoneBookListCell.self, forCellReuseIdentifier: "ListCell")
    view.addSubview(phoneBookListView)
    phoneBookListView.snp.makeConstraints{
      $0.edges.equalToSuperview()
    }
  }
  
  
  
  
  
  @objc func addFriends() {
    let phoneBookVC = ManageProfileViewController()
    self.navigationController?.pushViewController(phoneBookVC, animated: false)
  }
  
  
  func getPhoneBooks(){
    do{
      
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      let phoneBooksResult = try appDelegate.persistentContainer.viewContext.fetch(PhoneBook.fetchRequest())
      
      
      
      for phoneBook in phoneBooksResult as [PhoneBook] {
        if phoneBook.name?.isEmpty == false && phoneBook.phoneNumber?.isEmpty == false{
          self.phoneBooks.append(phoneBook)
        }
      }
      
      self.phoneBookListView.tableView.reloadData()
      
    } catch {
      print("데이터 읽기실패")
    }
  }
}



extension PhoneBookListViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print(phoneBooks.count)
    return phoneBooks.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    print("ss")
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as? PhoneBookListCell else { return UITableViewCell() }
    
    let book = phoneBooks[indexPath.row]
    cell.setData(phoneBook: book)
    
    return cell
  }
  
}
