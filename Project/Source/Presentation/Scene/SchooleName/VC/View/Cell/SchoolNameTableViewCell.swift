import UIKit

class SchoolNameTableViewCell: UITableViewCell{
    
    static let cellId = "SchoolNameTableViewCell"
    
    private let schoolNameLabel = UILabel().then {
        $0.text = "비아초"
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
    }
    
    private let schoolAddressLabel = UILabel().then {
        $0.text = "비아동 120-141"
        $0.font = .systemFont(ofSize: 12, weight: .medium)
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .red
        self.selectionStyle = .none
        
        addView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0))
    }
    
    private func addView() {
        contentView.addSubViews(schoolNameLabel, schoolAddressLabel)
    }
    
    private func setLayout() {
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
    
    func changeCellData(with model: [Row]) {
        DispatchQueue.main.async {
            self.schoolNameLabel.text = model[0].schulNm
            self.schoolAddressLabel.text = model[0].orgRdnma
        }
    }
}
