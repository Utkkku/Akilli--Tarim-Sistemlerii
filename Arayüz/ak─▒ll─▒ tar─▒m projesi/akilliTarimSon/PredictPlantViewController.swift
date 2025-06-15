import UIKit

class PredictPlantViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    let titleLabel = UILabel()
    let azotField = UITextField()
    let fosforField = UITextField()
    let potasyumField = UITextField()
    let sicaklikField = UITextField()
    let nemField = UITextField()
    let phField = UITextField()
    let yagisField = UITextField()
    
    let sonucLabel = UILabel()
    let sonucButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "Bitki Tahmini"
        
        setupUI()
    }
    
    func setupUI() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        titleLabel.text = "Bitki Tahmin Etme Sistemi"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        
        configureTextField(azotField, placeholder: "Azot Miktarı (mg/kg)")
        configureTextField(fosforField, placeholder: "Fosfor Miktarı (mg/kg)")
        configureTextField(potasyumField, placeholder: "Potasyum Miktarı (mg/kg)")
        configureTextField(sicaklikField, placeholder: "Sıcaklık (°C)")
        configureTextField(nemField, placeholder: "Nem (%)")
        configureTextField(phField, placeholder: "pH Değeri")
        configureTextField(yagisField, placeholder: "Yağış Miktarı (mm)")
        
        sonucButton.setTitle("Sonuç Al", for: .normal)
        sonucButton.backgroundColor = .systemGreen
        sonucButton.setTitleColor(.white, for: .normal)
        sonucButton.layer.cornerRadius = 10
        sonucButton.addTarget(self, action: #selector(handleResult), for: .touchUpInside)
        sonucButton.translatesAutoresizingMaskIntoConstraints = false
        
        sonucLabel.text = ""
        sonucLabel.textColor = .white
        sonucLabel.font = UIFont.boldSystemFont(ofSize: 20)
        sonucLabel.textAlignment = .center
        sonucLabel.numberOfLines = 0
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(azotField)
        stackView.addArrangedSubview(fosforField)
        stackView.addArrangedSubview(potasyumField)
        stackView.addArrangedSubview(sicaklikField)
        stackView.addArrangedSubview(nemField)
        stackView.addArrangedSubview(phField)
        stackView.addArrangedSubview(yagisField)
        stackView.addArrangedSubview(sonucButton)
        stackView.addArrangedSubview(sonucLabel)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
        ])
    }
    
    func configureTextField(_ textField: UITextField, placeholder: String) {
        textField.placeholder = placeholder
        textField.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        textField.textColor = .black
        textField.layer.cornerRadius = 8
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
    }
    
    @objc func handleResult() {
        if azotField.text!.isEmpty || fosforField.text!.isEmpty || potasyumField.text!.isEmpty ||
            sicaklikField.text!.isEmpty || nemField.text!.isEmpty || phField.text!.isEmpty || yagisField.text!.isEmpty {
            sonucLabel.text = "Lütfen tüm alanları doldurun!"
            sonucLabel.textColor = .systemRed
        } else {
            sonucLabel.textColor = .white
            sonucLabel.text = "Yapay Zeka Tahmini: Bu alan için en uygun ürün 'Buğday' 🌾"
        }
    }
}
