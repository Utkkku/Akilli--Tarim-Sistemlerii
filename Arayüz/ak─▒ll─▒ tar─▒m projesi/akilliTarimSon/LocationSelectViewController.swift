import UIKit
import MapKit
protocol LocationSelectDelegate: AnyObject {
    func didSelectLocation(coordinate: CLLocationCoordinate2D)
}


class LocationSelectViewController: UIViewController, MKMapViewDelegate {
    
    let mapView = MKMapView()
    let selectButton = UIButton(type: .system)
    var selectedCoordinate: CLLocationCoordinate2D?
    weak var delegate: LocationSelectDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "Konum Seç"
        
        setupMap()
        setupButton()
    }
    
    func setupMap() {
        mapView.frame = view.bounds
        mapView.delegate = self
        mapView.showsUserLocation = true
        view.addSubview(mapView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(_:)))
        mapView.addGestureRecognizer(tapGesture)
    }
    
    func setupButton() {
        selectButton.setTitle("Konumu Kaydet", for: .normal)
        selectButton.backgroundColor = .systemGreen
        selectButton.setTitleColor(.white, for: .normal)
        selectButton.layer.cornerRadius = 10
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        selectButton.addTarget(self, action: #selector(handleSelect), for: .touchUpInside)
        
        view.addSubview(selectButton)
        
        NSLayoutConstraint.activate([
            selectButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            selectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectButton.widthAnchor.constraint(equalToConstant: 200),
            selectButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func handleMapTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        selectedCoordinate = coordinate
        
        mapView.removeAnnotations(mapView.annotations)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
    
    @objc func handleSelect() {
        if let coordinate = selectedCoordinate {
            delegate?.didSelectLocation(coordinate: coordinate)
            
            let alert = UIAlertController(title: "Başarılı", message: "Konum seçildi!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: { _ in
                self.navigationController?.popViewController(animated: true)
            }))
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Hata", message: "Lütfen bir konum seçin.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .cancel))
            present(alert, animated: true)
        }
    }


}
