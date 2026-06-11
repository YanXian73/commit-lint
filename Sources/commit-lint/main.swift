import CommitLintCore
import Foundation

// git 的 commit-msg hook 會把「裝著 commit 訊息的暫存檔路徑」當第一個參數傳進來。
// 用法：commit-lint <path-to-commit-msg-file>
let arguments = CommandLine.arguments

guard arguments.count > 1 else {
    FileHandle.standardError.write(Data("usage: commit-lint <commit-msg-file>\n".utf8))
    exit(64) // EX_USAGE：參數用錯
}

let path = arguments[1]

guard let message = try? String(contentsOfFile: path, encoding: .utf8) else {
    FileHandle.standardError.write(Data("commit-lint: cannot read file at \(path)\n".utf8))
    exit(66) // EX_NOINPUT：檔案讀不到
}

let linter = CommitLinter()
switch linter.lint(message) {
case .ok:
    exit(0) // 0 = 通過，git 繼續完成 commit
case .failed(let reason):
    FileHandle.standardError.write(Data("commit-lint: \(reason)\n".utf8))
    exit(1) // 非 0 = git 中止這次 commit
}
