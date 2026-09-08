---
name: flutter-mcp-toolkit-maintain-macos
description: Maintains flutter_test_app macOS showcase, native intentcall hooks (codegen, app_links invoke), and VM MCP validation. Use when editing macOS Runner, intentcall_codegen.sh, macOS dogfood, Screen Recording capture, or comparing macOS parity to web WebMCP.
---
> Calls in this skill are MCP tools registered by `flutter-mcp-toolkit-server`.
> Tool names match the bare name in this skill (e.g. `tap_widget` → `fmt_tap_widget`).
> Errors return the standard envelope: read `error.code` and follow `error.recovery`.
> If the tool isn't in your tool list, the MCP server isn't connected — see `flutter-mcp-toolkit-setup`.

# Maintain macOS (showcase + native intentcall)

Dogfood app: `flutter_test_app`. Platform doc: `flutter_test_app/INTENTCALL_PLATFORM.md`.

## WebMCP on macOS

**WebMCP `modelContext` is web-only.** macOS dogfood proves **VM extensions**, **dynamic registry**, **native invoke** (`intentcall://` via `app_links`), and **visual capture** (Screen Recording on host).

For WebMCP parity scoring, run web iteration separately (`flutter-mcp-toolkit-maintain-web`).

## Launch showcase

```bash
make showcase-stop && make showcase
```

- Log: `.showcase/flutter_app.log`
- WS URI: grep `ws://127.0.0.1:…/ws` from log (default VM port **8181**)

```bash
grep -Eo 'ws://127\.0\.0\.1:[0-9]+/[A-Za-z0-9_=-]+/ws' .showcase/flutter_app.log | tail -1
```

Stop: `make showcase-stop`.

## Codegen & hooks

```bash
dart run mcp_server_dart/bin/flutter_mcp_toolkit.dart codegen sync \
  --platform web,android,ios,macos,linux,windows \
  --project-dir flutter_test_app

dart run mcp_server_dart/bin/flutter_mcp_toolkit.dart init intentcall-platform \
  --project-dir flutter_test_app --check
```

| Target | Role |
|--------|------|
| `macos/intentcall_codegen.sh` | Xcode Run Script → `codegen sync --platform macos` |
| `macos/Runner.xcodeproj` | Run Script phase (see script comment if manual) |
| `lib/main.dart` | `IntentCallInvokeLinkListener` for `intentcall://invoke/…` |

## Runtime validate

```bash
dart run mcp_server_dart/bin/flutter_mcp_toolkit.dart --save-images \
  --output-dir .showcase/macos_iter validate-runtime \
  --target "$MACOS_WS_URI" \
  --flutter-device macos \
  --timeout-ms 45000
```

Permissions (host process running CLI):

```bash
dart run mcp_server_dart/bin/flutter_mcp_toolkit.dart permissions status
dart run mcp_server_dart/bin/flutter_mcp_toolkit.dart permissions request
```

## Dual-platform dogfood

```bash
bash tool/evals/run_dogfood_eval.sh \
  --ws-uri "$WEB_WS_URI" \
  --macos --macos-ws-uri "$MACOS_WS_URI"
```

## Related

- `flutter-mcp-cli-runtime-validation` — doctor, capture backends, extensions
- `flutter-mcp-toolkit-maintain-web` — WebMCP enablement
- `flutter-mcp-toolkit-dogfood-iterations` — rubric + tracker
