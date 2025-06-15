import UIKit

class CardCell: UITableViewCell {
    
    let iconView = UIImageView()
    let titleLabel = UILabel()
    let day1Label = UILabel()
    let day2Label = UILabel()
    let day3Label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.white.withAlphaComponent(0.05)
        layer.cornerRadius = 15
        clipsToBounds = true
        
        setupUI()
    }
    
    func setupUI() {
        iconView.tintColor = .white
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.contentMode = .scaleAspectFit
        
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        
        day1Label.textColor = .white
        day1Label.font = UIFont.systemFont(ofSize: 16)
        
        day2Label.textColor = .white
        day2Label.font = UIFont.systemFont(ofSize: 16)
        
        day3Label.textColor = .white
        day3Label.font = UIFont.systemFont(ofSize: 16)
        
        let verticalStack = UIStackView(arrangedSubviews: [titleLabel, day1Label, day2Label, day3Label])
        verticalStack.axis = .vertical
        verticalStack.spacing = 6
        verticalStack.alignment = .leading
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        
        let mainStack = UIStackView(arrangedSubviews: [iconView, verticalStack])
        mainStack.axis = .horizontal
        mainStack.spacing = 20
        mainStack.alignment = .center
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 40),
            iconView.heightAnchor.constraint(equalToConstant: 40),
            
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        if highlighted {
            UIView.animate(withDuration: 0.2) {
                self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.transform = .identity
            }
        }
    }
    func configure(title: String, iconName: String, dailySummaries: [String]) {
        titleLabel.text = title
        iconView.image = UIImage(systemName: iconName)
        
        day1Label.text = dailySummaries.count > 0 ? dailySummaries[0] : ""
        day2Label.text = dailySummaries.count > 1 ? dailySummaries[1] : ""
        day3Label.text = dailySummaries.count > 2 ? dailySummaries[2] : ""
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
