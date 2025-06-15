import UIKit
import CoreLocation
extension HomeViewController: LocationSelectDelegate {
    func didSelectLocation(coordinate: CLLocationCoordinate2D) {
        self.selectedLocation = coordinate
        getAddressFromLocation(location: coordinate)
    }
}


class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var selectedLocation: CLLocationCoordinate2D? //  Seçilen konumu tutacak
    var userName: String = "Kullanıcı"

    
    let tableView = UITableView()
    let titleLabel = UILabel()
    
    let sections = ["Hastalık Öğren","Tahmine Dayalı Bitki Önerisi", "Güneş", "Sıcaklık", "Hava Nemi", "Uygulama Hakkında"]
    let icons = ["cross.case.fill","leaf.fill", "sun.max.fill", "thermometer", "cloud.drizzle.fill",  "info.circle"]

    let summaries = [
        ["Tarlanı fotoğraflamak için dokun!"],    // Hastalık
        ["Toprak ve hava verilerini girin!"],      // Bitki Öneri
        ["Pzt: 7 saat", "Salı: 6 saat", "Çar: 8 saat"], // Güneş
        ["Pzt: 24°C", "Salı: 22°C", "Çar: 25°C"], // Sıcaklık
        ["Pzt: %55", "Salı: %58", "Çar: %60"],    // Hava Nemi
        
        [""]
    ]
    

    
    var selectedImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "Ana Sayfa"
        
        setupWelcomeLabel()
        setupLocationLabel()
        setupTableView()
    }

    func setupUI() {
        titleLabel.text = "Bitki Tahmin Etme Sistemi"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center

    }
    
    let welcomeLabel = UILabel()
    let locationLabel = UILabel()

    func setupWelcomeLabel() {
        welcomeLabel.text = "Merhaba, \(userName) 👋"
        welcomeLabel.textColor = .white
        welcomeLabel.font = UIFont.boldSystemFont(ofSize: 26)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(welcomeLabel)
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }

    let geocoder = CLGeocoder()

    func getAddressFromLocation(location: CLLocationCoordinate2D) {
        let loc = CLLocation(latitude: location.latitude, longitude: location.longitude)
        
        geocoder.reverseGeocodeLocation(loc) { placemarks, error in
            if let placemark = placemarks?.first {
                let street = placemark.thoroughfare ?? ""
                let neighborhood = placemark.subLocality ?? ""
                let district = placemark.subAdministrativeArea ?? ""
                let city = placemark.locality ?? ""
                
                DispatchQueue.main.async {
                    self.locationLabel.text = "📍 \(street), \(neighborhood), \(district), \(city)"
                }
            }
        }
    }



    func setupLocationLabel() {
        locationLabel.textColor = .white
        locationLabel.font = UIFont.systemFont(ofSize: 16)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.text = "📍 Konum seçilmedi (tıklayın)"
        locationLabel.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(locationLabelTapped))
        locationLabel.addGestureRecognizer(tapGesture)
        
        view.addSubview(locationLabel)
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 8),
            locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }
    @objc func locationLabelTapped() {
        let locationSelectVC = LocationSelectViewController()
        locationSelectVC.delegate = self // Home’a geri bilgi verecek
        navigationController?.pushViewController(locationSelectVC, animated: true)
    }




    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CardCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 8),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CardCell
        cell.configure(title: sections[indexPath.row], iconName: icons[indexPath.row], dailySummaries: summaries[indexPath.row])
        
        // Fade-in animasyon (güzel görünüm için)
        cell.alpha = 0
        UIView.animate(withDuration: 0.6, delay: 0.05 * Double(indexPath.row), options: [], animations: {
            cell.alpha = 1
        }, completion: nil)
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSection = sections[indexPath.row]
        
        if selectedSection == "Hastalık Öğren" {
            navigationController?.pushViewController(DiseaseCheckViewController(), animated: true)
        }
        else if selectedSection == "Tahmine Dayalı Bitki Önerisi" {
            navigationController?.pushViewController(PredictPlantViewController(), animated: true)
        }
        else if selectedSection == "Uygulama Hakkında" {
            navigationController?.pushViewController(AboutViewController(), animated: true)
        }
        else {
            navigationController?.pushViewController(DetailViewController(titleText: selectedSection), animated: true)
        }
    }

    
    // Fotoğraf seçildikten sonra
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        if let image = info[.originalImage] as? UIImage {
            self.selectedImage = image
            tableView.reloadData()
        }
    }
}
