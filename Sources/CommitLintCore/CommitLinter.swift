public struct CommitLinter {
    public init() {}

    public func lint(_ message: String) -> LintResult {
        if message.count > 50 {
            return .failed(reason: "Commit message is too long (\(message.count) characters)")
        }
        if message.hasSuffix(".") {
            return .failed(reason: "Subject ends with a period")
        }
        return  .ok
    }
}

public enum LintResult: Equatable {
    case ok
    case failed(reason: String)
}
