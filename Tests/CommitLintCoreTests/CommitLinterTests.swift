import Testing
@testable import CommitLintCore

@Test func shortMessagePasses() {
    let linter = CommitLinter()
    let result = linter.lint("hello")
    #expect(result == .ok)
}

@Test func subjectLongerThan50CharsFails() {
    let linter = CommitLinter()
    let longSubject = String(repeating: "a", count: 51)
    let result = linter.lint(longSubject)

    guard case .failed(let reason) = result else {
        Issue.record("Expected .failed, got \(result)")
        return
    }
    #expect(reason.contains("too long"))
}

@Test func longBodyDoesNotCountTowardSubjectLength() {
    let linter = CommitLinter()
    // 標題很短，但內文很長 —— 只看標題的話應該要過
    let message = "feat: add login\n\n" + String(repeating: "a", count: 200)
    let result = linter.lint(message)
    #expect(result == .ok)
}

@Test func subjectEndingWithPeriodFails() {
    let linter = CommitLinter()
    let result = linter.lint("hello.")

    guard case .failed(let reason) = result else {
        Issue.record("Expected .failed, got \(result)")
        return
    }
    #expect(
        reason.lowercased().contains("period") ||
        reason.contains(".")
    )
}
