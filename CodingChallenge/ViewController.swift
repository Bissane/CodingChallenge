//
//  ViewController.swift
//  CodingChallenge
//
//  Created by mac on 12/19/17.
//  Copyright © 2017 Bissane. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    final let urlString = "https://api.github.com/search/repositories?q=created:%3E2017-10-22&sort=stars&order=desc"
    
    @IBOutlet var tableView: UITableView!
    
    
    var repos = [repo]()
    
    var repoName = [String]()
    var repoDescription = [String]()
    var repoOwnerName = [String]()
    var numberOfStars = [String]()
    var imgURLArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.downloadJsonWithURL()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func downloadJsonWithURL() {
        let url = NSURL(string: urlString)
        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
            if error == nil {
                if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                    print(jsonObj!.value(forKey: "items"))
                    
                    if let repoArray = jsonObj!.value(forKey: "items") as? NSArray {
                        for repo in repoArray{
                            if let repoDict = repo as? NSDictionary {
                                if let name = repoDict.value(forKey: "name") {
                                    self.repoName.append(name as! String)
                                }
                                if let desc = repoDict.value(forKey: "description") as? String {                                    self.repoDescription.append((desc))
                                }
                                else{
                                    self.repoDescription.append("")
                                }
                                if let owner = repoDict.value(forKey: "owner") {
                                    if let avatarUrl = (owner as! NSDictionary).value(forKey: "avatar_url") {
                                        self.imgURLArray.append(avatarUrl as! String)
                                    }
                                    if let ownerLogin = (owner as! NSDictionary).value(forKey: "login") {
                                        self.repoOwnerName.append(ownerLogin as! String)
                                    }
                                    if let rating = (owner as! NSDictionary).value(forKey: "starred_url") {
                                        self.numberOfStars.append(rating as! String)
                                    }
                                }
                            }
                        }
                    }
                    
                    OperationQueue.main.addOperation({
                        self.tableView.reloadData()
                    })
                }
            }
            else{
                
            }
            
        }).resume()
    }
    
    
//    func downloadJsonWithTask() {
//
//        let url = NSURL(string: urlString)
//
//        var downloadTask = URLRequest(url: (url as? URL)!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 20)
//
//        downloadTask.httpMethod = "GET"
//
//        URLSession.shared.dataTask(with: downloadTask, completionHandler: {(data, response, error) -> Void in
//
//            let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
//
//            print(jsonData)
//
//        }).resume()
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CCTableViewCell
        // currentRepo = reposArray[indexPath.row]
        // cell.repoNameLabel.text = currentRepo.name
        // cell.repoDesc.text = currentRepo.desc
        
        
        
        cell.repoNameLabel.text = repoName[indexPath.row]
        cell.repoDescriptionLabel.text = repoDescription[indexPath.row]
        cell.repoOwnerNameLabel.text=repoOwnerName[indexPath.row]
        cell.numberOfStars.text=numberOfStars[indexPath.row]
        
//        cell.repoDescriptionLabel.text = repoDescription[indexPath.row]
        
        let imgURL = NSURL(string: imgURLArray[indexPath.row])

        if imgURL != nil {
            let data = NSData(contentsOf: (imgURL as? URL)!)
            cell.ownerAvatar.image = UIImage(data: data as! Data)
        }
        
        return cell
    }
    
    ///for showing next detailed screen with the downloaded info
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
//        vc.imageString = imgURLArray[indexPath.row]
//        vc.nameString = repoName[indexPath.row]
//        vc.dobString = repoDescription[indexPath.row]
//        
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}

