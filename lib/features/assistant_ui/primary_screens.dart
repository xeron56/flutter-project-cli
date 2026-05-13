// ignore_for_file: lines_longer_than_80_chars, prefer_const_constructors, prefer_single_quotes, use_null_aware_elements

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_app_template/routes/router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

const _bg = Color(0xFFF8F7FB);
const _card = Colors.white;
const _border = Color(0xFFEAE5F0);
const _text = Color(0xFF1B1825);
const _subtle = Color(0xFF8A8496);
const _purple = Color(0xFF6B4EFF);
const _purpleSoft = Color(0xFFF0EBFF);
const _purpleDark = Color(0xFF5A37F4);
const _green = Color(0xFF2CB36B);
const _blue = Color(0xFF4A90E2);
const _orange = Color(0xFFF4A425);
const _red = Color(0xFFEC5B5B);

class AssistantHomeScreen extends StatelessWidget {
  const AssistantHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _PhonePage(
      tabItems: _homeTabs,
      selectedRoute: AppRoutes.home,
      pinnedComposer: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 18),
        children: [
          _BrandHeader(
            left: CupertinoIcons.line_horizontal_3,
            right: const [CupertinoIcons.bell],
          ),
          const SizedBox(height: 18),
          const _HeroBlock(
            title: 'Good Morning, Ahmed',
            trailing: '👋',
            subtitle: "Your day is ready. Let’s get things done.",
          ),
          const SizedBox(height: 16),
          const _SearchComposer(placeholder: 'Search or ask anything...'),
          const SizedBox(height: 22),
          const _SectionHeading(title: 'Quick Actions', trailing: 'Customize'),
          const SizedBox(height: 12),
          const _QuickActionRow(),
          const SizedBox(height: 18),
          _InsetCard(
            child: Column(
              children: const [
                _SectionHeading(
                  title: 'Today at a Glance',
                  trailing: 'May 15, 2025',
                  dense: true,
                ),
                SizedBox(height: 14),
                _TodayStatsRow(),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const _SectionHeading(title: 'Reminders', trailing: 'View all'),
          const SizedBox(height: 12),
          _InsetCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: const [
                _ReminderTile(
                  title: 'Submit project report',
                  subtitle: 'Today, 6:00 PM',
                  level: 'Medium',
                  levelColor: _orange,
                ),
                _Hairline(),
                _ReminderTile(
                  title: 'Buy groceries',
                  subtitle: 'Today, 7:30 PM',
                  level: 'Low',
                  levelColor: _green,
                ),
                _Hairline(),
                _ReminderTile(
                  title: 'Call mom',
                  subtitle: 'Tomorrow, 8:00 PM',
                  level: 'Low',
                  levelColor: _green,
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const _SectionHeading(title: 'Suggested by AI', trailing: 'View all'),
          const SizedBox(height: 12),
          const Row(
            children: [
              Expanded(
                child: _AiTipCard(
                  icon: CupertinoIcons.bolt_fill,
                  iconColor: _purple,
                  title: 'Focus Time',
                  copy:
                      'You have a busy afternoon.\nStart 90 min focus session',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _AiTipCard(
                  icon: CupertinoIcons.calendar,
                  iconColor: _red,
                  title: 'Prep for Meeting',
                  copy: 'Project review at 1 PM\nReview notes & slides',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AssistantChatScreen extends StatelessWidget {
  const AssistantChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _PhonePage(
      tabItems: _homeTabs,
      selectedRoute: AppRoutes.chat,
      pinnedComposer: true,
      composer: const Padding(
        padding: EdgeInsets.fromLTRB(20, 6, 20, 10),
        child: _ComposerBar(placeholder: 'Ask anything...'),
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 8),
        children: [
          _BrandHeader(
            left: CupertinoIcons.line_horizontal_3,
            right: const [
              CupertinoIcons.time,
              CupertinoIcons.ellipsis_vertical,
            ],
          ),
          const SizedBox(height: 18),
          const _PillSegmentBar(labels: ['Chat', 'Voice'], selectedIndex: 0),
          const SizedBox(height: 26),
          const Align(
            alignment: Alignment.centerRight,
            child: _ChatBubble(
              text: 'Summarize my meetings today\nand create action items.',
              mine: true,
            ),
          ),
          const SizedBox(height: 18),
          const Align(
            alignment: Alignment.centerLeft,
            child: _ChatBubble(
              text:
                  'Here’s a summary of your meetings today\nand the action items extracted.',
            ),
          ),
          const SizedBox(height: 14),
          _InsetCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _CardTitle('Meeting Summary – May 15, 2025'),
                SizedBox(height: 12),
                _BulletLine(
                  'Team Standup: Discussed sprint progress and blockers.',
                ),
                _BulletLine(
                  'Project Review: Reviewed timeline and budget. Approved phase 2.',
                ),
                _BulletLine(
                  'Client Call: Gathered final requirements and next steps.',
                ),
                SizedBox(height: 16),
                _CardTitle('Action Items (5)'),
                SizedBox(height: 10),
                _ActionItemLine(
                  title: 'Share project timeline with client',
                  trailing: 'Today',
                ),
                _ActionItemLine(
                  title: 'Prepare budget update',
                  trailing: 'Tomorrow',
                ),
                _ActionItemLine(
                  title: 'Review design mockups',
                  trailing: 'May 17',
                ),
                SizedBox(height: 8),
                Text(
                  'View all action items',
                  style: TextStyle(
                    color: _purple,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              _MiniActionChip(icon: CupertinoIcons.hand_thumbsup),
              SizedBox(width: 8),
              _MiniActionChip(icon: CupertinoIcons.hand_thumbsdown),
              SizedBox(width: 8),
              _MiniActionChip(icon: CupertinoIcons.doc_on_doc),
              SizedBox(width: 8),
              _MiniActionChip(icon: CupertinoIcons.arrow_up_left_square),
              SizedBox(width: 8),
              _MiniActionChip(icon: CupertinoIcons.share),
            ],
          ),
          const SizedBox(height: 26),
          const Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _GhostPrompt(text: 'Draft a follow-up email'),
              _GhostPrompt(text: 'Create a task list'),
              _GhostPrompt(text: 'What’s on my calendar?'),
              _GhostPrompt(text: 'Remind me at 6 PM'),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class AssistantGoalsScreen extends StatelessWidget {
  const AssistantGoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _PhonePage(
      tabItems: _goalsTabs,
      selectedRoute: AppRoutes.goals,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 18),
        children: [
          const _InlineHeader(
            title: 'Goals & Habits',
            left: CupertinoIcons.back,
            right: [CupertinoIcons.ellipsis_vertical],
          ),
          const SizedBox(height: 18),
          const _SectionHeading(title: 'Your Progress', trailing: 'View all'),
          const SizedBox(height: 12),
          _InsetCard(
            child: Row(
              children: const [
                _CircleProgress(value: .72, label: '72%'),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Overall Progress',
                        style: TextStyle(
                          color: _subtle,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.smallcircle_fill_circle_fill,
                            size: 10,
                            color: _green,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'On track',
                            style: TextStyle(
                              color: _text,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _CountStat(
                  icon: CupertinoIcons.flame_fill,
                  iconColor: _red,
                  value: '7',
                  label: 'Day Streak',
                ),
                SizedBox(width: 16),
                _CountStat(value: '5', label: 'Goals\nActive'),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const _SectionHeading(title: 'Goals', trailing: 'Add Goal'),
          const SizedBox(height: 12),
          _InsetCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: const [
                _ProgressTask(
                  title: 'Launch new website',
                  progress: .75,
                  percentLabel: '75%',
                  meta: 'Due May 30',
                ),
                _Hairline(),
                _ProgressTask(
                  title: 'Read 20 books this year',
                  progress: .40,
                  percentLabel: '40%',
                  meta: '8 / 20 books',
                ),
                _Hairline(),
                _ProgressTask(
                  title: 'Save \$10,000',
                  progress: .60,
                  percentLabel: '60%',
                  meta: '\$6,000 / \$10,000',
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const _SectionHeading(title: 'Habits', trailing: 'View all'),
          const SizedBox(height: 12),
          _InsetCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: const [
                _HabitTile(
                  icon: CupertinoIcons.sparkles,
                  title: 'Morning Meditation',
                  subtitle: '10 min',
                  streak: '12',
                  activeDots: 5,
                ),
                _Hairline(),
                _HabitTile(
                  icon: CupertinoIcons.heart_fill,
                  title: 'Workout',
                  subtitle: '30 min',
                  streak: '8',
                  activeDots: 7,
                ),
                _Hairline(),
                _HabitTile(
                  icon: CupertinoIcons.drop_fill,
                  title: 'Drink Water',
                  subtitle: '2 L daily',
                  streak: '15',
                  activeDots: 8,
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const _SectionHeading(
            title: 'Upcoming Milestones',
            trailing: 'View all',
          ),
          const SizedBox(height: 12),
          _InsetCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: const [
                _MilestoneTile(
                  icon: CupertinoIcons.globe,
                  title: 'Website Beta Launch',
                  date: 'May 30, 2025',
                  remaining: '15 days left',
                  progress: .76,
                ),
                _Hairline(),
                _MilestoneTile(
                  icon: CupertinoIcons.money_dollar_circle,
                  title: '\$10K Savings Milestone',
                  date: 'Jun 30, 2025',
                  remaining: '46 days left',
                  progress: .42,
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _InsetCard(
            child: Row(
              children: [
                const _RoundAccentIcon(
                  icon: CupertinoIcons.leaf_arrow_circlepath,
                  color: _green,
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Wellness Reminder',
                        style: TextStyle(
                          color: _text,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Take a short break',
                        style: TextStyle(
                          color: _text,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'You’ve been focused for 2h 15m.',
                        style: TextStyle(color: _subtle, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                _PrimaryPillButton(label: 'Start Break'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AssistantDocsEmailScreen extends StatelessWidget {
  const AssistantDocsEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _PhonePage(
      tabItems: _emailTabs,
      selectedRoute: AppRoutes.email,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 18),
        children: [
          const _InlineHeader(
            title: 'Docs & Email',
            left: CupertinoIcons.back,
            right: [CupertinoIcons.ellipsis_vertical],
          ),
          const SizedBox(height: 18),
          const _PillSegmentBar(
            labels: ['Inbox', 'Documents', 'AI Assistant'],
            selectedIndex: 0,
          ),
          const SizedBox(height: 18),
          const _SectionHeading(title: 'Inbox Summary', trailing: 'View all'),
          const SizedBox(height: 12),
          const Row(
            children: [
              Expanded(
                child: _MiniStatCard(
                  icon: CupertinoIcons.mail,
                  color: _purple,
                  label: 'Unread',
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _MiniStatCard(
                  icon: CupertinoIcons.reply,
                  color: _blue,
                  label: 'Needs Reply',
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _MiniStatCard(
                  icon: CupertinoIcons.flag,
                  color: _orange,
                  label: 'Flagged',
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _MiniStatCard(
                  icon: CupertinoIcons.clock,
                  color: _purpleDark,
                  label: 'Snoozed',
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _InsetCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: const [
                _EmailTile(
                  avatarText: 'S',
                  avatarColor: _blue,
                  sender: 'Sarah Johnson',
                  subject: 'Project Update & Next Steps',
                  preview: 'Hi Ahmed, please find the latest update on...',
                  time: '9:15 AM',
                  trailing: CupertinoIcons.flag,
                ),
                _Hairline(),
                _EmailTile(
                  avatarText: 'M',
                  avatarColor: _blue,
                  sender: 'Michael Lee',
                  subject: 'Q2 Budget Review',
                  preview: 'Sharing the revised budget for Q2...',
                  time: '8:30 AM',
                  trailing: CupertinoIcons.paperclip,
                ),
                _Hairline(),
                _EmailTile(
                  avatarText: 'T',
                  avatarColor: _orange,
                  sender: 'Team Sync',
                  subject: 'Meeting Notes – May 15',
                  preview: 'Here are the notes from today’s sync...',
                  time: 'Yesterday',
                  trailing: CupertinoIcons.arrowshape_turn_up_right,
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const _SectionHeading(title: 'AI Summary'),
          const SizedBox(height: 12),
          _InsetCard(
            borderColor: const Color(0xFFDCD3FF),
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.sparkles,
                            color: _purple,
                            size: 16,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'You have 7 emails requiring action.',
                            style: TextStyle(
                              color: _text,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      _BulletLine('3 are high priority'),
                      _BulletLine('2 need a reply'),
                      _BulletLine('1 is waiting for your review'),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                _PrimaryPillButton(label: 'Review All'),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const _SectionHeading(title: 'Documents', trailing: 'View all'),
          const SizedBox(height: 12),
          _InsetCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: const [
                _DocumentTile(
                  iconColor: _red,
                  glyph: CupertinoIcons.doc_fill,
                  title: 'Project Plan v2.1.pdf',
                  meta: 'Updated 2h ago · 1.4 MB',
                ),
                _Hairline(),
                _DocumentTile(
                  iconColor: _green,
                  glyph: CupertinoIcons.table_badge_more,
                  title: 'Q2 Budget.xlsx',
                  meta: 'Updated 5h ago · 220 KB',
                ),
                _Hairline(),
                _DocumentTile(
                  iconColor: _blue,
                  glyph: CupertinoIcons.doc_text_fill,
                  title: 'Client Requirements.docx',
                  meta: 'Updated Yesterday · 56 KB',
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const _SectionHeading(title: 'Quick Actions'),
          const SizedBox(height: 12),
          const Row(
            children: [
              Expanded(
                child: _ActionPill(
                  icon: CupertinoIcons.pencil_outline,
                  label: 'Draft Reply',
                  selected: true,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _ActionPill(
                  icon: CupertinoIcons.sparkles,
                  label: 'Smart Reply',
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _ActionPill(
                  icon: CupertinoIcons.square_pencil,
                  label: 'Create Draft',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AssistantAutomationScreen extends StatelessWidget {
  const AssistantAutomationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _PhonePage(
      tabItems: _automationTabs,
      selectedRoute: AppRoutes.automations,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 18),
        children: [
          const _InlineHeader(
            title: 'Automation Center',
            left: CupertinoIcons.back,
            right: [CupertinoIcons.ellipsis_vertical],
          ),
          const SizedBox(height: 18),
          const _PillSegmentBar(
            labels: ['Workflows', 'Triggers', 'History'],
            selectedIndex: 0,
          ),
          const SizedBox(height: 18),
          const _SectionHeading(
            title: 'Scheduled Workflows',
            trailing: 'View all',
          ),
          const SizedBox(height: 12),
          _InsetCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: const [
                _WorkflowToggleRow(
                  icon: CupertinoIcons.clock,
                  iconColor: _blue,
                  title: 'Daily Standup Summary',
                  subtitle: 'Every weekday at 9:00 AM',
                ),
                _Hairline(),
                _WorkflowToggleRow(
                  icon: CupertinoIcons.chart_bar_alt_fill,
                  iconColor: Colors.pink,
                  title: 'Weekly Report Generator',
                  subtitle: 'Every Monday at 6:00 PM',
                ),
                _Hairline(),
                _WorkflowToggleRow(
                  icon: CupertinoIcons.doc_text,
                  iconColor: _red,
                  title: 'Invoice Reminder',
                  subtitle: '1 day before due date',
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const _SectionHeading(title: 'Approvals', trailing: 'View all'),
          const SizedBox(height: 12),
          _InsetCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: const [
                _ApprovalTile(
                  title: 'Contract Approval',
                  subtitle: 'Requested by Sarah Johnson',
                ),
                _Hairline(),
                _ApprovalTile(
                  title: 'Budget Approval',
                  subtitle: 'Requested by Michael Lee',
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const _SectionHeading(title: 'App Triggers', trailing: 'View all'),
          const SizedBox(height: 12),
          _InsetCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: const [
                _AppTriggerTile(
                  asset: 'assets/images/assistant_gmail.svg',
                  title: 'When I get an email with attachment',
                  subtitle: 'Save to Google Drive',
                  trailingAsset: 'assets/images/assistant_drive.svg',
                ),
                _Hairline(),
                _AppTriggerTile(
                  asset: 'assets/images/assistant_sheets.svg',
                  title: 'When a new row is added in Sheet',
                  subtitle: 'Send me a notification',
                  trailingIcon: CupertinoIcons.bell_fill,
                ),
                _Hairline(),
                _AppTriggerTile(
                  asset: 'assets/images/assistant_calendar.svg',
                  title: 'When meeting is created in Calendar',
                  subtitle: 'Create a prep task',
                  trailingAsset: 'assets/images/assistant_docs.svg',
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const _SectionHeading(title: 'Smart Routines', trailing: 'View all'),
          const SizedBox(height: 12),
          const Row(
            children: [
              Expanded(
                child: _RoutineCard(
                  title: 'Focus Mode',
                  subtitle: 'Silence notifications\n9:00 AM – 12:00 PM',
                  active: true,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _RoutineCard(
                  title: 'Evening Routine',
                  subtitle: 'Daily at 8:00 PM',
                  active: true,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _RoutineCard(
                  title: 'Travel Mode',
                  subtitle: 'When I leave home',
                  active: false,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const _SectionHeading(title: 'Connected Apps', trailing: 'Manage'),
          const SizedBox(height: 12),
          const _ConnectedAppsStrip(),
        ],
      ),
    );
  }
}

class AssistantMoreScreen extends StatelessWidget {
  const AssistantMoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _PhonePage(
      tabItems: _homeTabs,
      selectedRoute: AppRoutes.more,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 18),
        children: [
          _BrandHeader(
            left: CupertinoIcons.line_horizontal_3,
            right: const [CupertinoIcons.slider_horizontal_3],
            titleOverride: 'More',
          ),
          const SizedBox(height: 18),
          const _HeroBlock(
            title: 'Assistant Spaces',
            subtitle: 'Open the additional screens from the broader app set.',
          ),
          const SizedBox(height: 18),
          const _MoreRouteTile(
            route: AppRoutes.family,
            icon: CupertinoIcons.person_2_fill,
            title: 'Family & Relationships',
            subtitle: 'Connections, birthdays, and family notes',
          ),
          const SizedBox(height: 12),
          const _MoreRouteTile(
            route: AppRoutes.finance,
            icon: CupertinoIcons.money_dollar_circle_fill,
            title: 'Finance Insights',
            subtitle: 'Balance, spending, and subscriptions',
          ),
          const SizedBox(height: 12),
          const _MoreRouteTile(
            route: AppRoutes.calendar,
            icon: CupertinoIcons.calendar_today,
            title: 'Calendar & Planner',
            subtitle: 'Schedule, reminders, and upcoming plans',
          ),
          const SizedBox(height: 12),
          const _MoreRouteTile(
            route: AppRoutes.wellness,
            icon: CupertinoIcons.heart_fill,
            title: 'Health & Wellness',
            subtitle: 'Metrics, medications, and insights',
          ),
          const SizedBox(height: 12),
          const _MoreRouteTile(
            route: AppRoutes.vault,
            icon: CupertinoIcons.lock_shield_fill,
            title: 'Privacy Vault',
            subtitle: 'Connected apps, security, and trusted devices',
          ),
        ],
      ),
    );
  }
}

class _PhonePage extends StatelessWidget {
  const _PhonePage({
    required this.child,
    required this.tabItems,
    required this.selectedRoute,
    this.composer,
    this.pinnedComposer = false,
  });

  final Widget child;
  final List<_BottomItemSpec> tabItems;
  final String selectedRoute;
  final Widget? composer;
  final bool pinnedComposer;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(child: child),
            if (composer != null) composer!,
          ],
        ),
      ),
      bottomNavigationBar: _AssistantBottomBar(
        items: tabItems,
        selectedRoute: selectedRoute,
        bottomInset: bottomInset,
      ),
    );
  }
}

class _BrandHeader extends StatelessWidget {
  const _BrandHeader({
    required this.left,
    required this.right,
    this.titleOverride,
  });

  final IconData left;
  final List<IconData> right;
  final String? titleOverride;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _TopIconButton(icon: left),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const _AssistantBadge(),
              const SizedBox(width: 10),
              Text(
                titleOverride ?? 'My Assistant',
                style: const TextStyle(
                  color: _text,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [for (final icon in right) _TopIconButton(icon: icon)],
        ),
      ],
    );
  }
}

class _InlineHeader extends StatelessWidget {
  const _InlineHeader({
    required this.title,
    required this.left,
    required this.right,
  });

  final String title;
  final IconData left;
  final List<IconData> right;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _TopIconButton(icon: left),
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: _text,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.2,
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [for (final icon in right) _TopIconButton(icon: icon)],
        ),
      ],
    );
  }
}

class _TopIconButton extends StatelessWidget {
  const _TopIconButton({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 34,
      height: 34,
      child: IconButton(
        padding: EdgeInsets.zero,
        splashRadius: 18,
        onPressed: () => Navigator.maybePop(context),
        icon: Icon(icon, color: _text, size: 21),
      ),
    );
  }
}

class _AssistantBadge extends StatelessWidget {
  const _AssistantBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: const BoxDecoration(color: _purple, shape: BoxShape.circle),
      child: const Icon(CupertinoIcons.sparkles, size: 12, color: Colors.white),
    );
  }
}

class _HeroBlock extends StatelessWidget {
  const _HeroBlock({
    required this.title,
    required this.subtitle,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                trailing == null ? title : '$title$trailing',
                style: const TextStyle(
                  color: _text,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          subtitle,
          style: const TextStyle(color: _subtle, fontSize: 13.5, height: 1.35),
        ),
      ],
    );
  }
}

class _SearchComposer extends StatelessWidget {
  const _SearchComposer({required this.placeholder});

  final String placeholder;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 14, right: 8),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0B1B1825),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(CupertinoIcons.search, color: _subtle, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              placeholder,
              style: const TextStyle(color: _subtle, fontSize: 14),
            ),
          ),
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [_purple, _purpleDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              CupertinoIcons.mic,
              color: Colors.white,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}

class _ComposerBar extends StatelessWidget {
  const _ComposerBar({required this.placeholder});

  final String placeholder;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 14, right: 8),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              placeholder,
              style: const TextStyle(color: _subtle, fontSize: 14),
            ),
          ),
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [_purple, _purpleDark]),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              CupertinoIcons.mic,
              color: Colors.white,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({
    required this.title,
    this.trailing,
    this.dense = false,
  });

  final String title;
  final String? trailing;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: _text,
              fontSize: dense ? 15 : 15.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        if (trailing != null)
          Text(
            trailing!,
            style: const TextStyle(
              color: _purple,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }
}

class _InsetCard extends StatelessWidget {
  const _InsetCard({
    required this.child,
    this.padding = const EdgeInsets.all(14),
    this.borderColor = _border,
  });

  final Widget child;
  final EdgeInsets padding;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
        boxShadow: const [
          BoxShadow(
            color: Color(0x081B1825),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _QuickActionRow extends StatelessWidget {
  const _QuickActionRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: _QuickActionTile(
            icon: CupertinoIcons.calendar_badge_plus,
            color: _purple,
            line1: 'Add',
            line2: 'Reminder',
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: _QuickActionTile(
            icon: CupertinoIcons.scope,
            color: _green,
            line1: 'Start',
            line2: 'Focus',
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: _QuickActionTile(
            icon: Icons.document_scanner_outlined,
            color: _blue,
            line1: 'Scan',
            line2: 'Document',
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: _QuickActionTile(
            icon: CupertinoIcons.square_pencil,
            color: _orange,
            line1: 'Create',
            line2: 'Note',
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: _QuickActionTile(
            icon: CupertinoIcons.music_note_2,
            color: Color(0xFFE84B83),
            line1: 'Play',
            line2: 'Music',
          ),
        ),
      ],
    );
  }
}

class _QuickActionTile extends StatelessWidget {
  const _QuickActionTile({
    required this.icon,
    required this.color,
    required this.line1,
    required this.line2,
  });

  final IconData icon;
  final Color color;
  final String line1;
  final String line2;

  @override
  Widget build(BuildContext context) {
    return _InsetCard(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 14),
      child: Column(
        children: [
          Icon(icon, size: 21, color: color),
          const SizedBox(height: 10),
          Text(
            '$line1\n$line2',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: _text,
              fontSize: 10.4,
              height: 1.12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _TodayStatsRow extends StatelessWidget {
  const _TodayStatsRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: _StatMetric(value: '3', label: 'Tasks Due'),
        ),
        _ThinDivider(),
        Expanded(
          child: _StatMetric(value: '2', label: 'Events'),
        ),
        _ThinDivider(),
        Expanded(
          child: _StatMetric(
            icon: CupertinoIcons.cloud_sun_fill,
            iconColor: _orange,
            value: '26°C',
            label: 'Partly Cloudy',
          ),
        ),
        _ThinDivider(),
        Expanded(
          child: _StatMetric(
            icon: CupertinoIcons.location_solid,
            iconColor: _orange,
            value: 'Good',
            label: 'Mood',
          ),
        ),
      ],
    );
  }
}

class _StatMetric extends StatelessWidget {
  const _StatMetric({
    required this.value,
    required this.label,
    this.icon,
    this.iconColor,
  });

  final String value;
  final String label;
  final IconData? icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (icon != null) ...[
          Icon(icon, size: 18, color: iconColor ?? _subtle),
          const SizedBox(height: 6),
        ],
        Text(
          value,
          style: const TextStyle(
            color: _text,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(color: _subtle, fontSize: 11.5, height: 1.2),
        ),
      ],
    );
  }
}

class _ThinDivider extends StatelessWidget {
  const _ThinDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 40,
      color: _border,
      margin: const EdgeInsets.symmetric(horizontal: 8),
    );
  }
}

class _ReminderTile extends StatelessWidget {
  const _ReminderTile({
    required this.title,
    required this.subtitle,
    required this.level,
    required this.levelColor,
  });

  final String title;
  final String subtitle;
  final String level;
  final Color levelColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      child: Row(
        children: [
          const Icon(CupertinoIcons.square, size: 17, color: _subtle),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: _text,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: _subtle, fontSize: 12),
                ),
              ],
            ),
          ),
          _LevelBadge(label: level, color: levelColor),
        ],
      ),
    );
  }
}

class _LevelBadge extends StatelessWidget {
  const _LevelBadge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _AiTipCard extends StatelessWidget {
  const _AiTipCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.copy,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String copy;

  @override
  Widget build(BuildContext context) {
    return _InsetCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _RoundAccentIcon(icon: icon, color: iconColor),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: _text,
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            copy,
            style: const TextStyle(color: _subtle, fontSize: 12, height: 1.45),
          ),
        ],
      ),
    );
  }
}

class _PillSegmentBar extends StatelessWidget {
  const _PillSegmentBar({required this.labels, required this.selectedIndex});

  final List<String> labels;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _border),
      ),
      child: Row(
        children: [
          for (var index = 0; index < labels.length; index++)
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: index == selectedIndex ? _purple : Colors.transparent,
                  borderRadius: BorderRadius.circular(18),
                ),
                alignment: Alignment.center,
                child: Text(
                  labels[index],
                  style: TextStyle(
                    color: index == selectedIndex ? Colors.white : _subtle,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({required this.text, this.mine = false});

  final String text;
  final bool mine;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 250),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      decoration: BoxDecoration(
        color: mine ? _purple : _card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: mine ? _purple : _border),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: mine ? Colors.white : _text,
          fontSize: 13.5,
          height: 1.35,
        ),
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  const _CardTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: _text,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _BulletLine extends StatelessWidget {
  const _BulletLine(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Icon(CupertinoIcons.circle_fill, size: 5, color: _subtle),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: _text,
                fontSize: 12.5,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionItemLine extends StatelessWidget {
  const _ActionItemLine({required this.title, required this.trailing});

  final String title;
  final String trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        children: [
          const Icon(
            CupertinoIcons.check_mark_circled,
            size: 16,
            color: _purple,
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: _text, fontSize: 12.5),
            ),
          ),
          Text(
            trailing,
            style: const TextStyle(color: _subtle, fontSize: 11.5),
          ),
        ],
      ),
    );
  }
}

class _MiniActionChip extends StatelessWidget {
  const _MiniActionChip({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _border),
      ),
      child: Icon(icon, size: 16, color: _subtle),
    );
  }
}

class _GhostPrompt extends StatelessWidget {
  const _GhostPrompt({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _border),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: _purple,
          fontSize: 12.5,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _CircleProgress extends StatelessWidget {
  const _CircleProgress({required this.value, required this.label});

  final double value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 64,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 58,
            height: 58,
            child: CircularProgressIndicator(
              value: value,
              strokeWidth: 5,
              color: _purple,
              backgroundColor: _purpleSoft,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: _text,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _CountStat extends StatelessWidget {
  const _CountStat({
    required this.value,
    required this.label,
    this.icon,
    this.iconColor,
  });

  final String value;
  final String label;
  final IconData? icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (icon != null) ...[
          Icon(icon, size: 17, color: iconColor ?? _text),
          const SizedBox(height: 4),
        ],
        Text(
          value,
          style: const TextStyle(
            color: _text,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(color: _subtle, fontSize: 11, height: 1.2),
        ),
      ],
    );
  }
}

class _ProgressTask extends StatelessWidget {
  const _ProgressTask({
    required this.title,
    required this.progress,
    required this.percentLabel,
    required this.meta,
  });

  final String title;
  final double progress;
  final String percentLabel;
  final String meta;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: _text,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                percentLabel,
                style: const TextStyle(
                  color: _text,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                meta,
                style: const TextStyle(color: _subtle, fontSize: 11.5),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              minHeight: 6,
              value: progress,
              backgroundColor: const Color(0xFFE8E3F3),
              color: _purple,
            ),
          ),
        ],
      ),
    );
  }
}

class _HabitTile extends StatelessWidget {
  const _HabitTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.streak,
    required this.activeDots,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String streak;
  final int activeDots;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          _RoundAccentIcon(icon: icon, color: _purple),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: _text,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(color: _subtle, fontSize: 11.5),
                ),
                const SizedBox(height: 8),
                _HabitDots(activeDots: activeDots),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                streak,
                style: const TextStyle(
                  color: _text,
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                'day streak',
                style: TextStyle(color: _subtle, fontSize: 10.5),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HabitDots extends StatelessWidget {
  const _HabitDots({required this.activeDots});

  final int activeDots;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var index = 0; index < 10; index++)
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(right: 9),
            decoration: BoxDecoration(
              color: index < activeDots ? _purple : const Color(0xFFE9E5F1),
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }
}

class _MilestoneTile extends StatelessWidget {
  const _MilestoneTile({
    required this.icon,
    required this.title,
    required this.date,
    required this.remaining,
    required this.progress,
  });

  final IconData icon;
  final String title;
  final String date;
  final String remaining;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          _RoundAccentIcon(icon: icon, color: _orange),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: _text,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  date,
                  style: const TextStyle(color: _subtle, fontSize: 11.5),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(99),
                  child: LinearProgressIndicator(
                    minHeight: 5,
                    value: progress,
                    color: _purple,
                    backgroundColor: const Color(0xFFE8E3F3),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            remaining,
            style: const TextStyle(color: _subtle, fontSize: 11.5),
          ),
        ],
      ),
    );
  }
}

class _RoundAccentIcon extends StatelessWidget {
  const _RoundAccentIcon({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 16, color: color),
    );
  }
}

class _PrimaryPillButton extends StatelessWidget {
  const _PrimaryPillButton({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [_purple, _purpleDark]),
        borderRadius: BorderRadius.circular(17),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _MiniStatCard extends StatelessWidget {
  const _MiniStatCard({
    required this.icon,
    required this.color,
    required this.label,
  });

  final IconData icon;
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return _InsetCard(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Column(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(height: 9),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: _text,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmailTile extends StatelessWidget {
  const _EmailTile({
    required this.avatarText,
    required this.avatarColor,
    required this.sender,
    required this.subject,
    required this.preview,
    required this.time,
    required this.trailing,
  });

  final String avatarText;
  final Color avatarColor;
  final String sender;
  final String subject;
  final String preview;
  final String time;
  final IconData trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: avatarColor,
            child: Text(
              avatarText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        sender,
                        style: const TextStyle(
                          color: _text,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      time,
                      style: const TextStyle(color: _subtle, fontSize: 11.5),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  subject,
                  style: const TextStyle(
                    color: _text,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        preview,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: _subtle, fontSize: 11.5),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(trailing, size: 14, color: _subtle),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DocumentTile extends StatelessWidget {
  const _DocumentTile({
    required this.iconColor,
    required this.glyph,
    required this.title,
    required this.meta,
  });

  final Color iconColor;
  final IconData glyph;
  final String title;
  final String meta;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(glyph, size: 16, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: _text,
                    fontSize: 12.8,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  meta,
                  style: const TextStyle(color: _subtle, fontSize: 11.5),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _purpleSoft,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Summarize',
              style: TextStyle(
                color: _purple,
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionPill extends StatelessWidget {
  const _ActionPill({
    required this.icon,
    required this.label,
    this.selected = false,
  });

  final IconData icon;
  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final background = selected ? _purple : _card;
    final foreground = selected ? Colors.white : _purple;
    final border = selected ? _purple : _border;
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 15, color: foreground),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: foreground,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkflowToggleRow extends StatelessWidget {
  const _WorkflowToggleRow({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          _RoundAccentIcon(icon: icon, color: iconColor),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: _text,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: _subtle, fontSize: 11.5),
                ),
              ],
            ),
          ),
          CupertinoSwitch(
            value: true,
            onChanged: (_) {},
            activeTrackColor: _purple,
          ),
        ],
      ),
    );
  }
}

class _ApprovalTile extends StatelessWidget {
  const _ApprovalTile({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          const _RoundAccentIcon(
            icon: CupertinoIcons.checkmark_alt_circle,
            color: _purple,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: _text,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: _subtle, fontSize: 11.5),
                ),
              ],
            ),
          ),
          const _ApprovalButton(label: 'Approve', color: _green),
          const SizedBox(width: 8),
          const _ApprovalButton(label: 'Decline', color: _red),
        ],
      ),
    );
  }
}

class _ApprovalButton extends StatelessWidget {
  const _ApprovalButton({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.11),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _AppTriggerTile extends StatelessWidget {
  const _AppTriggerTile({
    required this.asset,
    required this.title,
    required this.subtitle,
    this.trailingAsset,
    this.trailingIcon,
  });

  final String asset;
  final String title;
  final String subtitle;
  final String? trailingAsset;
  final IconData? trailingIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          _SvgBrandIcon(asset: asset),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: _text,
                    fontSize: 12.8,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: _subtle, fontSize: 11.5),
                ),
              ],
            ),
          ),
          if (trailingAsset != null)
            _SvgBrandIcon(asset: trailingAsset!, size: 20),
          if (trailingIcon != null) Icon(trailingIcon, size: 18, color: _blue),
          const SizedBox(width: 10),
          CupertinoSwitch(
            value: true,
            onChanged: (_) {},
            activeTrackColor: _purple,
          ),
        ],
      ),
    );
  }
}

class _RoutineCard extends StatelessWidget {
  const _RoutineCard({
    required this.title,
    required this.subtitle,
    required this.active,
  });

  final String title;
  final String subtitle;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return _InsetCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: _text,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            style: const TextStyle(
              color: _subtle,
              fontSize: 11.2,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: CupertinoSwitch(
              value: active,
              onChanged: (_) {},
              activeTrackColor: _purple,
            ),
          ),
        ],
      ),
    );
  }
}

class _ConnectedAppsStrip extends StatelessWidget {
  const _ConnectedAppsStrip();

  @override
  Widget build(BuildContext context) {
    return _InsetCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          _SvgBrandIcon(asset: 'assets/images/assistant_gmail.svg'),
          _SvgBrandIcon(asset: 'assets/images/assistant_drive.svg'),
          _SvgBrandIcon(asset: 'assets/images/assistant_slack.svg'),
          _SvgBrandIcon(asset: 'assets/images/assistant_notion.svg'),
          _SvgBrandIcon(asset: 'assets/images/assistant_docs.svg'),
          _RoundMoreBadge(text: '+12'),
        ],
      ),
    );
  }
}

class _RoundMoreBadge extends StatelessWidget {
  const _RoundMoreBadge({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: const BoxDecoration(
        color: _purpleSoft,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          color: _purple,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _SvgBrandIcon extends StatelessWidget {
  const _SvgBrandIcon({required this.asset, this.size = 22});

  final String asset;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size, height: size, child: SvgPicture.asset(asset));
  }
}

class _MoreRouteTile extends StatelessWidget {
  const _MoreRouteTile({
    required this.route,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final String route;
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => context.go(route),
      child: _InsetCard(
        child: Row(
          children: [
            _RoundAccentIcon(icon: icon, color: _purple),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: _text,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(color: _subtle, fontSize: 12),
                  ),
                ],
              ),
            ),
            const Icon(CupertinoIcons.chevron_right, color: _subtle, size: 17),
          ],
        ),
      ),
    );
  }
}

class _Hairline extends StatelessWidget {
  const _Hairline();

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, indent: 14, endIndent: 14, color: _border);
  }
}

class _AssistantBottomBar extends StatelessWidget {
  const _AssistantBottomBar({
    required this.items,
    required this.selectedRoute,
    required this.bottomInset,
  });

