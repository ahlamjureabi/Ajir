//
//  HomeViewController.swift
//  Ajir App
//
//  Created by Ahlam Ahlam on 25/05/1443 AH.
//
//import AVKit
//import AVFoundation
import UIKit
import Firebase
import simd
class HomeViewController: UIViewController {
    
    var posts = [Post]()
    var selectedPost:Post?
    var filteredPost:[Post] = []
    var selectedPostImage:UIImage?
    var selectedUseImage:UIImage?
let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var postsTableView: UITableView! {
        didSet {
            postsTableView.delegate = self
            postsTableView.dataSource = self
            postsTableView.register(UINib(nibName: "postCell", bundle: nil), forCellReuseIdentifier: "postCell")
            postsTableView.sectionHeaderTopPadding = 0
        }
    }
    
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        let player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "Ajir", ofType: "m4v")!))
//        let layer = AVPlayerLayer(player: player)
//        layer.frame = view.bounds
//        view.layer.addSublayer(layer)
//        player.play()
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getPosts()
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
       
}
    
    func getPosts() {
        let ref = Firestore.firestore()
        ref.collection("posts").order(by: "createdAt",descending: true).addSnapshotListener { snapshot, error in
    if let error = error {
                print("DB ERROR Posts",error.localizedDescription)
            }
            if let snapshot = snapshot {
                print("POST CANGES:",snapshot.documentChanges.count)
                snapshot.documentChanges.forEach { diff in
                    let postData = diff.document.data()
                    switch diff.type {
                    case .added :
                        if let userId = postData["userId"] as? String {
                            ref.collection("users").document(userId).getDocument { userSnapshot, error in
                                if let error = error {
                                    print("ERROR user Data",error.localizedDescription)
                                    
                                }
                                if let userSnapshot = userSnapshot,
                                   let userData = userSnapshot.data(){
                                    let user = User(dict:userData)
                                    let post = Post(dict:postData,id:diff.document.documentID,user:user)
                                    self.posts.insert(post, at: 0)
                                    DispatchQueue.main.async {
                                        self.postsTableView.reloadData()
                                    }
                                }
                            }
                        }

                    case .modified:
                        let postId = diff.document.documentID
                        if let currentPost = self.posts.first(where: {$0.id == postId}),
                           let updateIndex = self.posts.firstIndex(where: {$0.id == postId}){
                            let newPost = Post(dict:postData, id: postId, user: currentPost.user)
                            self.posts[updateIndex] = newPost
                            DispatchQueue.main.async {
                                self.postsTableView.reloadData()
                            }
                            
                        }
                    case .removed:
                        let postId = diff.document.documentID
                        if let deleteIndex = self.posts.firstIndex(where: {$0.id == postId}){
                            self.posts.remove(at: deleteIndex)
                            DispatchQueue.main.async {
                                self.postsTableView.reloadData()
                            }
                            
                        }
                    }
                }
            }
        }
    }
   
   
    
    
    @IBAction func handleLogout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LandingNavigationController") as? UINavigationController {
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        } catch  {
            print("ERROR in signout",error.localizedDescription)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toPostVC" {
                let vc = segue.destination as! Product_Description_ViewController
                vc.selectedPost = selectedPost
                vc.selectedPostImage = selectedPostImage
            }else {
                let vc = segue.destination as! DetailsViewController
                vc.selectedPost = selectedPost
                vc.selectedPostImage = selectedPostImage
            }
        }
        
    }
}


extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.isActive ?filteredPost.count : posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! postCell
        let post = searchController.isActive ? filteredPost[indexPath.row]: posts[indexPath.row]
        cell.configure(with: post)
        return cell.configure(with: posts[indexPath.row])
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 350
}
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! postCell
        selectedPostImage = cell.postImageView.image
        selectedPost = posts[indexPath.row]
        if let currentUser = Auth.auth().currentUser,
           currentUser.uid == posts[indexPath.row].user.id{
            performSegue(withIdentifier: "toPostVC", sender: self)
        }else {
            performSegue(withIdentifier: "toDetailsVC", sender: self)
            
        }
    }
    
    
}
extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filteredPost = posts.filter({ selectedPost in
            return selectedPost.city.lowercased().contains(searchController.searchBar.text!.lowercased()) ||
           selectedPost.title.lowercased().contains(searchController.searchBar.text!.lowercased()) ||
            selectedPost.description.lowercased().contains(searchController.searchBar.text!.lowercased()) ||
            selectedPost.address.lowercased().contains(searchController.searchBar.text!.lowercased()) 
        })
        postsTableView.reloadData()
    }
}
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath) as! postCell
//        selectedPostImage = cell.postImageView.image
//        selectedPost = posts[indexPath.row]
//        if let currentUser = Auth.auth().currentUser,
//           currentUser.uid == posts[indexPath.row].user.id{
//            performSegue(withIdentifier: "toPostVC", sender: self)
//        }else {
//            performSegue(withIdentifier: "toDetailsVC", sender: self)
////
//        }
//    }
