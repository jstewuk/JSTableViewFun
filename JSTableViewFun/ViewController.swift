//
//  ViewController.swift
//  JSTableViewFun
//
//  Created by Jim Stewart on 11/17/15.
//  Copyright © 2015 mutualmobile. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
       let tv = UITableView(frame: CGRectZero, style: .Plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = UIColor.yellowColor()
        tv.dataSource = self.dataSource
        tv.delegate = self.tvDelegate
        tv.tableHeaderView = self.tableHeader
        tv.contentInset.top = 100.0
        tv.contentOffset.y = -100.0
        return tv
    }()
    
    private lazy var dataSource: UITableViewDataSource = {
        return DataSource()
    }()
    
    private lazy var tvDelegate: UITableViewDelegate = {
        return TVDelegate()
    }()
    
    private lazy var tableHeader: UIView = {
//        let view = UIView(frame:CGRect(x: 0, y: 0, width: 500, height: 100))
//        view.backgroundColor = UIColor.redColor()
        return self.body.container
//        return view
    }()
    
    private lazy var body: (container: CustomHeaderView, label: UILabel) = {
        let label = UILabel()
        label.text = "This is the header and this should be long enough to wrap, we'll see"
        label.numberOfLines = 0
        label.lineBreakMode = .ByWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        let container = CustomHeaderView(label: label)
        container.addSubview(label)
        return (container, label)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addUI()
        constrainUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sizeHeaderToFit()
    }
    
    private func sizeHeaderToFit() {
        let headerView = self.tableHeader
        
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        
        let height = headerView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
        var frame = headerView.frame
        frame.size.height = height
        headerView.frame = frame
        self.tableHeader = headerView
    }
    
    func addUI() {
        view.addSubview(tableView)
    }
    
    func constrainUI() {
        constrainTV()
        constrainBody()
    }
    
    func constrainTV() {
        let margins = view.layoutMarginsGuide
        tableView.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor).active = true
        tableView.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor).active = true
        let top = tableView.topAnchor.constraintEqualToAnchor(self.topLayoutGuide.bottomAnchor)
        top.active = true;
        let bottom = tableView.bottomAnchor.constraintEqualToAnchor(self.bottomLayoutGuide.bottomAnchor)
        bottom.active = true
    }
    
    private func constrainBody() {
        body.label.leadingAnchor.constraintEqualToAnchor(body.container.leadingAnchor).active = true
        body.label.trailingAnchor.constraintEqualToAnchor(body.container.trailingAnchor).active = true
        
        let top = body.label.topAnchor.constraintEqualToAnchor(body.container.topAnchor, constant: 20)
        top.priority = UILayoutPriorityDefaultHigh
        top.active = true
        let bottom = body.label.bottomAnchor.constraintEqualToAnchor(body.container.bottomAnchor, constant: -20)
        bottom.priority = UILayoutPriorityDefaultHigh
        bottom.active = true
    }
    
}

class JSTableView: UITableView {
    
}

class DataSource: NSObject, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

class TVDelegate: NSObject, UITableViewDelegate {
    
}

// Link preferredMaxLayoutWidth of header to the label's bounds
class CustomHeaderView: UIView {
    var label:UILabel
    
    init(label: UILabel) {
        self.label = label
        super.init(frame:CGRectZero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.preferredMaxLayoutWidth = label.bounds.width
    }
}

