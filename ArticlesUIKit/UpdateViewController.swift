//
//  DetailsViewController.swift
//  ArticlesUIKit
//
//  Created by Abdullah Alnutayfi on 30/11/2021.
//

import UIKit

class UpdateViewController: UIViewController {
    var viewModel = ViewModel()
    var article : Article? = nil
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
    
    lazy var updateBtn : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.systemIndigo
        $0.tintColor = .white
        $0.layer.cornerRadius = 5
        $0.setTitle("update", for: .normal)
        $0.addTarget(self, action: #selector(updateBtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Update area"
        addTitleTextField.text = article?.title
        info.text = article?.info
        view.backgroundColor = .white
        [addTitleTextField,info,updateBtn].forEach{view.addSubview($0)}
        
        NSLayoutConstraint.activate([
            addTitleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            addTitleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            addTitleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            info.topAnchor.constraint(equalTo: addTitleTextField.bottomAnchor,constant: 20),
            info.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            info.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            info.bottomAnchor.constraint(equalTo: updateBtn.topAnchor,constant: -50),
            
            updateBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -20),
            updateBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 50),
            updateBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -50),
        ])
    }
    @objc func updateBtnClick(){
        guard addTitleTextField.text != "" else{return}
        guard info.text != "" else{return}
        article?.title = addTitleTextField.text
        article?.info = info.text
        
        do{
            try viewModel.getContext().save()
        }catch let error{
            print(error)
        }
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
 
}

