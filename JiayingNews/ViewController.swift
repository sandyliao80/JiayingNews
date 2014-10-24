//
//  ViewController.swift
//  JiayingNews
//
//  Created by LOO2K on 14/10/21.
//  Copyright (c) 2014年 luke. All rights reserved.
//

import UIKit
import Alamofire

class NewsTableViewCell : UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    func loadItem(title: String, subTitle: String) {
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var tableView: UITableView!
    var items: [(title: String, subTitle: String)] = [
        (title: "关于认真学习贯彻《中国共产党发展党员工作细则》的通知", subTitle: "6月11日，中共中央办公厅印发了《中国共产党发展党员工作细则》..."),
        (title: "关于教职工篮球赛分组情况及赛程安排的通知", subTitle: "2014嘉应学院教职工篮球赛的分组情况及赛程已安排好...")
    ]
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:NewsTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("newsCell") as NewsTableViewCell
        cell.loadItem(self.items[indexPath.row].title, subTitle: self.items[indexPath.row].subTitle)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        println("You selected cell #\(indexPath.row)!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Alamofire.request(.GET, "http://jyuhelp.com/api/news/")
            .responseString { (_, _, string, _) in
                println(string)
            }
            .responseJSON { (_, _, JSON, _) in
                println(JSON)
            }
//            .responseSwiftyJSON {
//                (request, response, json, error) in
//                    println(request)
//                    println(error)
//                    println(json)
//                    println(response)
////                    appsTableView.dataSource = json
////                    let news: NSArray = json["data"]["news"] as NSArray
////                    dispatch_async(dispatch_get_main_queue(), {
////                    self.tableData = results
////                    self.redditListTableView!.reloadData()
//            }
        
        var nib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "newsCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

