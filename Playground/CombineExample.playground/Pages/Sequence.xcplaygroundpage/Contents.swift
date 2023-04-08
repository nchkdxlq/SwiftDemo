import Combine

check("Sequence") {
    Publishers.Sequence<[Int], Never>(sequence: [1, 2, 3])
}

check("Array") {
    [1, 2, 3].publisher
}

check("Filter") {
    [1,2,3,4,5].publisher.filter { $0 % 2 == 0 }
}


check("Contains") {
    [1,2,3,4,5].publisher
        .print("[Origin]")
        .contains(3)
}


