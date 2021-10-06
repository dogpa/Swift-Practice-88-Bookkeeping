//
//  AddAndReviseTableViewController.swift
//  Swift Practice # 88 Bookkeeping
//
//  Created by Dogpa's MBAir M1 on 2021/10/5.
//

import UIKit

class AddAndReviseTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //任意地方收鍵盤
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddAndReviseTableViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        }
        @objc func dismissKeyboard() {
        view.endEditing(true)
        }
    var saveItem:BookKeepingType?
    var pickerViewStringInfo:[String] = ["飲食","大眾交通","日常雜項","固定支出","娛樂旅行"]
    
    @IBOutlet weak var itemTextField: UITextField!  //輸入項目
    
    
    @IBOutlet weak var classTextField: UITextField! //跳出類別
    
    
    @IBOutlet weak var pricrTextField: UITextField! //輸入價錢
    
    
    func updateInfo () {
        if let saveItem = saveItem {
            itemTextField.text = saveItem.itemName
            classTextField.text = saveItem.itemClass
            pricrTextField.text = String(saveItem.itemPrice)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()     //任意位置收鍵盤
        updateInfo()

        //自定義一個UIPickerView並將delegate與dataSource指派給UseTextFieldViewController
        let classPickerView = UIPickerView()
        classPickerView.delegate = self
        classPickerView.dataSource = self
        
        //distNumTextField插入一個UIPickerView
        classTextField.inputView = classPickerView
        
        
    }
    
    
    
    //pickerViewStart
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewStringInfo.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewStringInfo[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectRow = pickerView.selectedRow(inComponent: 0)
        classTextField.text = pickerViewStringInfo[selectRow]
    }
    //pickerViewEnd

    
    //tableview資料輸入及傳送到前一頁檢查
    // MARK: - Table view data source
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let checkItemPrice = Int(pricrTextField.text ?? "")
        if itemTextField.text?.isEmpty == false, classTextField.text?.isEmpty == false, pricrTextField.text?.isEmpty == false, checkItemPrice != nil {
            return true
        }else{
            let alertController = UIAlertController(title: "資料輸入有誤喔", message: "再檢查吧", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "了解", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            return false
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        let itemNamePassToSave = itemTextField.text ?? ""
        let itemClassPassToSave = classTextField.text ?? ""
        let itemPricePassToSave = Int(pricrTextField.text ?? "")
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Taipei")
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let itemDate = dateFormatter.string(from: Date())
        
        
        saveItem = BookKeepingType(itemDate: itemDate, itemName: itemNamePassToSave, itemClass: itemClassPassToSave, itemPrice: itemPricePassToSave!)
        
        
    }

}
