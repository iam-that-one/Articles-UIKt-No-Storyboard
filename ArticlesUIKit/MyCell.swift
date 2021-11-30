//
//  MyCell.swift
//  ArticlesUIKit
//
//  Created by Abdullah Alnutayfi on 29/11/2021.
//

import Foundation
import UIKit
class MyCell: UITableViewCell {
    
    lazy var articleTitle : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return $0
    }(UILabel())
    
    lazy var articleDate : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = UIColor.systemGray3
        return $0
    }(UILabel())
    
    lazy var articleInfo : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    lazy var clockImageView : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(systemName: "clock")
        return $0
    }(UIImageView())
    
    lazy var category : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = UIColor.blue
        return $0
    }(UILabel())
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cellSettings()
    }
    func cellSettings(){
        [articleTitle,articleInfo,articleDate,clockImageView,category].forEach{contentView.addSubview($0)}
        
        NSLayoutConstraint.activate([
            articleTitle.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            articleTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            
            articleInfo.topAnchor.constraint(equalTo: articleTitle.bottomAnchor,constant: 20),
            articleInfo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            
            clockImageView.topAnchor.constraint(equalTo: articleInfo.bottomAnchor,constant: 20),
            clockImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            clockImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            clockImageView.heightAnchor.constraint(equalToConstant: 20),
            clockImageView.widthAnchor.constraint(equalToConstant: 20),

            articleDate.leadingAnchor.constraint(equalTo: clockImageView.trailingAnchor,constant: 10),
            articleDate.centerYAnchor.constraint(equalTo: clockImageView.centerYAnchor),
            
            category.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            category.centerYAnchor.constraint(equalTo: articleDate.centerYAnchor)
        ])
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    required init?(coder: NSCoder) {
        fatalError("")
    }
}
