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
    
    
    var repos = [Repo]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.downloadJsonWithURL()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func downloadJsonWithURL() {
        let url = NSURL(string: urlString)
        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
            if error == nil {
                if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                    print(jsonObj!.value(forKey: "items"))
                    
                    if let repoArray = jsonObj!.value(forKey: "items") as? NSArray {
                        var counter = 0
                        for repo in repoArray{
                            let aRepo = Repo.init()
                            if let repoDict = repo as? NSDictionary {
                                if let name = repoDict.value(forKey: "name") {

                                    aRepo.name = name as? String
                                }
                                if let desc = repoDict.value(forKey: "description") as? String {

                                    aRepo.desc = desc
                                }
                                else{

                                    aRepo.desc = ""
                                }
                                if let rating : Int = repoDict.value(forKey: "stargazers_count") as? Int {
                                    
                                    aRepo.rating = String(rating)
                                }
                                if let owner = repoDict.value(forKey: "owner") {
                                    if let avatarUrl = (owner as! NSDictionary).value(forKey: "avatar_url") {

                                        aRepo.ownerAvatarUrl = avatarUrl as? String
                                    }
                                    if let ownerLogin = (owner as! NSDictionary).value(forKey: "login") {

                                        aRepo.ownerName = ownerLogin as? String
                                    }
                    
                                }
                     
                                self.repos.append(aRepo)
                            }
                        counter += 1
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
    
    

    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155.0
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CCTableViewCell

        
        let currentRepo = repos[indexPath.row]
        
        cell.repoNameLabel.text = currentRepo.name
        cell.repoDescriptionLabel.text = currentRepo.desc
        cell.repoOwnerNameLabel.text = currentRepo.ownerName
        cell.numberOfStars.text = currentRepo.rating
        
        
        if currentRepo.ownerAvatar != nil {
            cell.ownerAvatar.image = currentRepo.ownerAvatar
        }
        else{
            OperationQueue.init().addOperation {
                let data = NSData(contentsOf: (URL.init(string: currentRepo.ownerAvatarUrl!))!)
                currentRepo.ownerAvatar = UIImage(data: data! as Data)
                OperationQueue.main.addOperation {
                    cell.ownerAvatar.image = currentRepo.ownerAvatar
                }
            }
        }

        
        return cell
    }
    
    ///for showing next detailed screen with the downloaded info
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

