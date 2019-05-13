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
        XCTFail("TODO: Implement Me")
    }

    func testLogout() {
        XCTFail("TODO: Implement Me")
    }

    // MARK: alternative flows
    func testLoginWithEmptyUsername() {
        XCTFail("TODO: Implement Me")
    }

    func testLoginTimedOut() {
        XCTFail("TODO: Implement Me")
    }

}
