import Foundation

class MockDataManager {
    
    static let shared = MockDataManager()
    
    private init() {}
    
    func getMockValue(for type: String, dayIndex: Int) -> String {
        switch type {
        case "Güneş":
            let hours = [6, 7, 5, 8, 6, 9, 7]
            return "\(hours[dayIndex]) saat"
        case "Sıcaklık":
            let temps = [22, 24, 23, 25, 21, 22, 23]
            return "\(temps[dayIndex])°C"
        case "Toprak Nemi":
            let moistures = [65, 70, 68, 66, 72, 75, 70]
            return "\(moistures[dayIndex])%"
        case "Hava Nemi":
            let humidities = [55, 58, 60, 53, 57, 59, 56]
            return "\(humidities[dayIndex])%"
        case "Yaşam Döngüsü":
            let stages = ["Çimlenme", "Çimlenme", "Büyüme", "Büyüme", "Çiçeklenme", "Çiçeklenme", "Olgunluk"]
            return stages[dayIndex]
        default:
            return "-"
        }
    }
}
