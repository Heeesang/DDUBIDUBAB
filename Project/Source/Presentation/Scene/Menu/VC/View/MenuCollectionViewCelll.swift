import UIKit

final class MenuCollectionViewCell: UICollectionViewCell {
    
    static let cellId = "MenuCollectionViewCell"
    
    private let menuTypeLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    private let menuNameLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.tintColor = .clear
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        setLayout()
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        backgroundColor = .white
    }
    
    private func addView() {
        contentView.addSubViews(menuTypeLabel, menuNameLabel)
    }
    
    private func setLayout() {
        
        menuTypeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.centerX.equalToSuperview()
        }
        
        menuNameLabel.snp.makeConstraints {
            $0.top.equalTo(menuTypeLabel.snp.bottom).offset(20)
            $0.width.equalToSuperview()
        }
    }
    
    func changeCellNameData(with model: MenuInfo) {
        DispatchQueue.main.async {
            self.menuTypeLabel.text = model.mealName
            self.menuNameLabel.text = model.dishName
        }
    }
}
