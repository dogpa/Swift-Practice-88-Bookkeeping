//
//  BookkeepingListTableViewController.swift
//  Swift Practice # 88 Bookkeeping
//
//  Created by Dogpa's MBAir M1 on 2021/10/5.
//

import UIKit

class BookkeepingListTableViewController: UITableViewController {
    
    //定義BookKeepingArray型別為自定義BookKeepingType的Array
    //有變動就存擋
    var BookKeepingArray = [BookKeepingType]() {
        didSet {
            BookKeepingType.saveBookKeepingType(BookKeepingArray)
        }
    }
    
    //自定義分類用於存入金額分類用
    var classTypeNameArray = ["飲食","大眾交通","日常雜項","固定支出","娛樂旅行"]
    
    //定義變數everyClassPriceInfo為ClassAndTotalPrice類別的Array型態
    //有改變就存檔
    var everyClassPriceInfo:[ClassAndTotalPrice] = [ClassAndTotalPrice(calssName: "飲食", calssPrice: 0), ClassAndTotalPrice(calssName: "大眾交通", calssPrice: 0), ClassAndTotalPrice(calssName: "日常雜項", calssPrice: 0), ClassAndTotalPrice(calssName: "固定支出", calssPrice: 0), ClassAndTotalPrice(calssName: "娛樂旅行", calssPrice: 0)] {
        didSet {
            ClassAndTotalPrice.saveClassAndTotalPrice(everyClassPriceInfo)
        }
    }
    
    //定義變數stringShowOnSectionTwo為字串的Array
    //有改變就存檔案
    var stringShowOnSectionTwo = [String]() {
        didSet {
            UserDefaults.standard.setValue(stringShowOnSectionTwo, forKey: "stringShowOnSectionTwo")
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //讀取檔案開始
        if let LoadBookKeepingArray = BookKeepingType.LoadBookKeepingType() {
            self.BookKeepingArray = LoadBookKeepingArray
        }
        
        if let LoadeveryClassPriceInfo = ClassAndTotalPrice.LoadClassAndTotalPrice() {
            self.everyClassPriceInfo = LoadeveryClassPriceInfo
        }
        
        if let LoadstringShowOnSectionTwo = UserDefaults.standard.stringArray(forKey: "stringShowOnSectionTwo") {
            self.stringShowOnSectionTwo = LoadstringShowOnSectionTwo
        }
        //讀取檔案結束
        
        //執行過濾功能
        filtrateEveryClas()
        
    }
    
    //過濾各自類別的開銷並重新顯示
    func filtrateEveryClas () {
        if BookKeepingArray.count != 0 {
            for i in 0...classTypeNameArray.count - 1 {
                var total = 0
                
                for x in 0...BookKeepingArray.count - 1 {
                    //print(classTypeNameArray[i], BookKeepingArray[x].itemClass )
                    if classTypeNameArray[i] == BookKeepingArray[x].itemClass  {
                        total = total + BookKeepingArray[x].itemPrice
                        //print("目前類別為\(BookKeepingArray[x].itemClass)金額為\(total)")
                        
                    }
                }
                everyClassPriceInfo[i].calssPrice = total
            }
        }else{
            for x in 0...everyClassPriceInfo.count - 1 {
                everyClassPriceInfo[x].calssPrice = 0
            }
        }

        stringShowOnSectionTwo = []
        for i in 0...everyClassPriceInfo.count - 1 {
            let stringInfo = "\(everyClassPriceInfo[i].calssName) 總計：\(everyClassPriceInfo[i].calssPrice) 元"
            stringShowOnSectionTwo.append(stringInfo)
        }
        var totalCost = 0
        for z in 0...everyClassPriceInfo.count - 1 {
            totalCost += everyClassPriceInfo[z].calssPrice
        }
        let totalCostString = "目前總花費共計 \(totalCost) 元"
        stringShowOnSectionTwo.append(totalCostString)
        //print(stringShowOnSectionTwo)
        tableView.reloadData()
    }
    


    // MARK: - Table view data source
    //回傳兩個section
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    //tableview顯示數量
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if section == 0 {
            return BookKeepingArray.count
        }else{

            return stringShowOnSectionTwo.count
        }
        
    }

    //各自section內row顯示的內容
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "totalBookKeepingCell", for: indexPath) as! ListDetailsTableViewCell
        
        
        if indexPath.section == 0 {
            
            //let cell = tableView.dequeueReusableCell(withIdentifier: "totalBookKeepingCell", for: indexPath) as! ListDetailsTableViewCell
            cell.dateLabel.text = BookKeepingArray[indexPath.row].itemDate
            cell.nameLabel.text = BookKeepingArray[indexPath.row].itemName
            cell.classLabel.text = BookKeepingArray[indexPath.row].itemClass
            cell.priceLabel.text = "$\(String(BookKeepingArray[indexPath.row].itemPrice))"
            cell.everyClassLabel.isHidden = true
            //return cell
            
        }/*else if indexPath.section == 1 {
            
            //let cell = tableView.dequeueReusableCell(withIdentifier: "totalBookKeepingCell", for: indexPath) as! ListDetailsTableViewCell
            cell.everyClassLabel.text = stringShowOnSectionTwo[indexPath.row]
            cell.dateLabel.isHidden = true
            cell.nameLabel.isHidden = true
            cell.classLabel.isHidden = true
            cell.priceLabel.isHidden = true
            
            //return cell
        }*/
        
        return cell
    }
    //各自section的抬頭
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "全列表"
        }else{
            return "各項分類"
        }
    }
    //第二頁傳資料回來
    @IBAction func unwindToAddAndReviseTable(_ unwindSegue: UIStoryboardSegue) {
        if let source = unwindSegue.source as? AddAndReviseTableViewController, let saveInfo = source.saveItem {
            if let indexPath = tableView.indexPathForSelectedRow {
                BookKeepingArray[indexPath.row] = saveInfo
                //tableView.reloadRows(at: [indexPath], with: .automatic)
                filtrateEveryClas()
                //tableView.reloadData()
            }else{
                BookKeepingArray.insert(saveInfo, at: 0)
                //let newIndexPath = IndexPath(row: 0, section: 0)
                //tableView.insertRows(at: [newIndexPath], with: .automatic)
                filtrateEveryClas ()
                //tableView.reloadData()
            }
            
            //filtrateEveryClas ()
            //tableView.reloadData()
            print(BookKeepingArray)
            
        }
        
    }
    
    //刪除資料
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        BookKeepingArray.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .bottom)
        filtrateEveryClas()
    }
    
    //傳資料到下一頁修改
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let controller = segue.destination as? AddAndReviseTableViewController, let row = tableView.indexPathForSelectedRow?.row{
            controller.saveItem = BookKeepingArray[row]
            controller.pickerViewStringInfo = classTypeNameArray
        }
    }

}
