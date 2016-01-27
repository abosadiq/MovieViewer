//
//  MovieViewController.swift
//  MovieViewer
//
//  Created by Wafi MoHamed on 1/8/16.
//  Copyright © 2016 wafi. All rights reserved.
//

import UIKit
import AFNetworking
import BXProgressHUD

class MovieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,
UISearchBarDelegate{
  

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    var refrechController = UIRefreshControl()
    var movies: [NSDictionary]?
    var filteredData: [NSDictionary]!
    override func viewDidLoad() {
        super.viewDidLoad()
//           let refreshControl = UIRefreshControl()
//        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
       refrechController.backgroundColor = UIColor.grayColor()
        refrechController.tintColor = UIColor.blueColor()
        refrechController.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refrechController, atIndex: 3)
       searchBar.delegate = self
        filteredData = movies
        var getView: UIView {
            return self.view
        }
        //var tableView = tableView
          tableView.dataSource = self
          tableView.delegate = self 
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
         BXProgressHUD.showHUDAddedTo(getView).hide(afterDelay: 2)
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            print("response: \(responseDictionary)")
                            
                            self.movies = responseDictionary["results"] as? [NSDictionary]
                            self.filteredData = self.movies
                        self.refrechController.endRefreshing()
                            self.tableView.reloadData()
                        
                            
                    }
                }
        });
        task.resume()
        
        
        
        
        
        
        
        // Do any additional setup after loading the view.
        
    }
    
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let filteredData = filteredData {
            return filteredData.count
        } else {
            return 0
        }
        //return filteredData?.count ?? 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
    
         //let movie = movies! [indexPath.row]
        let movie = filteredData![indexPath.row]
        let title = movie ["title"] as! String
        let overview = movie ["overview"] as! String
        
        cell.titleLabel.text = title
        cell.overViewLabel.text = overview
         let baseUrl = "http://image.tmdb.org/t/p/w500"
        if let posterpath = movie ["poster_path"] as? String {
    
        let imageUrl = NSURL(string: baseUrl + posterpath)
        
        cell.posterView.setImageWithURL(imageUrl!)
            
        }
         return cell
        
        }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? movies : movies!.filter({ (movie: NSDictionary) -> Bool in
            return (movie["title"] as! String).rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
        })
         self.tableView.reloadData()
    }
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = NSURLRequest(URL: url!)
        
        // ... Create the NSURLRequest (myRequest) ...
        
        // Configure session so that completion handler is executed on main UI thread
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (data, response, error) in
            
            // ... Use the new data to update the data source ...
            
            // Reload the tableView now that there is new data
            self.tableView.reloadData()
            
            // Tell the refreshControl to stop spinning
            refreshControl.endRefreshing()	
            });
        task.resume()
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let movie = movies![indexPath!.row]
        let detailViewContoroller = segue.destinationViewController as! DetailViewController
        detailViewContoroller.movie = movie
        //print("wafi")
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("did select row")
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
         view.endEditing(true)
    }
    
  }
