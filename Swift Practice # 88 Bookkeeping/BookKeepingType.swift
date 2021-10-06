//
//  BookKeepingType.swift
//  Swift Practice # 88 Bookkeeping
//
//  Created by Dogpa's MBAir M1 on 2021/10/5.
//

import Foundation

//自定義類別用於記帳包含存取檔案功能
struct BookKeepingType:Codable {
    var itemDate:String
    var itemName:String
    var itemClass:String
    var itemPrice:Int
    
    static func saveBookKeepingType (_ moneyInfo:[BookKeepingType]) {
        let encoder = JSONEncoder()
        guard let date = try? encoder.encode(moneyInfo) else { return }
        UserDefaults.standard.set(date, forKey: "BookKeepingType")
    }
    
    static func LoadBookKeepingType() ->[BookKeepingType]? {
        let userDeFult = UserDefaults.standard
        guard let data = userDeFult.data(forKey: "BookKeepingType") else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode([BookKeepingType].self, from: data)
    }
}

//自定義類別用於記帳不能的項目類別包含存取檔案功能
struct ClassAndTotalPrice:Codable {
    var calssName:String
    var calssPrice: Int
    
    static func saveClassAndTotalPrice (_ moneyInfo:[ClassAndTotalPrice]) {
        let encoder = JSONEncoder()
        guard let date = try? encoder.encode(moneyInfo) else { return }
        UserDefaults.standard.set(date, forKey: "ClassAndTotalPrice")
    }
    
    static func LoadClassAndTotalPrice() ->[ClassAndTotalPrice]? {
        let userDeFult = UserDefaults.standard
        guard let data = userDeFult.data(forKey: "ClassAndTotalPrice") else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode([ClassAndTotalPrice].self, from: data)
    }
    
    
}


