import UIKit
import Moya
import RxSwift
import RxCocoa
import SwiftyJSON

protocol MenuInfoProtocol: AnyObject {
    var menuData: PublishSubject<[MenuInfo]> { get set }
    var dishName: PublishSubject<[String]> { get set }
}

final class MenuViewModel: BaseViewModel {
    weak var delegate: MenuInfoProtocol?
    var menuInfoList: [MenuInfo] = []
    var menuInfo = MenuInfo(dishName: "", mealDay: "", mealName: "")
    
    var disNameList: [String] = []
    var disName: String = ""
    
    
    func fetchMenuInfo(mealDate: String, atptCode: String, schoolCode: String) {
        let provider = MoyaProvider<SchoolAPI>()
        self.menuInfoList = []
        self.menuInfo = MenuInfo(dishName: "", mealDay: "", mealName: "")
        
        provider.request(.menu(mealDate: mealDate, atptCode: atptCode, schoolCode: schoolCode, apiKey: "e6f3e10be1b1426cbcfb2be62afff409")) { (result) in
            switch result {
            case .success(let response):
                let responseData = response.data
                let json = JSON(responseData)
                if json["RESULT"]["CODE"] == "INFO-200" {
                    self.menuInfo.dishName = "밥 없는 날!"
                    self.menuInfoList.append(self.menuInfo)
                }
                else{
                    let data = json["mealServiceDietInfo"].arrayValue
                    let row = data[1]["row"]
                    for index in 0...row.count-1 {
                        self.menuInfo.dishName = row[index]["DDISH_NM"].string ?? "급식 정보가 없습니다."
                        self.menuInfo.mealDay = row[index]["MLSV_YMD"].string ?? "급식 정보가 없습니다."
                        self.menuInfo.mealName = row[index]["MMEAL_SC_NM"].string ?? "급식 정보가 없습니다."
                        self.menuInfoList.append(self.menuInfo)
                        self.disName = self.menuInfo.dishName.replacingOccurrences(of: "<br/>", with: "\n\n")
                        self.disName = self.disName.replacingOccurrences(of: "[0-9.()]", with: "", options: .regularExpression)
                        self.disNameList.append(self.disName)
                    }
                }
                
                self.delegate?.dishName.onNext(self.disNameList)
                self.delegate?.menuData.onNext(self.menuInfoList)
                print(self.menuInfoList)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
