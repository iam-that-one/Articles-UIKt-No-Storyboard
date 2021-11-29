//
//  AddViewController.swift
//  ArticlesUIKit
//
//  Created by Abdullah Alnutayfi on 29/11/2021.
//

import UIKit

class AddViewController: UIViewController {
    let vc : ViewController! = nil
    var row : String?
    var viewModel = ViewModel()
    let categories = ["all", "sport", "comedy", "politics"]
    lazy var addTitleTextField : UITextField = {
        $0.borderStyle = .roundedRect
        $0.placeholder = "Title"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.lightGray
        return $0
    }(UITextField())
    
    lazy var info :  UITextView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.borderWidth = 1.0
        $0.layer.cornerRadius = 5.0
        $0.backgroundColor = UIColor.lightGray
        return $0
    }(UITextView(frame: CGRect(x: 20.0, y: 90.0, width: 250.0, height: 100.0)))
    
    lazy var saveBtn : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.systemIndigo
        $0.tintColor = .white
        $0.layer.cornerRadius = 5
        $0.setTitle("Save", for: .normal)
        $0.addTarget(self, action: #selector(saveBtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    lazy var picker: UIPickerView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        $0.dataSource = self
        return $0
    }(UIPickerView())
    override func viewDidLoad() {
        title = "A new article in progress!"
        view.backgroundColor = .systemGray4
        [addTitleTextField,info,saveBtn,picker].forEach{view.addSubview($0)}
        super.viewDidLoad()
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            addTitleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            addTitleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            addTitleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            info.topAnchor.constraint(equalTo: addTitleTextField.bottomAnchor,constant: 20),
            info.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            info.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            picker.topAnchor.constraint(equalTo: info.bottomAnchor,constant: 20),
            picker.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            picker.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            picker.bottomAnchor.constraint(equalTo: saveBtn.topAnchor,constant: -20),
            
            saveBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -20),
            saveBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 50),
            saveBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -50),
        ])
    }
    @objc func saveBtnClick(){
        var selectedCaregoery = ""
        print(picker.selectedRow(inComponent: 0))
        if picker.selectedRow(inComponent: 0) == 0{
            selectedCaregoery = "all"
        }else if picker.selectedRow(inComponent: 0) == 1{
            selectedCaregoery = "sport"
        }else if picker.selectedRow(inComponent: 0) == 2{
            selectedCaregoery = "comedy"
        }else{
            selectedCaregoery = "politics"
        }
        
        // create an article
        
        let newArticle = Article(context: viewModel.getContext())
        guard addTitleTextField.text != "" else{return}
        guard info.text != "" else{return}
        newArticle.title = addTitleTextField.text
        newArticle.info = info.text
        newArticle.articalcate = selectedCaregoery
        newArticle.creationDate = Date()
        newArticle.id = UUID()
        do{
            try viewModel.getContext().save()
            
        }catch let error{
            print(error)
        }
        
        self.dismiss(animated: true, completion:  {
            
        })
        self.viewModel.fetchData()
        self.vc?.tableView.reloadData()
        self.vc?.reloadTableData()
    }
    
}

extension AddViewController : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.row = categories[row]
        return self.row
    }
    
}

