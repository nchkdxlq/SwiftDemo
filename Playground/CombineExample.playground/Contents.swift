import Foundation
import Combine

@available(macOS 10.15, *)
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




check("Empty") {
    Empty<Int, SampleError>()
}

check("Just") {
    Just(1)
}

check("Fail") {
    Fail(
        outputType: Int.self,
        failure: SampleError.sampleError)
}