  final List<_BottomItemSpec> items;
  final String selectedRoute;
  final double bottomInset;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: _border)),
      ),
      padding: EdgeInsets.fromLTRB(8, 7, 8, bottomInset > 0 ? bottomInset : 6),
      child: Row(
        children: [
          for (final item in items)
            Expanded(
              child: _BottomBarItem(
                item: item,
                selected: selectedRoute == item.route,
              ),
            ),
        ],
      ),
    );
  }
}

class _BottomBarItem extends StatelessWidget {
  const _BottomBarItem({required this.item, required this.selected});

  final _BottomItemSpec item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final color = selected ? _purple : _subtle;
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => context.go(item.route),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              selected ? item.activeIcon : item.icon,
              size: 22,
              color: color,
            ),
            const SizedBox(height: 4),
            Text(
              item.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: color,
                fontSize: 10.5,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomItemSpec {
  const _BottomItemSpec({
    required this.route,
    required this.label,
    required this.icon,
    required this.activeIcon,
  });

  final String route;
  final String label;
  final IconData icon;
  final IconData activeIcon;
}

const _homeTabs = [
  _BottomItemSpec(
    route: AppRoutes.home,
    label: 'Home',
    icon: CupertinoIcons.house,
    activeIcon: CupertinoIcons.house_fill,
  ),
  _BottomItemSpec(
    route: AppRoutes.chat,
    label: 'Chat',
    icon: CupertinoIcons.chat_bubble_2,
    activeIcon: CupertinoIcons.chat_bubble_2_fill,
  ),
  _BottomItemSpec(
    route: AppRoutes.goals,
    label: 'Tasks',
    icon: CupertinoIcons.checkmark_square,
    activeIcon: CupertinoIcons.checkmark_square_fill,
  ),
  _BottomItemSpec(
    route: AppRoutes.calendar,
    label: 'Calendar',
    icon: CupertinoIcons.calendar,
    activeIcon: CupertinoIcons.calendar_today,
  ),
  _BottomItemSpec(
    route: AppRoutes.more,
    label: 'More',
    icon: CupertinoIcons.line_horizontal_3,
    activeIcon: CupertinoIcons.line_horizontal_3,
  ),
];

const _goalsTabs = [
  _BottomItemSpec(
    route: AppRoutes.home,
    label: 'Home',
    icon: CupertinoIcons.house,
    activeIcon: CupertinoIcons.house_fill,
  ),
  _BottomItemSpec(
    route: AppRoutes.goals,
    label: 'Goals',
    icon: CupertinoIcons.checkmark_alt_circle,
    activeIcon: CupertinoIcons.checkmark_alt_circle_fill,
  ),
  _BottomItemSpec(
    route: AppRoutes.calendar,
    label: 'Calendar',
    icon: CupertinoIcons.calendar,
    activeIcon: CupertinoIcons.calendar_today,
  ),
  _BottomItemSpec(
    route: AppRoutes.chat,
    label: 'Assistant',
    icon: CupertinoIcons.sparkles,
    activeIcon: CupertinoIcons.sparkles,
  ),
  _BottomItemSpec(
    route: AppRoutes.more,
    label: 'More',
    icon: CupertinoIcons.line_horizontal_3,
    activeIcon: CupertinoIcons.line_horizontal_3,
  ),
];

const _emailTabs = [
  _BottomItemSpec(
    route: AppRoutes.home,
    label: 'Home',
    icon: CupertinoIcons.house,
    activeIcon: CupertinoIcons.house_fill,
  ),
  _BottomItemSpec(
    route: AppRoutes.email,
    label: 'Email',
    icon: CupertinoIcons.mail,
    activeIcon: CupertinoIcons.mail_solid,
  ),
  _BottomItemSpec(
    route: AppRoutes.chat,
    label: 'Assistant',
    icon: CupertinoIcons.sparkles,
    activeIcon: CupertinoIcons.sparkles,
  ),
  _BottomItemSpec(
    route: AppRoutes.more,
    label: 'Files',
    icon: CupertinoIcons.doc,
    activeIcon: CupertinoIcons.doc_fill,
  ),
  _BottomItemSpec(
    route: AppRoutes.more,
    label: 'More',
    icon: CupertinoIcons.line_horizontal_3,
    activeIcon: CupertinoIcons.line_horizontal_3,
  ),
];

const _automationTabs = [
  _BottomItemSpec(
    route: AppRoutes.home,
    label: 'Home',
    icon: CupertinoIcons.house,
    activeIcon: CupertinoIcons.house_fill,
  ),
  _BottomItemSpec(
    route: AppRoutes.automations,
    label: 'Automations',
    icon: CupertinoIcons.arrow_2_circlepath,
    activeIcon: CupertinoIcons.arrow_2_circlepath_circle_fill,
  ),
  _BottomItemSpec(
    route: AppRoutes.chat,
    label: 'Assistant',
    icon: CupertinoIcons.sparkles,
    activeIcon: CupertinoIcons.sparkles,
  ),
  _BottomItemSpec(
    route: AppRoutes.more,
    label: 'More',
    icon: CupertinoIcons.line_horizontal_3,
    activeIcon: CupertinoIcons.line_horizontal_3,
  ),
];
