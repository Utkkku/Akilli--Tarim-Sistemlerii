import UIKit

class AboutViewController: UIViewController {
    
    let infoLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "Uygulama Hakkında"
        
        setupInfo()
    }
    
    func setupInfo() {
        infoLabel.text = """
        Akıllı Tarım Uygulaması'na hoş geldiniz!
        
        Bu uygulama ile tarlanızın hava durumunu,
        güneş ışığı, toprak nemi ve sıcaklık bilgilerini
        haftalık olarak takip edebilirsiniz.
        
        Konumunuzu seçerek tüm verileri otomatik alın!
        """
        infoLabel.textColor = .white
        infoLabel.numberOfLines = 0
        infoLabel.font = UIFont.systemFont(ofSize: 18)
        infoLabel.textAlignment = .center
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
}
