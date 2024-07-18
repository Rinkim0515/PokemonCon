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
      
      phoneBooks.removeAll() //코어데이터에
      
      for phoneBook in phoneBooksResult as [PhoneBook] {
        
          self.phoneBooks.append(phoneBook)
        
        
      }
      
      self.phoneBookListView.tableView.reloadData()
      
    } catch {
      print("데이터 읽기실패")
    }
  }
}
/* UI를 그릴수 있는 메모리는 한정되어잇음 만약 테이블뷰의 셀이 만개라면
 메모리 오버플로우가 남 out of memory 이것을 방지하기위해
 테이블뷰가 만들어서 제공하는것임
 화면에서 보이는것보다 조금더 구성은 되어있는 상태
 스크롤 내릴때 화면에 보여지지않는 셀이 재활용
 tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) 이것이 보여지지 않는 셀을 일단 가져온다라는 의미인것이고
 수납틀과 수납장의 개념
 indexpath
 
 왜 이함수를 써야되는지애 대한 깊은 고찰이 필요함
 그냥 쓰지말것 쓰라니까 쓰지말것 시간이 걸리더라도
 
 
 
 */



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
