//
//  HomeView.swift
//  Getty
//
//  Created by Hyyy on 2017/12/12.
//  Copyright © 2017年 Getty. All rights reserved.
//

import UIKit

protocol HomeViewDelegate: class {
    
    
    /// 加号点击事件
    func addButtonHasClicked()
}

class HomeView: UIView {
    
    let tableView: UITableView = {
        
        let tableView = UITableView (frame: CGRect.zero, style: .plain)
        tableView.backgroundColor = Constant.Color.kTableBackgroundColor
        tableView.separatorColor = Constant.Color.kTableBackgroundColor
        tableView.tableHeaderView = UIView (frame: CGRect (x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
        tableView.tableFooterView = UIView()
        
        return tableView
    }()
    
    let addButton: UIButton = {
        
        let button = UIButton (type: .custom)
        button.setTitle("+", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont .systemFont(ofSize: 50, weight: .thin)
        button.backgroundColor = Constant.Color.kMainColor
        button.layer.cornerRadius = 30
        button.layer.shadowOpacity = 0.5
        button.layer.shadowColor = Constant.Color.kMainColor.cgColor
        button.layer.shadowOffset = CGSize (width: 0, height: 0)
        button.addTarget(self, action: #selector(handleAddButtonTouchDownEvent), for: .touchDown)
        button.addTarget(self, action: #selector(handleAddButtonTouchUpEvent), for: [.touchUpInside, .touchUpOutside])
        button.contentEdgeInsets = UIEdgeInsetsMake(-8, 0, 0, 0)
        
        return button
    }()
    
    var delegate: HomeViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        addSubview(tableView)
        addSubview(addButton)
        
        initSubViewLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSubViewLayout() {
        tableView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left)
            make.top.equalTo(self.snp.top)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
        }
        addButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom).offset(-44)
            make.size.equalTo(CGSize (width: 60, height: 60))
        }
    }
    
    @objc func handleAddButtonTouchDownEvent() {
        let scale: CGFloat = 0.9
        UIView.animate(withDuration: 0.15) {
            self.addButton.transform = CGAffineTransform (scaleX: scale, y: scale)
        }
    }
    
    @objc func handleAddButtonTouchUpEvent() {
        UIView.animate(withDuration: 0.15, animations: {
            self.addButton.transform = CGAffineTransform.identity
        }) { (finished) in
            // 传递点击新增按钮事件
            self.delegate?.addButtonHasClicked()
        }
    }
}

extension HomeView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView (frame: CGRect (x: 0, y: 0, width: Constant.Size.kScreenWidth, height: 10))
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension HomeView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HomePlanCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomePlanCell = HomePlanCell.cellWithTableView(tableView: tableView)
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return []
    }
}

extension HomeView: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if (velocity.y > 0) {
            // 上滑取消加号按钮显示
            if (addButton.alpha != 0) {
                let newFrame = CGRect (x: addButton.frame.minX,
                                       y: addButton.frame.minY + 120,
                                       width: addButton.frame.width,
                                       height: addButton.frame.height)
                UIView .animate(withDuration: 0.15, animations: {
                    self.addButton.frame = newFrame
                    self.addButton.alpha = 0
                })
            }
        } else {
            // 下滑显示加号按钮
            if (addButton.alpha == 0) {
                let newFrame = CGRect (x: addButton.frame.minX,
                                       y: addButton.frame.minY - 120,
                                       width: addButton.frame.width,
                                       height: addButton.frame.height)
                UIView.animate(withDuration: 0.15, animations: {
                    self.addButton.frame = newFrame
                    self.addButton.alpha = 1
                })
            }
        }
    }
}