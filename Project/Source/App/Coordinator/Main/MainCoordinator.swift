import UIKit

final class MainCoordinator: BaseCoordinator {
    
    override func start() {
        let vm = MenuViewModel(coordinator: self)
        let vc = MenuViewController(viewModel: vm)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    override func navigate(to step: BabStep) {
    }
}

private extension MainCoordinator {
    
}
    
