import UIKit

final class MenuCell: UITableViewCell {
    
    static let cellId = "MenuTableViewCell"
    
    private let menuNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.layer.cornerRadius = 10
        self.selectionStyle = .none
        
        addView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .white
    }
    
    private func addView() {
        contentView.addSubViews(menuNameLabel)
    }
    
    private func setLayout() {
        menuNameLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func changeCellNameData(with model: String) {
        DispatchQueue.main.async {
            self.menuNameLabel.text = model
        }
    }
}
