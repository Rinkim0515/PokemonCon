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
  let appDelegate = UIApplication.shared.delegate as! AppDelegate
  private let phoneBookListView = PhoneBookListView()
  var phoneBooks: [PhoneBook] = []
  let phoneBookVC = ManageProfileViewController()
  //타입 프로퍼티  폰북에와서 접근하는 컨테이너가
  
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
    
    self.navigationController?.pushViewController(phoneBookVC, animated: false)
  }
  
  
  func getPhoneBooks(){
    
    do{
      
      // 다시 돌아봐야할 부분
      let phoneBooksResult = try appDelegate.persistentContainer.viewContext.fetch(PhoneBook.fetchRequest())
      
      phoneBooks.removeAll() //코어데이터에
      
      for phoneBook in phoneBooksResult as [PhoneBook] {
        
        self.phoneBooks.append(phoneBook)
        
        //appDelegate.persistentContainer ->앱전반적으로 쓰는 컨테이너 이기에 
      }
      
      self.phoneBookListView.tableView.reloadData()
      
    } catch {
      print("데이터 읽기실패")
    }
  }
  // 매니저프로파일에서 컨테이너  crud  내부에서 // 객체를 생성해서 그것에 접근을하되 읽어올수 있도록
  // co
  
  
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
 private 으로 다 생성하며 소스파일사이에서 가져올때 풀어서 쓰고 연결에대한 고찰을 해볼것
 메서드 프로퍼티 private으 고정
 풀어야 한다면 이걸쓰는가 왜풀어야하지 메서드참조해
 .닷칭  그런 습관을 유지하면서
 캡슐화 같은거임 타인이 내코드를 상속할수 있기때문에 final class
 키워드 내가 의도한대로 동작하지 않을수 있기 때문에

 ocp

 첫화면 부터 하나씩
  

 
 
 */



extension PhoneBookListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    self.navigationController?.pushViewController(phoneBookVC, animated: false)
    tableView.deselectRow(at: indexPath, animated: false)
    
  }
  
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
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
    if editingStyle == .delete {
      
      deleteData(name: phoneBooks[indexPath.row].name ?? "")
      phoneBooks.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade
)
    } else if editingStyle == .insert{
      
    }
  }
  
}
