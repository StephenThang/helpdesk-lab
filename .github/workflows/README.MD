## CI/CD Secret Scanning

[#cicd-secret-scanning](#cicd-secret-scanning)

Automated secret detection integrated into the repository's GitHub Actions pipeline using [TruffleHog](https://github.com/trufflesecurity/trufflehog), scanning for leaked credentials, API keys, and other sensitive data on every push and pull request.

| Trigger          | Scan Scope                          | Status     |
| ---------------- | ------------------------------------ | ---------- |
| Push to `main`    | Full repository scan                | ✅ Passing |
| Pull request      | Diff between PR base and head        | ✅ Passing |

**Workflow:** [`.github/workflows/trufflehog.yml`](https://github.com/StephenThang/helpdesk-lab/blob/main/.github/workflows/trufflehog.yml)

Key implementation details:
- Conditional logic separates `push` and `pull_request` events, since GitHub provides identical base/head SHAs on direct pushes (which would otherwise cause TruffleHog to skip scanning entirely)
- `--only-verified` flag ensures the pipeline fails only on confirmed live/active credentials, minimizing false-positive noise from pattern-matched but inert strings
- Validated locally first — cloned the repo, planted a fake AWS-formatted credential on a throwaway branch, and confirmed TruffleHog's detection (commit hash, file, and line number) before deploying the same logic to CI
