import XCTest

class LoginPage {

    var usernameTextFieldLabel: XCUIElement {
        return XCUIApplication().staticTexts["username"]
    }

    func login(username: String, password: String) {
        let app = XCUIApplication()

        let usernameTextField = app.textFields["usernameTextField"]

        usernameTextField.tap()
        usernameTextField.typeText("my username")

        let password = app.otherElements.containing(.staticText, identifier:"username").children(matching: .secureTextField).element

        password.tap()
        password.typeText("password")

        app.buttons["Login"].tap()

        Thread.sleep(forTimeInterval: 5)
    }
}
