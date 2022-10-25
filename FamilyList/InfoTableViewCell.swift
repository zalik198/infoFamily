//
//  InfoTableViewCell.swift
//  FamilyList
//
//  Created by Shom on 25.10.2022.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
    var nameChildTextFied: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Имя"
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        return textField
    }()
    var ageChildTextFied: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Возраст"
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        return textField
    }()
    
    
    //MARK: Initial cells
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameChildTextFied)
        contentView.addSubview(ageChildTextFied)
        nameChildTextFied.frame = bounds
        ageChildTextFied.frame = bounds
        initialLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: Initial constraints
    func initialLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameChildTextFied.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nameChildTextFied.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameChildTextFied.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameChildTextFied.heightAnchor.constraint(equalToConstant: 50),
                                     
            ageChildTextFied.topAnchor.constraint(equalTo: nameChildTextFied.bottomAnchor, constant: 16),
            ageChildTextFied.heightAnchor.constraint(equalToConstant: 50),
            ageChildTextFied.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            ageChildTextFied.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
                                     
                                    ])
    }
}
