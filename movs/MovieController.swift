//
//  Created by toscanooo
//

import UIKit
import SDWebImage

class MovieController: UIViewController{

    private var nomedofilme:String = ""
    private var descricaofilme:String = ""
    private var posterFilme:String = ""
    
    var imageURL:String = "https://image.tmdb.org/t/p/w250_and_h141_face/y2bqSEWUya1OeNsoBt4dGitaakO.jpg"
    
    
    
    let banner: UIImageView = {
       let iv = UIImageView()
        //iv.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w300_and_h450_bestv2/\(posterFilme)"), completed: nil)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .white
        iv.alpha = 0.3
        return iv
    }()
    
    
    
    fileprivate let movieDescription: UITextView = {
        let uil = UITextView()

        uil.backgroundColor = .none
        uil.translatesAutoresizingMaskIntoConstraints = false
        uil.tintColor = .black
        uil.isEditable = false
        uil.font = .systemFont(ofSize: 20)
        uil.adjustsFontForContentSizeCategory = true
        uil.textColor = .black
        
        return uil
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieDescription.text = "\(nomedofilme.uppercased())\n\(descricaofilme)"
        movieDescription.textAlignment = .justified
        banner.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w1280/\(posterFilme)"), completed: nil)
        view.backgroundColor = .systemYellow
        view.addSubview(banner)
        //view.addSubview(banner)
        //view.bringSubviewToFront(banner)
        //banner.contentMode = .scaleToFill
        //view.autoresizingMask = [.flexibleWidth, .flexibleLeftMargin, .flexibleRightMargin]
        banner.autoresizingMask = [ .flexibleWidth]
        banner.topAnchor.constraint(equalTo: view.topAnchor, constant:90).isActive = true
        banner.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        banner.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        //banner.heightAnchor.constraint(equalToConstant: 562).isActive = true
        banner.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor).isActive = true
        view.addSubview(movieDescription)
        movieDescription.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
        movieDescription.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        movieDescription.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        movieDescription.heightAnchor.constraint(equalToConstant: 500).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    init(_ filme: String?, _ descricao: String?, _ poster: String?){
        super.init(nibName: nil, bundle: nil)
        self.nomedofilme = filme!
        self.descricaofilme = descricao!
        self.posterFilme = poster!
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension UIImage {
    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
                draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
                let newImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                return newImage!
    }
}
