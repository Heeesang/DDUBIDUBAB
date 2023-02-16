import UIKit
import Moya
import RxSwift
import RxCocoa
import SwiftyJSON

protocol SchoolInfoProtocol: AnyObject {
    var schoolData: PublishSubject<[SchoolInfo]> { get set }
}

final class SchoolNameViewModel: BaseViewModel {
    weak var delegate: SchoolInfoProtocol?
    var schoolName: [SchoolInfo] = []
    var schoolst = SchoolInfo(atptCode: "", schoolCode: "", schoolName: "", schoolAdress: "")
    
    func fetchSchoolName(schoolName: String) {
        let provider = MoyaProvider<SchoolAPI>()
        self.schoolName = []
        self.schoolst = SchoolInfo(atptCode: "", schoolCode: "", schoolName: "", schoolAdress: "")
        
        provider.request(.schools(schoolName: schoolName, apiKey: "e6f3e10be1b1426cbcfb2be62afff409")) { (result) in
            switch result {
            case .success(let response):
                let responseData = response.data
                let json = JSON(responseData)
                let data = json["schoolInfo"].arrayValue
                let row = data[1]["row"]
                for index in 0...row.count-1 {
                    self.schoolst.atptCode = row[index]["ATPT_OFCDC_SC_CODE"].string ?? "학교 정보가 없습니다"
                    self.schoolst.schoolCode = row[index]["SD_SCHUL_CODE"].string ?? "학교 정보가 없습니다"
                    self.schoolst.schoolName = row[index]["SCHUL_NM"].string ?? "학교 정보가 없습니다"
                    self.schoolst.schoolAdress = row[index]["ORG_RDNMA"].string ?? "학교 정보가 없습니다."
                    self.schoolName.append(self.schoolst)
                }
        
                print(self.schoolName)
                self.delegate?.schoolData.onNext(self.schoolName)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func pushMenuVC(model: SchoolInfo) {
        coordinator.navigate(to: .menuRequired(model: model))
    }
}
