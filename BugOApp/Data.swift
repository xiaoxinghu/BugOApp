import Foundation

enum DataError: Error {
    case timeout
}

enum LoginResponse {
    case ok
    case failed(String)
}

let q = DispatchQueue(label: "api-calls")

func submit(username: String,
            password: String,
            completion: @escaping (LoginResponse) -> Void) throws {
    if username.contains("timeout") {
        throw DataError.timeout
    }
    q.async {
        print("this is from the background thread: \(Thread.current)")
        Thread.sleep(forTimeInterval: 2)
        DispatchQueue.main.async {
            print("this is from the main thread: \(Thread.current)")
            if password.isEmpty {
                completion(.failed("password can't be empty"))
            } else {
                completion(.ok)
            }

        }
    }
}
