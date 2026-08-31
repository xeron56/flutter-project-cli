import 'package:flutter/foundation.dart';

/// Registers in-app custom MCP tools for AI agents when running in debug mode.
///
/// Use `MCPToolkitBinding.instance.addEntries` or tool registration APIs to
/// expose domain actions, state inspection, or test utilities to AI agents.
void registerAppMcpTools() {
  if (!kDebugMode) return;

  // Tools and resources registered here are discoverable by AI agents
  // through the `fmt_list_client_tools_and_resources` MCP tool.
}
