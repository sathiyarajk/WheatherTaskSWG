//
//  WhetherListTableViewCell.swift
//  TaskSW
//
//  Created by Apple on 09/09/22.
//

import UIKit

class WhetherListTableViewCell: UITableViewCell {
    
    var imgWhether = UIImageView()
    var bgview = UIView()
    var lblDay = UILabel()
    var lblMinWhether = UILabel()
    var lblSeparator = UILabel()
    var lblMaxWhether = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        frameForView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func frameForView(){

        lblDay.frame = CGRect(x: self.contentView.frame.minX + 15, y: 7, width: 90, height: 21)
        lblDay.backgroundColor = UIColor.clear
        lblDay.textColor = UIColor.black
        lblDay.translatesAutoresizingMaskIntoConstraints = false
        
        imgWhether.frame = CGRect(x: 135, y: 0, width: 40, height: 40)
        
        lblMinWhether.frame = CGRect(x:self.contentView.frame.width - 135, y: 7, width: 150, height: 21)
        lblMinWhether.backgroundColor = UIColor.clear
        lblMinWhether.textColor = UIColor.black
        lblMinWhether.translatesAutoresizingMaskIntoConstraints = false
        lblDay.textColor = .white
        lblDay.font = common.sharedInstance.font
        lblMinWhether.font = common.sharedInstance.font
        lblMinWhether.textColor = .white
        self.contentView.addSubview(bgview)
        self.contentView.addSubview(lblDay)
        self.contentView.addSubview(imgWhether)
        self.contentView.addSubview(lblMinWhether)
        self.contentView.addSubview(lblDay)
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
