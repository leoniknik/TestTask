

import NeedleFoundation

// swiftlint:disable unused_declaration
private let needleDependenciesHash : String? = nil

// MARK: - Registration

public func registerProviderFactories() {
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->ApplicationComponent") { component in
        return EmptyDependencyProvider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->ApplicationComponent->FeedCoordinatorComponent->FeedComponent") { component in
        return FeedDependency8d800b54ac79b0fb48b1Provider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->ApplicationComponent->FeedCoordinatorComponent") { component in
        return FeedCoordinatorDependencyf2ba58bfa928bef8e024Provider(component: component)
    }
    
}

// MARK: - Providers

private class FeedDependency8d800b54ac79b0fb48b1BaseProvider: FeedDependency {


    init() {

    }
}
/// ^->ApplicationComponent->FeedCoordinatorComponent->FeedComponent
private class FeedDependency8d800b54ac79b0fb48b1Provider: FeedDependency8d800b54ac79b0fb48b1BaseProvider {
    init(component: NeedleFoundation.Scope) {
        super.init()
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
