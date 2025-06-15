import UIKit

class DiseaseCheckViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let titleLabel = UILabel()
    let selectPhotoButton = UIButton(type: .system)
    let imageView = UIImageView()
    let resultButton = UIButton(type: .system)
    let resultLabel = UILabel()
    var activityIndicator = UIActivityIndicatorView(style: .large)
    let pageTitleLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "Hastalık Tespiti"
        
        setupUI()
    }

    func setupUI() {
        
        pageTitleLabel.text = "Hastalık Tahmin AI "
        pageTitleLabel.textColor = .white
        pageTitleLabel.font = UIFont.boldSystemFont(ofSize:  32)
        pageTitleLabel.textAlignment = .center
        pageTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(pageTitleLabel)
            
        selectPhotoButton.setTitle("Fotoğraf Seç veya Çek", for: .normal)
        selectPhotoButton.backgroundColor = .systemGreen
        selectPhotoButton.setTitleColor(.white, for: .normal)
        selectPhotoButton.layer.cornerRadius = 10
        selectPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        selectPhotoButton.addTarget(self, action: #selector(selectPhotoTapped), for: .touchUpInside)
        
        resultButton.setTitle("Sonuç Al", for: .normal)
        resultButton.backgroundColor = .systemBlue
        resultButton.setTitleColor(.white, for: .normal)
        resultButton.layer.cornerRadius = 10
        resultButton.translatesAutoresizingMaskIntoConstraints = false
        resultButton.addTarget(self, action: #selector(handleResult), for: .touchUpInside)
        resultButton.isHidden = true // Fotoğraf seçilmeden gizli
        
        imageView.backgroundColor = UIColor.black.withAlphaComponent(1)
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        resultLabel.text = ""
        resultLabel.textColor = .white
        resultLabel.textAlignment = .center
        resultLabel.font = UIFont.boldSystemFont(ofSize: 20)
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(pageTitleLabel)
        view.addSubview(selectPhotoButton)
        view.addSubview(imageView)
        view.addSubview(resultButton)
        view.addSubview(resultLabel)
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            pageTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pageTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageTitleLabel.widthAnchor.constraint(equalToConstant: 300),
            pageTitleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            
            selectPhotoButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            selectPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectPhotoButton.widthAnchor.constraint(equalToConstant: 250),
            selectPhotoButton.heightAnchor.constraint(equalToConstant: 50),
            
            imageView.topAnchor.constraint(equalTo: selectPhotoButton.bottomAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            resultButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            resultButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultButton.widthAnchor.constraint(equalToConstant: 250),
            resultButton.heightAnchor.constraint(equalToConstant: 50),
            
            resultLabel.topAnchor.constraint(equalTo: resultButton.bottomAnchor, constant: 20),
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
   
    
    @objc func selectPhotoTapped() {
        let alert = UIAlertController(title: "Fotoğraf", message: "Seçim yapın", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Galeriden Seç", style: .default, handler: { _ in
            self.openImagePicker(sourceType: .photoLibrary)
        }))
        
        alert.addAction(UIAlertAction(title: "Kamerayla Çek", style: .default, handler: { _ in
            self.openImagePicker(sourceType: .camera)
        }))
        
        alert.addAction(UIAlertAction(title: "İptal", style: .cancel))
        
        present(alert, animated: true)
    }
    
    func openImagePicker(sourceType: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else { return }
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        activityIndicator.startAnimating()
        picker.dismiss(animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.activityIndicator.stopAnimating()
            if let image = info[.originalImage] as? UIImage {
                self.imageView.image = image
                self.resultButton.isHidden = false
            }
        }
    }
    
    @objc func handleResult() {
        resultLabel.text = "Tahmini Hastalık: Yok 🌱"
    }
}
