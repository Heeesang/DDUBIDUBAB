import UIKit

class SchoolNameTableViewCell: BaseTableViewCell<Welcome> {
    
    static let cellId = "SchoolNameTableViewCell"
    
    private let schoolNameLabel = UILabel().then {
        $0.text = "비아초"
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
    }
    
    private let schoolAddressLabel = UILabel().then {
        $0.text = "비아동 120-141"
        $0.font = .systemFont(ofSize: 12, weight: .medium)
    }
    
    override func addSubview(_ view: UIView) {
        self.addSubViews(schoolNameLabel, schoolAddressLabel)
    }
    
    override func setLayout() {
        schoolNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(30)
        }
        
        schoolAddressLabel.snp.makeConstraints {
            $0.top.equalTo(schoolNameLabel.snp.bottom).offset(5)
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.reuse()
    }
    
    func reuse(title: String) {
        schoolNameLabel.text = title
    }
}
