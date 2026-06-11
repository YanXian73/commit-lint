public struct CommitLinter {
    public init() {}

    public func lint(_ message: String) -> LintResult {
        // commit 訊息的結構是「標題行 + 空行 + 內文」，規則只看標題（第一行）
        let subject = message
            .split(separator: "\n", omittingEmptySubsequences: false)
            .first
            .map(String.init) ?? ""

        if subject.count > 50 {
            return .failed(reason: "Subject is too long (\(subject.count) characters, max 50)")
        }
        if subject.hasSuffix(".") {
            return .failed(reason: "Subject ends with a period")
        }
        return .ok
    }
}

public enum LintResult: Equatable {
    case ok
    case failed(reason: String)
}
