//
//  ViewController.swift
//  SwiftiOS
//
//  Created by lian on 2024/8/31.
//

import UIKit
import SnapKit
import NextGrowingTextView

class ViewController: UIViewController {

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.tableFooterView = UIView()
        tableView.contentInsetAdjustmentBehavior = .automatic
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .onDrag
        tableView.register(cellWithClass: UITableViewCell.self)
        tableView.register(cellWithClass: TextInputCell.self)
        return tableView
    }()
    
    var textHeight: CGFloat = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    @IBAction func leftItemAction(_ sender: Any) {
        
    }
    
    @IBAction func rightItemAction(_ sender: Any) {
        
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 80
        } else {
            return max(200, textHeight)
        }
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 6
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withClass: UITableViewCell.self)
            cell.textLabel?.text = "\(indexPath.row)"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withClass: TextInputCell.self)
            return cell
        }
    }
}

class TextInputCell: UITableViewCell {
    
    var heightChanged: ((CGFloat) -> Void)?
    
    let contentLabel: NextGrowingTextView = {
        let contentLabel = NextGrowingTextView()
        contentLabel.backgroundColor = .clear
        contentLabel.isUserInteractionEnabled = true
        contentLabel.textView.showsVerticalScrollIndicator = false
        contentLabel.textView.showsHorizontalScrollIndicator = false
        contentLabel.textView.textContainer.lineFragmentPadding = 0
        contentLabel.textView.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        contentLabel.textView.textContainerInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        contentLabel.placeholderLabel.textColor = UIColor.lightGray
        contentLabel.placeholderLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        contentLabel.placeholderLabel.text = "Add mark"
        contentLabel.configuration = .init(minLines: 1, maxLines: 100, isAutomaticScrollToBottomEnabled: true, isFlashScrollIndicatorsEnabled: false)
        contentLabel.layerBorderColor = UIColor.cyan
        contentLabel.layerBorderWidth = 1
        return contentLabel
    }()
    
    var prevHeight: CGFloat = 200
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(contentLabel)
        selectionStyle = .none
        contentLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
