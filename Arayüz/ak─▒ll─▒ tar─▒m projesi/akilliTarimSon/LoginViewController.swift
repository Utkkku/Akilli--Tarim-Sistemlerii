import UIKit

class LoginViewController: UIViewController {
    
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton(type: .system)
    let registerButton = UIButton(type: .system)
    let welcomeLabel = UILabel()

    
    override func viewDidLoad() {
        setupBackgroundImage()
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "Giriş Yap"
        
        setupUI()
    }
   
    func setupUI() {
        welcomeLabel.text = "Akıllı Tarıma Hoşgeldiniz!"
        welcomeLabel.textColor = .white
        welcomeLabel.font = UIFont.boldSystemFont(ofSize: 24)
        welcomeLabel.textAlignment = .center
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
           
        emailTextField.placeholder = "E-posta"
        emailTextField.backgroundColor = .white.withAlphaComponent(0.8)
        emailTextField.textColor = .black
        emailTextField.borderStyle = .roundedRect
        
        passwordTextField.placeholder = "Şifre"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.backgroundColor = .white.withAlphaComponent(0.8)
        passwordTextField.textColor = .black
        passwordTextField.borderStyle = .roundedRect
        
        loginButton.setTitle("Giriş Yap", for: .normal)
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        registerButton.setTitle("Hesabın yok mu? Kayıt Ol", for: .normal)
        registerButton.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [welcomeLabel,emailTextField, passwordTextField, loginButton, registerButton])
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
    func setupBackgroundImage() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "loginBackground") // Assets içine ekleyeceğiz
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }


    @objc func handleLogin() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "E-posta ve şifreyi girin!")
            return
        }
        
        let savedEmail = UserDefaults.standard.string(forKey: "registeredEmail")
        let savedPassword = UserDefaults.standard.string(forKey: "registeredPassword")
        
        if email == savedEmail && password == savedPassword {
            let homeVC = HomeViewController()
            homeVC.userName = UserDefaults.standard.string(forKey: "registeredName") ?? "Kullanıcı"
            navigationController?.pushViewController(homeVC, animated: true)
        }
    }
   /* override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        
        if isLoggedIn {
            let homeVC = HomeViewController()
            homeVC.userName = UserDefaults.standard.string(forKey: "registeredName") ?? "Kullanıcı"
            navigationController?.setViewControllers([homeVC], animated: true)
        }
    }*/

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }

    
    @objc func handleRegister() {
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }

}
