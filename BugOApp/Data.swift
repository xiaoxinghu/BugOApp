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
        Thread.sleep(forTimeInterval: 2)
        DispatchQueue.main.async {
            if password.isEmpty {
                completion(.failed("password can't be empty"))
            } else {
                completion(.ok)
            }

        }
    }
}
