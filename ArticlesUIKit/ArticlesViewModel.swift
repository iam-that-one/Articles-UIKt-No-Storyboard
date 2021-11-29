//
//  ArticlesViewModel.swift
//  ArticlesUIKit
//
//  Created by Abdullah Alnutayfi on 29/11/2021.
//

import Foundation
import CoreData
import UIKit

class ViewModel{
    
    var articles : [Article] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    func getContext() -> NSManagedObjectContext{
        return appDelegate.persistentContainer.viewContext
    }
    func fetchData(){
        let fetchRequest = NSFetchRequest<Article>()
        let entity =
        NSEntityDescription.entity(forEntityName: "Article",in: getContext())!
        fetchRequest.entity = entity
        print(articles)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        request.returnsObjectsAsFaults = false
        do {
            let result = try getContext().fetch(request)
            self.articles = result as! [Article]
        } catch let error as NSError{
            print("something went wrong while fetching data \(error.userInfo)")
        }
    }
     var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        formatter.dateStyle = .long
        formatter.timeZone = TimeZone(secondsFromGMT: 3)
        return formatter
    }()
}
struct ArticleModel {
    var id = UUID().uuidString
    var title = ""
    var creationDate : Date
    
}
