//
//  ViewController.swift
//  ArticlesUIKit
//
//  Created by Abdullah Alnutayfi on 29/11/2021.
//

import UIKit

class ViewController: UIViewController {
    
    var viewModel = ViewModel()
    lazy var segment : UISegmentedControl = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(segmentClicked), for: .valueChanged)
        $0.backgroundColor = UIColor.systemIndigo
        return $0
    }(UISegmentedControl(items: ["all","sport","comedy","politics"]))
    
    lazy var refreshControl : UIRefreshControl = {
        $0.addTarget(self, action: #selector(reloadTableData), for: .valueChanged)
        return $0
    }(UIRefreshControl())
    
    lazy var tableView : UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.register(MyCell.self, forCellReuseIdentifier: "cell")
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 200
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        $0.dataSource = self
        $0.layer.cornerRadius = 10
        $0.refreshControl = refreshControl
        return $0
    }(UITableView())
    
    lazy var addNewArticle : UIButton = {
        $0.setTitle("Add an article", for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.systemIndigo
        $0.tintColor = .white
        $0.layer.cornerRadius = 5
        $0.addTarget(self, action: #selector(addNewArticleBtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Welcome To Articles App"
        segment.selectedSegmentIndex = 0
        self.viewModel.fetchData()
        uiSettengs()
    }
    @objc func reloadTableData() {
        viewModel.fetchData()
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    func uiSettengs(){
        [segment,tableView,addNewArticle].forEach{view.addSubview($0)}
        NSLayoutConstraint.activate([
            segment.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            segment.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            segment.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            
            tableView.topAnchor.constraint(equalTo: segment.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            addNewArticle.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            addNewArticle.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 50),
            addNewArticle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            addNewArticle.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -20)
        ])
    }
    
    @objc func addNewArticleBtnClick(){
        let addViewController = AddViewController()
        self.present(UINavigationController(rootViewController: addViewController), animated: true, completion: nil)
    }
    @objc func segmentClicked(){
        if segment.selectedSegmentIndex == 1{
            viewModel.fetchData()
            viewModel.articles.removeAll{$0.articalcate != "sport"}
            tableView.reloadData()
        }
        else if segment.selectedSegmentIndex == 2{
            viewModel.fetchData()
            viewModel.articles.removeAll{$0.articalcate != "comedy"}
            tableView.reloadData()
        }else if segment.selectedSegmentIndex == 3{
            viewModel.fetchData()
            viewModel.articles.removeAll{$0.articalcate != "politics"}
            tableView.reloadData()
        }else{
            viewModel.fetchData()
            tableView.reloadData()
        }
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyCell
        cell.articleTitle.text = viewModel.articles[indexPath.row].title
        cell.articleInfo.text = viewModel.articles[indexPath.row].info
        let stringDate = viewModel.dateFormatter.string(from: viewModel.articles[indexPath.row].creationDate ?? Date())
        cell.articleDate.text = stringDate
        cell.category.text = "#" + viewModel.articles[indexPath.row].articalcate!
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let toBeDelete = viewModel.articles[indexPath.row]
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Warning", message: "Are you sure you want to delete the article with name \(toBeDelete.title ?? "")", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { [weak alert] (_) in
                
                self.viewModel.getContext().delete(toBeDelete)
                do {
                    try self.viewModel.getContext().save()
                    self.viewModel.fetchData()
                    self.tableView.reloadData()
                } catch let error as NSError {
                    print("Error While Deleting Article: \(error.userInfo)")
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak alert] (_) in
                
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(viewModel.articles[indexPath.row].articalcate ?? "")
        let detailsViewController = DetailsViewController()
        self.present(UINavigationController(rootViewController: detailsViewController), animated: true, completion: nil)
        detailsViewController.article = viewModel.articles[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
