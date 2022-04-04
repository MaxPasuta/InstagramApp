//
//  TableViewController.swift
//  InstagramApp
//
//  Created by Максим Пасюта on 22.03.2022.
//

import UIKit
import SDWebImage


class TableViewController: UITableViewController {
    
    var itemArray = [Post]()
    var isPagination = false
    
    private func createSpinerFooret() -> UIView{
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height:100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        spinner.style = .large
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPost()
        tableView.reloadData()
    }
    
    private func getPost(){
        NetworkDataFetch.shared.fetch10Post() {[weak self] post, error in
            if error == nil {
                guard let post = post else {return}
                self?.itemArray += post
                
            } else {
                print(error!.localizedDescription)
            }
        }
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.tableView.tableFooterView = createSpinerFooret()
        
        let position = scrollView.contentOffset.y
        if position > (scrollView.contentSize.height - scrollView.frame.height){
            if !isPagination {
                isPagination = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: { [weak self] in
                    guard let self = self else { return }
                    self.getPost()
                    self.tableView.tableFooterView = nil
                    self.tableView.reloadData()
                    self.isPagination = false
                })
            }
            else {
                return
            }
            
        }
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TableViewCell{
            
            let item = itemArray[indexPath.row]
            cell.refresh(model: item)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detail = storyboard.instantiateViewController(identifier: "Detail") as? DetailPostController else{return}
        
        let item = itemArray[indexPath.row]
        if let data = SDImageCache.shared.diskImageData(forKey: item.url) {
            guard let image = UIImage(data: data) else { return }
            detail.image = image
        }
        
        detail.name = item.title
        show(detail, sender: nil)
    }
}





