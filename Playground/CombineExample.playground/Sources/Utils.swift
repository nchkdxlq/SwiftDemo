import Combine
import Foundation

public func check<P: Publisher>(_ title: String, publisher: () -> P) -> AnyCancellable {
    print("----- \(title) -----")
    defer { print("") }
    return publisher()
        .print()
        .sink(
            receiveCompletion: { _ in},
            receiveValue: { _ in }
        )
}

public enum SampleError: Error {
    case sampleError
}
