import XCTest

class BugOAppUITests: XCTestCase {

    let app = XCUIApplication()
    override func setUp() {
        app.launch()
    }

    // MARK: happy paths
    func testLoginSuccessfully() {
        let page = LoginPage()
        XCTAssertEqual(page.usernameTextFieldLabel.label, "username")
        page.login(username: "spark🖖", password: "live long and prosper")
    }

    func testAccountsPageShouldShowMyName() {
        fatalError("Implement Me")
    }

    func testLogout() {
        fatalError("Implement Me")
    }

    // MARK: alternative flows
    func testLoginWithEmptyUsername() {
        fatalError("Implement Me")
    }

    func testLoginTimedOut() {
        fatalError("Implement Me")
    }

}
