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
