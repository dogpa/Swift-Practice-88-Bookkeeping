//
//  ListDetailsTableViewCell.swift
//  Swift Practice # 88 Bookkeeping
//
//  Created by Dogpa's MBAir M1 on 2021/10/5.
//

import UIKit

//自定義表格樣貌
class ListDetailsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var dateLabel: UILabel!          //顯示日期
    
    @IBOutlet weak var nameLabel: UILabel!          //顯示記帳名稱
    
    @IBOutlet weak var classLabel: UILabel!         //顯示記帳類別
    
    @IBOutlet weak var priceLabel: UILabel!         //顯示記帳金額
    
    @IBOutlet weak var everyClassLabel: UILabel!    //顯示個類別價格與目前總花費
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
