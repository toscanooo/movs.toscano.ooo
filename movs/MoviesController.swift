//
//  Created by @toscanooo
//

import UIKit
import SDWebImage

struct CustomData {
    var title: String
    var image: UIImage
    var description: String
    var url: String
}

class MoviesController: UIViewController {

    var data = [CustomData(title:"filme1", image: #imageLiteral(resourceName: "Icon-40@3x"), description: "", url: "toscan.ooo"),]

    private let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        cv.backgroundColor = .systemYellow
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        let moviesURL = "https://api.themoviedb.org/3/discover/movie?api_key=bb64c6f28efe394a8ff2388876d4f329&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1"
        if let url = URL(string: moviesURL){
            if let data = try? Data(contentsOf: url){
                parse(json: data)
            }
        }

        view.backgroundColor = .systemYellow
        navigationItem.title = "Movs"
        let bottomButton = UIButton()
        bottomButton.backgroundColor = .gray
    
        bottomButton.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        view.addSubview(bottomButton)
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func parse(json: Data){
        let decoder = JSONDecoder()
        
        if let jsonMovies = try? decoder.decode(Movies.self, from: json) {
            let movies = jsonMovies.results
            data.remove(at: 0)
            for movie in movies {
                data.append(CustomData(title: "\(movie.title!)", image: #imageLiteral(resourceName: "Icon-60@3x"), description: "\(movie.overview!)", url: "\(movie.poster_path!)"))
            }
        }
    }
    
    @objc func handleShowSignUp(_ sender: UITapGestureRecognizer){
        let location = sender.location(in: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: location)
        
        guard let index = indexPath else { return }
            print("Got clicked on index: \(index[1])!")
            let infos = data[index[1]]
        
        let controller = MovieController(infos.title, infos.description, infos.url)
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension MoviesController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.06, height: collectionView.frame.width/1.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.data = self.data[indexPath.row]
        cell.backgroundColor = .systemYellow
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleShowSignUp)))
        return cell
    }
}
