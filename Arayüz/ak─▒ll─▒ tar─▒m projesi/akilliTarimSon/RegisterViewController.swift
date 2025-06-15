import UIKit

class RegisterViewController: UIViewController {
    
    let nameField = UITextField()
    let surnameField = UITextField()
    let emailField = UITextField()
    let passwordField = UITextField()
    let registerButton = UIButton(type: .system)
    let pageTitleLabel: UILabel = UILabel()
        

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "Kayıt Ol"
        
        setupUI()
    }
    
    func setupUI() {
        let titleLabel = UILabel()
        titleLabel.text = "Kayıt Ol"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize:   32)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameField.placeholder = "İsim"
        surnameField.placeholder = "Soyisim"
        emailField.placeholder = "E-Posta"
        passwordField.placeholder = "Şifre"
        
        [nameField, surnameField, emailField, passwordField].forEach { field in
            field.backgroundColor = UIColor.white.withAlphaComponent(1)
            field.textColor = .black
            field.layer.cornerRadius = 8
            field.borderStyle = .roundedRect
        }
        
        passwordField.isSecureTextEntry = true
        
        registerButton.setTitle("Kayıt Ol", for: .normal)
        registerButton.backgroundColor = .systemGreen
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.layer.cornerRadius = 10
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.addTarget(self, action: #selector(handleRegisterButton), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, nameField, surnameField, emailField, passwordField, registerButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
    }

    

    @objc func handleRegisterButton() {
        guard let name = nameField.text, !name.isEmpty,
              let surname = surnameField.text, !surname.isEmpty,
              let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            showAlert(message: "Tüm alanları doldurun!")
            return
        }
        
        
        // Kayıt bilgilerini saklıyoruz
        UserDefaults.standard.set(name, forKey: "registeredName")
        UserDefaults.standard.set(email, forKey: "registeredEmail")
        UserDefaults.standard.set(password, forKey: "registeredPassword")
        showAlert(message: "Kayıt başarılı! Şimdi giriş yapabilirsiniz.") {
            self.navigationController?.popViewController(animated: true)
        }
    }

    
    func showAlert(message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "Bilgi", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: { _ in
            completion?()
        }))
        present(alert, animated: true)
    }
}
