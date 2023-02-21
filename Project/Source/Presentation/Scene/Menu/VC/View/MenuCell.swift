import UIKit

final class MenuCell: UITableViewCell {
    
    static let cellId = "MenuTableViewCell"
    
    private let menuNameTextView = UITextView().then {
        $0.tintColor = .clear
        $0.textAlignment = .center
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
        contentView.addSubViews(menuNameTextView)
    }
    
    private func setLayout() {
        menuNameTextView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(40)
        }
    }
    
    func changeCellNameData(with model: String) {
        DispatchQueue.main.async {
            self.menuNameTextView.text = model
        }
    }
}
