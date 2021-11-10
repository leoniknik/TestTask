

import NeedleFoundation

// swiftlint:disable unused_declaration
private let needleDependenciesHash : String? = nil

// MARK: - Registration

public func registerProviderFactories() {
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->ApplicationComponent") { component in
        return EmptyDependencyProvider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->ApplicationComponent->FeedCoordinatorComponent->DetailComponent") { component in
        return DetailDependency16b77b0b188d07b7b4dbProvider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->ApplicationComponent->FeedCoordinatorComponent->FeedComponent") { component in
        return FeedDependency8d800b54ac79b0fb48b1Provider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->ApplicationComponent->FeedCoordinatorComponent") { component in
        return FeedCoordinatorDependencyf2ba58bfa928bef8e024Provider(component: component)
    }
    
}

// MARK: - Providers

private class DetailDependency16b77b0b188d07b7b4dbBaseProvider: DetailDependency {


    init() {

    }
}
/// ^->ApplicationComponent->FeedCoordinatorComponent->DetailComponent
private class DetailDependency16b77b0b188d07b7b4dbProvider: DetailDependency16b77b0b188d07b7b4dbBaseProvider {
    init(component: NeedleFoundation.Scope) {
        super.init()
    }
}
private class FeedDependency8d800b54ac79b0fb48b1BaseProvider: FeedDependency {
    var networkService: NetworkServiceProtocol {
        return applicationComponent.networkService
    }
    private let applicationComponent: ApplicationComponent
    init(applicationComponent: ApplicationComponent) {
        self.applicationComponent = applicationComponent
    }
}
/// ^->ApplicationComponent->FeedCoordinatorComponent->FeedComponent
private class FeedDependency8d800b54ac79b0fb48b1Provider: FeedDependency8d800b54ac79b0fb48b1BaseProvider {
    init(component: NeedleFoundation.Scope) {
        super.init(applicationComponent: component.parent.parent as! ApplicationComponent)
    }
}
private class FeedCoordinatorDependencyf2ba58bfa928bef8e024BaseProvider: FeedCoordinatorDependency {


    init() {

    }
}
/// ^->ApplicationComponent->FeedCoordinatorComponent
private class FeedCoordinatorDependencyf2ba58bfa928bef8e024Provider: FeedCoordinatorDependencyf2ba58bfa928bef8e024BaseProvider {
    init(component: NeedleFoundation.Scope) {
        super.init()
    }
}
