// ignore_for_file: lines_longer_than_80_chars, prefer_const_constructors

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const _purple = Color(0xFF6D42EA);
const _purpleDark = Color(0xFF4E2CCB);
const _ink = Color(0xFF14121F);
const _muted = Color(0xFF6F6A7C);
const _line = Color(0xFFECE8F4);
const _surface = Color(0xFFF9F7FC);
const _green = Color(0xFF24A365);
const _red = Color(0xFFE64949);
const _orange = Color(0xFFF49B22);
const _blue = Color(0xFF2D88E6);

class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _ScreenFrame(
      title: 'My Assistant',
      leading: Icons.menu_rounded,
      trailing: const [Icons.notifications_none_rounded],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HeroText(
            title: 'Good Morning, Ahmed',
            subtitle: "Your day is ready. Let's get things done.",
          ),
          const SizedBox(height: 16),
          const _SearchBar(),
          const SizedBox(height: 20),
          _SectionHeader('Quick Actions', action: 'Customize'),
          _QuickActions(
            actions: const [
              _ActionData(
                Icons.event_available_rounded,
                'Add\nReminder',
                _purple,
              ),
              _ActionData(
                Icons.center_focus_strong_rounded,
                'Start\nFocus',
                _green,
              ),
              _ActionData(
                Icons.document_scanner_rounded,
                'Scan\nDocument',
                _blue,
              ),
              _ActionData(Icons.note_add_outlined, 'Create\nNote', _orange),
              _ActionData(Icons.music_note_rounded, 'Play\nMusic', Colors.pink),
            ],
          ),
          const SizedBox(height: 18),
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionHeader('Today at a Glance', action: 'May 15, 2025'),
                const SizedBox(height: 14),
                Row(
                  children: const [
                    _MetricTile(value: '3', label: 'Tasks Due'),
                    _MetricTile(value: '2', label: 'Events'),
                    _MetricTile(value: '26 C', label: 'Partly Cloudy'),
                    _MetricTile(value: 'Good', label: 'Mood'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _SectionHeader('Reminders', action: 'View all'),
          _Card(
            padding: EdgeInsets.zero,
            child: Column(
              children: const [
                _TaskRow('Submit project report', 'Today, 6:00 PM', 'Medium'),
                _DividerInset(),
                _TaskRow('Buy groceries', 'Today, 7:30 PM', 'Low'),
                _DividerInset(),
                _TaskRow('Call mom', 'Tomorrow, 8:00 PM', 'Low'),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _SectionHeader('Suggested by AI', action: 'View all'),
          Row(
            children: const [
              Expanded(
                child: _SuggestionCard(
                  icon: Icons.bolt_rounded,
                  title: 'Focus Time',
                  body:
                      'You have a busy afternoon.\nStart 90 min focus session',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _SuggestionCard(
                  icon: Icons.calendar_month_rounded,
                  title: 'Prep for Meeting',
                  body: 'Project review at 1 PM\nReview notes and slides',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ChatAssistantScreen extends StatelessWidget {
  const ChatAssistantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _ScreenFrame(
      title: 'My Assistant',
      leading: Icons.menu_rounded,
      trailing: const [Icons.history_rounded, Icons.more_vert_rounded],
      bottomGap: 110,
      child: Column(
        children: [
          const _SegmentedPill(labels: ['Chat', 'Voice'], selected: 0),
          const SizedBox(height: 26),
          Align(
            alignment: Alignment.centerRight,
            child: _Bubble(
              text: 'Summarize my meetings today\nand create action items.',
              active: true,
            ),
          ),
          const SizedBox(height: 16),
          const _Bubble(
            text:
                "Here's a summary of your meetings today\nand the action items extracted.",
          ),
          const SizedBox(height: 14),
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _TinyTitle('Meeting Summary - May 15, 2025'),
                SizedBox(height: 10),
                _Bullet(
                  'Team Standup: Discussed sprint progress and blockers.',
                ),
                _Bullet(
                  'Project Review: Approved phase 2 timeline and budget.',
                ),
                _Bullet(
                  'Client Call: Gathered final requirements and next steps.',
                ),
                SizedBox(height: 16),
                _TinyTitle('Action Items (5)'),
                SizedBox(height: 8),
                _CheckLine('Share project timeline with client', 'Today'),
                _CheckLine('Prepare budget update', 'Tomorrow'),
                _CheckLine('Review design mockups', 'May 17'),
                SizedBox(height: 8),
                Text(
                  'View all action items',
                  style: TextStyle(color: _purple, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: const [
              _IconChip(Icons.thumb_up_alt_outlined),
              _IconChip(Icons.thumb_down_alt_outlined),
              _IconChip(Icons.copy_rounded),
              _IconChip(Icons.open_in_new_rounded),
              _IconChip(Icons.file_upload_outlined),
            ],
          ),
          const SizedBox(height: 36),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: const [
              _PromptChip('Draft a follow-up email'),
              _PromptChip('Create a task list'),
              _PromptChip("What's on my calendar?"),
              _PromptChip('Remind me at 6 PM'),
            ],
          ),
          const SizedBox(height: 22),
          const _ChatInput(),
        ],
      ),
    );
  }
}

class GoalsHabitsScreen extends StatelessWidget {
  const GoalsHabitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _ScreenFrame(
      title: 'Goals & Habits',
      leading: Icons.arrow_back_rounded,
      trailing: const [Icons.more_vert_rounded],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader('Your Progress', action: 'View all'),
          _Card(
            child: Row(
              children: const [
                _ProgressRing(value: .72, label: '72%'),
                SizedBox(width: 16),
                Expanded(
                  child: _StatusMini(
                    title: 'Overall Progress',
                    value: 'On track',
                  ),
                ),
                _StatColumn(
                  value: '7',
                  label: 'Day Streak',
                  icon: Icons.local_fire_department_rounded,
                ),
                _StatColumn(value: '5', label: 'Goals\nActive'),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _SectionHeader('Goals', action: 'Add Goal'),
          _Card(
            padding: EdgeInsets.zero,
            child: Column(
              children: const [
                _ProgressRow('Launch new website', '75%', .75, 'Due May 30'),
                _DividerInset(),
                _ProgressRow(
                  'Read 20 books this year',
                  '40%',
                  .40,
                  '8 / 20 books',
                ),
                _DividerInset(),
                _ProgressRow('Save \$10,000', '60%', .60, '\$6,000 / \$10,000'),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _SectionHeader('Habits', action: 'View all'),
          _Card(
            padding: EdgeInsets.zero,
            child: Column(
              children: const [
                _HabitRow(
                  Icons.self_improvement_rounded,
                  'Morning Meditation',
                  '10 min',
                  '12',
                ),
                _DividerInset(),
                _HabitRow(
                  Icons.directions_run_rounded,
                  'Workout',
                  '30 min',
                  '8',
                ),
                _DividerInset(),
                _HabitRow(
                  Icons.water_drop_outlined,
                  'Drink Water',
                  '2 L daily',
                  '15',
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _SectionHeader('Upcoming Milestones', action: 'View all'),
          _Card(
            padding: EdgeInsets.zero,
            child: Column(
              children: const [
                _MilestoneRow(
                  Icons.web_asset_rounded,
                  'Website Beta Launch',
                  'May 30, 2025',
                  '15 days left',
                  .78,
                ),
                _DividerInset(),
                _MilestoneRow(
                  Icons.savings_outlined,
                  '\$10K Savings Milestone',
                  'Jun 30, 2025',
                  '46 days left',
                  .42,
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const _WellnessNudge(),
        ],
      ),
    );
  }
}

class DocsEmailScreen extends StatelessWidget {
  const DocsEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _ScreenFrame(
      title: 'Docs & Email',
      leading: Icons.arrow_back_rounded,
      trailing: const [Icons.more_vert_rounded],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SegmentedPill(
            labels: ['Inbox', 'Documents', 'AI Assistant'],
            selected: 0,
          ),
          const SizedBox(height: 18),
          _SectionHeader('Inbox Summary', action: 'View all'),
          Row(
            children: const [
              _MailboxStat(Icons.mail_outline_rounded, 'Unread'),
              _MailboxStat(Icons.mark_email_unread_outlined, 'Needs Reply'),
              _MailboxStat(Icons.flag_outlined, 'Flagged'),
              _MailboxStat(Icons.schedule_rounded, 'Snoozed'),
            ],
          ),
          const SizedBox(height: 14),
          _Card(
            padding: EdgeInsets.zero,
            child: Column(
              children: const [
                _EmailRow(
                  'S',
                  'Sarah Johnson',
                  'Project Update & Next Steps',
                  '9:15 AM',
                  _blue,
                ),
                _DividerInset(),
                _EmailRow(
                  'M',
                  'Michael Lee',
                  'Q2 Budget Review',
                  '8:30 AM',
                  _blue,
                ),
                _DividerInset(),
                _EmailRow(
                  'T',
                  'Team Sync',
                  'Meeting Notes - May 15',
                  'Yesterday',
                  _orange,
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _SectionHeader('AI Summary'),
          _Card(
            borderColor: _purple.withValues(alpha: .35),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'You have 7 emails requiring action.\n\n3 are high priority\n2 need a reply\n1 is waiting for your review',
                    style: TextStyle(height: 1.45, color: _ink),
                  ),
                ),
                FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: _purple),
                  onPressed: () {},
                  child: const Text('Review AI'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _SectionHeader('Documents', action: 'View all'),
          _Card(
            padding: EdgeInsets.zero,
            child: Column(
              children: const [
                _DocumentRow(
                  Icons.picture_as_pdf_rounded,
                  'Project Plan v2.1.pdf',
                  'Updated 2h ago - 1.4 MB',
                  Colors.red,
                ),
                _DividerInset(),
                _DocumentRow(
                  Icons.table_chart_rounded,
                  'Q2 Budget.xlsx',
                  'Updated 5h ago - 220 KB',
                  Colors.green,
                ),
                _DividerInset(),
                _DocumentRow(
                  Icons.description_rounded,
                  'Client Requirements.docx',
                  'Updated Yesterday - 56 KB',
                  _blue,
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: const [
              Expanded(
                child: _PrimaryActionButton(
                  Icons.edit_note_rounded,
                  'Draft Reply',
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _SoftActionButton(Icons.reply_rounded, 'Smart Reply'),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _SoftActionButton(Icons.create_rounded, 'Create Draft'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AutomationCenterScreen extends StatelessWidget {
  const AutomationCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _ScreenFrame(
      title: 'Automation Center',
      leading: Icons.arrow_back_rounded,
      trailing: const [Icons.more_vert_rounded],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SegmentedPill(
            labels: ['Workflows', 'Triggers', 'History'],
            selected: 0,
          ),
          const SizedBox(height: 18),
          _SectionHeader('Scheduled Workflows', action: 'View all'),
          _Card(
            padding: EdgeInsets.zero,
            child: Column(
              children: const [
                _ToggleRow(
                  Icons.summarize_outlined,
                  'Daily Standup Summary',
                  'Every weekday at 9:00 AM',
                  true,
                ),
                _DividerInset(),
                _ToggleRow(
                  Icons.auto_graph_rounded,
                  'Weekly Report Generator',
                  'Every Monday at 6:00 PM',
                  true,
                ),
                _DividerInset(),
                _ToggleRow(
                  Icons.receipt_long_rounded,
                  'Invoice Reminder',
                  '1 day before due date',
                  true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _SectionHeader('Approvals', action: 'View all'),
          _Card(
            padding: EdgeInsets.zero,
            child: Column(
              children: const [
                _ApprovalRow('Contract Approval', 'Requested by Sarah Johnson'),
                _DividerInset(),
                _ApprovalRow('Budget Approval', 'Requested by Michael Lee'),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _SectionHeader('App Triggers', action: 'View all'),
          _Card(
            padding: EdgeInsets.zero,
            child: Column(
              children: const [
                _ToggleRow(
                  Icons.mail_rounded,
                  'When I get an email with attachment',
                  'Save to Google Drive',
                  true,
                ),
                _DividerInset(),
                _ToggleRow(
                  Icons.grid_on_rounded,
                  'When a new row is added in Sheet',
                  'Send me a notification',
                  true,
                ),
                _DividerInset(),
                _ToggleRow(
                  Icons.calendar_today_rounded,
                  'When meeting is created in Calendar',
                  'Create a prep task',
                  true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _SectionHeader('Smart Routines', action: 'View all'),
          Row(
            children: const [
              Expanded(
                child: _RoutineCard(
                  'Focus Mode',
                  'Silence notifications\n9:00 AM - 12:00 PM',
                  true,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _RoutineCard(
                  'Evening Routine',
                  'Daily at 8:00 PM',
                  true,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _RoutineCard('Travel Mode', 'When I leave home', false),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _SectionHeader('Connected Apps', action: 'Manage'),
          const _ConnectedApps(),
        ],
      ),
    );
  }
}

class FamilyRelationshipsScreen extends StatelessWidget {
  const FamilyRelationshipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _ScreenFrame(
      title: 'My Assistant',
      leading: Icons.menu_rounded,
      trailing: const [Icons.notifications_none_rounded],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _HeroText(
            title: 'Family & Relationships',
            subtitle: 'Stay connected with the people who matter.',
          ),
          const SizedBox(height: 18),
          _SectionHeader('My Family', action: 'View all'),
          _Card(
            child: Row(
              children: const [
                _PersonAvatar(
                  name: 'Sara',
                  role: 'Partner',
                  color: Colors.pink,
                ),
                _PersonAvatar(name: 'Zayn', role: 'Son', color: _blue),
                _PersonAvatar(name: 'Aisha', role: 'Daughter', color: _orange),
                _PersonAvatar(name: 'Mom', role: 'Mother', color: Colors.teal),
                _AddPerson(),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _SectionHeader('Upcoming Birthdays', action: 'View all'),
          _Card(
            padding: EdgeInsets.zero,
            child: Column(
              children: const [
                _FamilyEventRow(
                  'Zayn',
                  'Turns 8 in 5 days',
                  'May 20',
                  Icons.card_giftcard_rounded,
                ),
                _DividerInset(),
                _FamilyEventRow(
                  'Mom',
                  'Turns 60 in 12 days',
                  'May 27',
                  Icons.card_giftcard_rounded,
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _SectionHeader('Anniversaries', action: 'View all'),
          _Card(
            padding: EdgeInsets.zero,
            child: Column(
              children: const [
                _FamilyEventRow(
                  'You & Sara',
                  '6th Anniversary',
                  'May 22',
                  Icons.favorite_border_rounded,
                ),
                _DividerInset(),
                _FamilyEventRow(
                  'Mom & Dad',
                  '35th Anniversary',
                  'Jun 10',
                  Icons.join_inner_rounded,
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _SectionHeader('Family Notes', action: 'View all'),
          _Card(
            padding: EdgeInsets.zero,
            child: Column(
              children: const [
                _NoteRow('Pick up Aisha from art class', 'Today, 4:00 PM'),
                _DividerInset(),
                _NoteRow('Plan weekend picnic', 'May 18, 2025'),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _SectionHeader('Quick Connect'),
          Row(
            children: const [
              _ConnectButton(Icons.call_rounded, 'Call Family'),
              _ConnectButton(Icons.chat_bubble_outline_rounded, 'Family Chat'),
              _ConnectButton(Icons.videocam_rounded, 'Video Call'),
              _ConnectButton(Icons.location_on_outlined, 'Share Location'),
            ],
          ),
        ],
      ),
    );
  }
}

class FinanceInsightsScreen extends StatelessWidget {
  const FinanceInsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _ScreenFrame(
      title: 'Finance Insights',
      leading: Icons.arrow_back_rounded,
      trailing: const [Icons.more_vert_rounded],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _GradientBalanceCard(),
          const SizedBox(height: 18),
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionHeader('Spending Overview', action: 'This Month'),
                const SizedBox(height: 14),
                Row(
                  children: const [
                    SizedBox(width: 150, height: 150, child: _DonutChart()),
                    SizedBox(width: 18),
                    Expanded(child: _LegendList()),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _Card(
            child: Row(
              children: const [
                _CircleIcon(Icons.check_rounded, _green),
                SizedBox(width: 14),
                Expanded(
                  child: _StatusMini(
                    title: 'On Track',
                    value: 'Great job! You are on track with your budget.',
                  ),
                ),
                _ProgressRing(value: .72, label: '72%', color: _green),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _SectionHeader('Subscriptions', action: 'View all'),
          _Card(
            padding: EdgeInsets.zero,
            child: Column(
              children: const [
                _MoneyRow('Netflix', '\$15.49 / mo', 'Active', Colors.red),
                _DividerInset(),
                _MoneyRow('Spotify', '\$11.99 / mo', 'Active', Colors.green),
                _DividerInset(),
                _MoneyRow(
                  'Adobe Creative Cloud',
                  '\$52.99 / mo',
                  'Renews May 28',
                  _red,
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _SectionHeader('Recent Transactions', action: 'View all'),
          _Card(
            padding: EdgeInsets.zero,
            child: Column(
              children: const [
                _TransactionRow(
                  Icons.shopping_basket_outlined,
                  'Grocery Store',
                  'May 15, 2025',
                  '- \$45.30',
                  _orange,
                ),
                _DividerInset(),
                _TransactionRow(
                  Icons.directions_car_rounded,
                  'Uber Ride',
                  'May 15, 2025',
                  '- \$12.40',
                  _ink,
                ),
                _DividerInset(),
                _TransactionRow(
                  Icons.account_balance_wallet_outlined,
                  'Salary',
                  'May 14, 2025',
                  '+ \$2,500.00',
                  _green,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CalendarPlannerScreen extends StatelessWidget {
  const CalendarPlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _ScreenFrame(
      title: 'Calendar & Planner',
      leading: Icons.arrow_back_rounded,
      trailing: const [Icons.search_rounded, Icons.more_vert_rounded],
      floatingAction: FloatingActionButton(
        backgroundColor: _purple,
        onPressed: () {},
        child: const Icon(Icons.add_rounded, color: Colors.white),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _WeekStrip(),
          const SizedBox(height: 18),
          const Text.rich(
            TextSpan(
              text: 'Today  ',
              style: TextStyle(fontWeight: FontWeight.w800, color: _ink),
              children: [
                TextSpan(
                  text: 'May 15, 2025',
                  style: TextStyle(color: _purple),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _Card(
            padding: EdgeInsets.zero,
            child: Column(
              children: const [
                _TimelineRow(
                  '9:00 AM',
                  'Team Standup',
                  'Office',
                  _blue,
                  Icons.groups_rounded,
                ),
                _TimelineRow(
                  '11:00 AM',
                  'Dentist Appointment',
                  'Smile Care Clinic',
                  _red,
                  Icons.medical_services_outlined,
                ),
                _TimelineRow(
                  '1:00 PM',
                  'Lunch with Sara',
                  'Cafe Bistro',
                  _purple,
                  Icons.restaurant_rounded,
                ),
                _TimelineRow(
                  '4:00 PM',
                  'Pick up Aisha',
                  'Art Class',
                  _orange,
                  Icons.location_on_rounded,
                ),
                _TimelineRow(
                  '7:00 PM',
                  'Family Movie Night',
                  'At Home',
                  Colors.deepPurple,
                  Icons.family_restroom_rounded,
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _SectionHeader('Reminders', action: 'View all'),
          _Card(
            padding: EdgeInsets.zero,
            child: Column(
              children: const [
                _ReminderRow("Zayn's birthday gift", 'Tomorrow, 10:00 AM'),
                _DividerInset(),
                _ReminderRow('Pay electricity bill', 'May 18, 2025'),
                _DividerInset(),
                _ReminderRow('Submit project report', 'May 19, 2025'),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _SectionHeader('Upcoming Plans'),
          Row(
            children: const [
              Expanded(
                child: _PlanCard(
                  date: 'May 20',
                  title: "Zayn's Birthday Plan",
                  time: '12:00 PM',
                  place: 'Adventure Park',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _PlanCard(
                  date: 'May 22',
                  title: 'Anniversary Dinner',
                  time: '7:00 PM',
                  place: 'Bella Vista Restaurant',
                  hot: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HealthWellnessScreen extends StatelessWidget {
  const HealthWellnessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _ScreenFrame(
      title: 'Health & Wellness',
      leading: Icons.arrow_back_rounded,
      trailing: const [Icons.more_vert_rounded],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader("Today's Overview", action: 'View insights'),
          Row(
            children: const [
              _HealthStat(
                Icons.nightlight_round,
                '7h 32m',
                'Sleep',
                'Good',
                _purple,
              ),
              _HealthStat(
                Icons.water_drop_rounded,
                '6 / 8',
                'Water',
                'Good',
                _blue,
              ),
              _HealthStat(
                Icons.directions_walk_rounded,
                '7,842',
                'Steps',
                'Active',
                _green,
              ),
              _HealthStat(
                Icons.sentiment_satisfied_alt_rounded,
                'Calm',
                'Mood',
                'Good',
                _orange,
              ),
            ],
          ),
          const SizedBox(height: 18),
          _SectionHeader('Log Your Health'),
          _Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _RoundTool(Icons.nightlight_round, 'Sleep', _purple),
                _RoundTool(Icons.water_drop_rounded, 'Water', _blue),
                _RoundTool(Icons.directions_run_rounded, 'Steps', _purple),
                _RoundTool(
                  Icons.sentiment_satisfied_alt_rounded,
                  'Mood',
                  _orange,
                ),
                _RoundTool(Icons.monitor_weight_outlined, 'Weight', _blue),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _SectionHeader('Medications', action: 'View all'),
          _Card(
            padding: EdgeInsets.zero,
            child: Column(
              children: const [
                _MedicationRow(
                  'Vitamin D3',
                  '1 tablet - Daily',
                  'Taken',
                  '8:00 AM',
                ),
                _DividerInset(),
                _MedicationRow(
                  'Omega 3',
                  '1 capsule - Daily',
                  'Taken',
                  '8:00 AM',
                ),
                _DividerInset(),
                _MedicationRow(
                  'Ibuprofen',
                  '1 tablet - As needed',
                  'Due',
                  '6:00 PM',
                  due: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _SectionHeader('Insights', action: 'View all'),
          Row(
            children: const [
              Expanded(
                child: _InsightChart(
                  title: 'Sleep Quality',
                  subtitle: 'Improving',
                  body: 'You slept 1h 10m more than last week',
                  color: _purple,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _InsightChart(
                  title: 'Hydration',
                  subtitle: 'Good Job!',
                  body: 'You hit your water goal 5 of 7 days this week',
                  color: _blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PrivacyVaultScreen extends StatelessWidget {
  const PrivacyVaultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _ScreenFrame(
      title: 'Privacy Vault',
      leading: Icons.menu_rounded,
      trailing: const [Icons.settings_outlined],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Card(
            borderColor: _purple.withValues(alpha: .18),
            child: Row(
              children: const [
                _ShieldBadge(),
                SizedBox(width: 14),
                Expanded(
                  child: _StatusMini(
                    title: 'Your data is secure',
                    value:
                        'We are protecting your information and respecting your privacy.',
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: _muted),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _SectionHeader('Connected Apps', action: 'View all'),
          _Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _ConnectedAppIcon('G', 'Google', Colors.red),
                _ConnectedAppIcon('H', 'Apple Health', Colors.pink),
                _ConnectedAppIcon('F', 'Fitbit', Colors.teal),
                _ConnectedAppIcon('S', 'Spotify', Colors.green),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _SectionHeader('Security Controls'),
          _Card(
            padding: EdgeInsets.zero,
            child: Column(
              children: const [
                _VaultRow(
                  Icons.fingerprint_rounded,
                  'Passcode & Biometrics',
                  'On',
                ),
                _DividerInset(),
                _VaultRow(
                  Icons.verified_user_outlined,
                  'Two-Factor Authentication',
                  'On',
                ),
                _DividerInset(),
                _VaultRow(Icons.lock_clock_rounded, 'Auto-Lock', '5 minutes'),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _SectionHeader('Data Categories', action: 'View all'),
          _Card(
            padding: EdgeInsets.zero,
            child: Column(
              children: const [
                _VaultRow(
                  Icons.person_outline_rounded,
                  'Personal Information',
                  'Protected',
                  color: _purple,
                ),
                _DividerInset(),
                _VaultRow(
                  Icons.favorite_border_rounded,
                  'Health & Wellness',
                  'Protected',
                  color: _red,
                ),
                _DividerInset(),
                _VaultRow(
                  Icons.account_balance_wallet_outlined,
                  'Finance',
                  'Protected',
                  color: _green,
                ),
                _DividerInset(),
                _VaultRow(
                  Icons.location_on_outlined,
                  'Location',
                  'Protected',
                  color: _blue,
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _SectionHeader('Trusted Devices', action: 'View all'),
          _Card(
            padding: EdgeInsets.zero,
            child: Column(
              children: const [
                _DeviceRow(
                  Icons.phone_iphone_rounded,
                  "Ahmed's iPhone",
                  'This device',
                  'Active',
                ),
                _DividerInset(),
                _DeviceRow(
                  Icons.laptop_mac_rounded,
                  'MacBook Pro',
                  'Last active today',
                  'Active',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MoreHubScreen extends StatelessWidget {
  const MoreHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      _HubItem('Family', Icons.family_restroom_rounded, '/family'),
      _HubItem('Finance', Icons.account_balance_wallet_outlined, '/finance'),
      _HubItem('Calendar', Icons.calendar_month_rounded, '/calendar'),
      _HubItem('Wellness', Icons.favorite_border_rounded, '/wellness'),
      _HubItem('Vault', Icons.lock_outline_rounded, '/vault'),
    ];
    return _ScreenFrame(
      title: 'More',
      leading: Icons.menu_rounded,
      trailing: const [Icons.tune_rounded],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _HeroText(
            title: 'All Assistant Spaces',
            subtitle: 'Open the remaining screens from the supplied mockups.',
          ),
          const SizedBox(height: 18),
          GridView.builder(
            itemCount: items.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.35,
            ),
            itemBuilder: (context, index) {
              final item = items[index];
              return InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () => context.go(item.route),
                child: _Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _CircleIcon(item.icon, _purple),
                      Row(
                        children: [
                          Expanded(child: _TinyTitle(item.title)),
                          const Icon(
                            Icons.chevron_right_rounded,
                            color: _muted,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ScreenFrame extends StatelessWidget {
  const _ScreenFrame({
    required this.title,
    required this.child,
    this.leading,
    this.trailing = const [],
    this.floatingAction,
    this.bottomGap = 24,
  });

  final String title;
  final Widget child;
  final IconData? leading;
  final List<IconData> trailing;
  final Widget? floatingAction;
  final double bottomGap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _surface,
      floatingActionButton: floatingAction,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: _TopBar(
                  title: title,
                  leading: leading,
                  trailing: trailing,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, bottomGap),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.title, this.leading, required this.trailing});

  final String title;
  final IconData? leading;
  final List<IconData> trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _TopButton(icon: leading ?? Icons.arrow_back_rounded),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (title == 'My Assistant') ...[
                const _LogoMark(),
                const SizedBox(width: 10),
              ],
              Flexible(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: _ink,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 88,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [for (final icon in trailing) _TopButton(icon: icon)],
          ),
        ),
      ],
    );
  }
}

class _TopButton extends StatelessWidget {
  const _TopButton({required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: IconButton(
        visualDensity: VisualDensity.compact,
        onPressed: () {},
        icon: Icon(icon, color: _ink, size: 22),
      ),
    );
  }
}

class _LogoMark extends StatelessWidget {
  const _LogoMark();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: const BoxDecoration(color: _purple, shape: BoxShape.circle),
      child: const Icon(
        Icons.psychology_alt_rounded,
        color: Colors.white,
        size: 18,
      ),
    );
  }
}

class _HeroText extends StatelessWidget {
  const _HeroText({required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: _ink,
            fontSize: 26,
            fontWeight: FontWeight.w900,
            letterSpacing: 0,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: const TextStyle(color: _muted, fontSize: 15, height: 1.3),
        ),
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _line),
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          const Icon(Icons.search_rounded, color: _muted),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Search or ask anything...',
              style: TextStyle(color: _muted, fontSize: 15),
            ),
          ),
          Container(
            width: 42,
            height: 42,
            margin: const EdgeInsets.only(right: 7),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [_purple, _purpleDark]),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(Icons.mic_none_rounded, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title, {this.action});
  final String title;
  final String? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: _ink,
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          if (action != null)
            Text(
              action!,
              style: const TextStyle(
                color: _purple,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.borderColor,
  });
  final Widget child;
  final EdgeInsets padding;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor ?? _line),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .025),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({required this.actions});
  final List<_ActionData> actions;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < actions.length; i++) ...[
          Expanded(child: _ActionTile(actions[i])),
          if (i != actions.length - 1) const SizedBox(width: 8),
        ],
      ],
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile(this.data);
  final _ActionData data;

  @override
  Widget build(BuildContext context) {
    return _Card(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      child: Column(
        children: [
          Icon(data.icon, color: data.color, size: 25),
          const SizedBox(height: 8),
          Text(
            data.label,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: _ink,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionData {
  const _ActionData(this.icon, this.label, this.color);
  final IconData icon;
  final String label;
  final Color color;
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: _ink,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11, color: _muted, height: 1.2),
          ),
        ],
      ),
    );
  }
}

class _TaskRow extends StatelessWidget {
  const _TaskRow(this.title, this.subtitle, this.badge);
  final String title;
  final String subtitle;
  final String badge;

  @override
  Widget build(BuildContext context) {
    final badgeColor = badge == 'Medium' ? _orange : _green;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          const Icon(
            Icons.check_box_outline_blank_rounded,
            size: 18,
            color: _muted,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: _ink,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: _muted),
                ),
              ],
            ),
          ),
          _Badge(label: badge, color: badgeColor),
        ],
      ),
    );
  }
}

class _SuggestionCard extends StatelessWidget {
  const _SuggestionCard({
    required this.icon,
    required this.title,
    required this.body,
  });
  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CircleIcon(icon, _purple),
          const SizedBox(height: 12),
          _TinyTitle(title),
          const SizedBox(height: 10),
          Text(
            body,
            style: const TextStyle(color: _muted, fontSize: 13, height: 1.45),
          ),
        ],
      ),
    );
  }
}

class _SegmentedPill extends StatelessWidget {
  const _SegmentedPill({required this.labels, required this.selected});
  final List<String> labels;
  final int selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _line),
      ),
      child: Row(
        children: [
          for (var i = 0; i < labels.length; i++)
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selected == i ? _purple : Colors.transparent,
                  borderRadius: BorderRadius.circular(19),
                ),
                child: Text(
                  labels[i],
                  style: TextStyle(
                    color: selected == i ? Colors.white : _muted,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.text, this.active = false});
  final String text;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 260),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: active ? _purple : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: active ? _purple : _line),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: active ? Colors.white : _ink,
          height: 1.35,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(color: _ink)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: _ink, height: 1.35),
            ),
          ),
        ],
      ),
    );
  }
}

class _CheckLine extends StatelessWidget {
  const _CheckLine(this.title, this.when);
  final String title;
  final String when;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_outline_rounded,
            size: 18,
            color: _purple,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 13, color: _ink),
            ),
          ),
          Text(when, style: const TextStyle(fontSize: 12, color: _muted)),
        ],
      ),
    );
  }
}

class _IconChip extends StatelessWidget {
  const _IconChip(this.icon);
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _line),
      ),
      child: Icon(icon, size: 18, color: _muted),
    );
  }
}

class _PromptChip extends StatelessWidget {
  const _PromptChip(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _line),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: _purple,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ChatInput extends StatelessWidget {
  const _ChatInput();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      padding: const EdgeInsets.only(left: 16, right: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _line),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text('Ask anything...', style: TextStyle(color: _muted)),
          ),
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: _purple,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(Icons.mic_none_rounded, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _ProgressRing extends StatelessWidget {
  const _ProgressRing({
    required this.value,
    required this.label,
    this.color = _purple,
  });
  final double value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 78,
      height: 78,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 72,
            height: 72,
            child: CircularProgressIndicator(
              value: value,
              color: color,
              backgroundColor: color.withValues(alpha: .12),
              strokeWidth: 7,
              strokeCap: StrokeCap.round,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: _ink,
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusMini extends StatelessWidget {
  const _StatusMini({required this.title, required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: _ink, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(color: _muted, fontSize: 12, height: 1.35),
        ),
      ],
    );
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({required this.value, required this.label, this.icon});
  final String value;
  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 66,
      child: Column(
        children: [
          Icon(
            icon ?? Icons.flag_rounded,
            color: icon == null ? _ink : _orange,
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              color: _ink,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11, color: _muted, height: 1.15),
          ),
        ],
      ),
    );
  }
}

class _ProgressRow extends StatelessWidget {
  const _ProgressRow(this.title, this.percent, this.value, this.meta);
  final String title;
  final String percent;
  final double value;
  final String meta;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: _TinyTitle(title)),
              Text(
                percent,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: _ink,
                ),
              ),
              const SizedBox(width: 14),
              Text(meta, style: const TextStyle(fontSize: 12, color: _muted)),
            ],
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: value,
            minHeight: 7,
            borderRadius: BorderRadius.circular(10),
            color: _purple,
            backgroundColor: _line,
          ),
        ],
      ),
    );
  }
}

class _HabitRow extends StatelessWidget {
  const _HabitRow(this.icon, this.title, this.subtitle, this.streak);
  final IconData icon;
  final String title;
  final String subtitle;
  final String streak;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          _CircleIcon(icon, _purple),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TinyTitle(title),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: _muted),
                ),
                const SizedBox(height: 10),
                const _DotTrail(active: 6),
              ],
            ),
          ),
          Text(
            '$streak\nday streak',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: _ink,
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _DotTrail extends StatelessWidget {
  const _DotTrail({required this.active});
  final int active;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < 10; i++)
          Container(
            width: 9,
            height: 9,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: i < active ? _purple : _line,
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }
}

class _MilestoneRow extends StatelessWidget {
  const _MilestoneRow(this.icon, this.title, this.date, this.meta, this.value);
  final IconData icon;
  final String title;
  final String date;
  final String meta;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          _CircleIcon(icon, _orange),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TinyTitle(title),
                Text(date, style: const TextStyle(fontSize: 12, color: _muted)),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: value,
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(8),
                  color: _purple,
                  backgroundColor: _line,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            meta,
            style: const TextStyle(
              color: _ink,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _WellnessNudge extends StatelessWidget {
  const _WellnessNudge();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Row(
        children: [
          const _CircleIcon(Icons.spa_rounded, _green),
          const SizedBox(width: 12),
          const Expanded(
            child: _StatusMini(
              title: 'Take a short break',
              value: 'You have been focused for 2h 15m.',
            ),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: _purple),
            onPressed: () {},
            child: const Text('Start Break'),
          ),
        ],
      ),
    );
  }
}

class _MailboxStat extends StatelessWidget {
  const _MailboxStat(this.icon, this.label);
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: _Card(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Column(
          children: [
            Icon(icon, color: _purple),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                color: _ink,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmailRow extends StatelessWidget {
  const _EmailRow(
    this.initial,
    this.sender,
    this.subject,
    this.time,
    this.color,
  );
  final String initial;
  final String sender;
  final String subject;
  final String time;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color,
            foregroundColor: Colors.white,
            child: Text(initial),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TinyTitle(sender),
                Text(
                  subject,
                  style: const TextStyle(
                    color: _ink,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Here are the latest details and notes...',
                  style: TextStyle(color: _muted, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(time, style: const TextStyle(color: _muted, fontSize: 12)),
        ],
      ),
    );
  }
}

class _DocumentRow extends StatelessWidget {
  const _DocumentRow(this.icon, this.title, this.meta, this.color);
  final IconData icon;
  final String title;
  final String meta;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          _SquareIcon(icon, color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TinyTitle(title),
                Text(meta, style: const TextStyle(color: _muted, fontSize: 12)),
              ],
            ),
          ),
          _Badge(label: 'Summarize', color: _purple),
        ],
      ),
    );
  }
}

class _PrimaryActionButton extends StatelessWidget {
  const _PrimaryActionButton(this.icon, this.label);
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      style: FilledButton.styleFrom(
        backgroundColor: _purple,
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      onPressed: () {},
      icon: Icon(icon, size: 17),
      label: Text(label, overflow: TextOverflow.ellipsis),
    );
  }
}

class _SoftActionButton extends StatelessWidget {
  const _SoftActionButton(this.icon, this.label);
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        foregroundColor: _purple,
        side: const BorderSide(color: _line),
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      onPressed: () {},
      icon: Icon(icon, size: 17),
      label: Text(label, overflow: TextOverflow.ellipsis),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  const _ToggleRow(this.icon, this.title, this.subtitle, this.value);
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          _SquareIcon(icon, _purple),
          const SizedBox(width: 12),
          Expanded(
            child: _StatusMini(title: title, value: subtitle),
          ),
          Switch(
            value: value,
            onChanged: (_) {},
            activeThumbColor: Colors.white,
            activeTrackColor: _purple,
          ),
        ],
      ),
    );
  }
}

class _ApprovalRow extends StatelessWidget {
  const _ApprovalRow(this.title, this.subtitle);
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          const _SquareIcon(Icons.assignment_turned_in_outlined, _purple),
          const SizedBox(width: 12),
          Expanded(
            child: _StatusMini(title: title, value: subtitle),
          ),
          _Badge(label: 'Approve', color: _green),
          const SizedBox(width: 8),
          _Badge(label: 'Decline', color: _red),
        ],
      ),
    );
  }
}

class _RoutineCard extends StatelessWidget {
  const _RoutineCard(this.title, this.subtitle, this.active);
  final String title;
  final String subtitle;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TinyTitle(title),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 12, color: _muted, height: 1.35),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Switch(
              value: active,
              onChanged: (_) {},
              activeTrackColor: _purple,
              activeThumbColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _ConnectedApps extends StatelessWidget {
  const _ConnectedApps();

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          _SquareIcon(Icons.drive_file_move_outlined, _blue),
          _SquareIcon(Icons.table_chart_outlined, _green),
          _SquareIcon(Icons.hub_outlined, Colors.pink),
          _SquareIcon(Icons.article_outlined, _ink),
          _SquareIcon(Icons.view_kanban_outlined, _blue),
          _Badge(label: '+12', color: _purple),
        ],
      ),
    );
  }
}

class _PersonAvatar extends StatelessWidget {
  const _PersonAvatar({
    required this.name,
    required this.role,
    required this.color,
  });
  final String name;
  final String role;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: color.withValues(alpha: .18),
            child: Text(
              name.characters.first,
              style: TextStyle(color: color, fontWeight: FontWeight.w900),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: _ink,
            ),
          ),
          Text(
            role,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 10, color: _muted),
          ),
        ],
      ),
    );
  }
}

class _AddPerson extends StatelessWidget {
  const _AddPerson();

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Color(0xFFF0EAFF),
            child: Icon(Icons.add_rounded, color: _purple),
          ),
          SizedBox(height: 8),
          Text(
            'Add',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: _ink,
            ),
          ),
          Text('', style: TextStyle(fontSize: 10)),
        ],
      ),
    );
  }
}

class _FamilyEventRow extends StatelessWidget {
  const _FamilyEventRow(this.title, this.subtitle, this.date, this.icon);
  final String title;
  final String subtitle;
  final String date;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          _CircleIcon(icon, _red),
          const SizedBox(width: 12),
          Expanded(
            child: _StatusMini(title: title, value: subtitle),
          ),
          Text(date, style: const TextStyle(color: _muted, fontSize: 12)),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right_rounded, color: _muted),
        ],
      ),
    );
  }
}

class _NoteRow extends StatelessWidget {
  const _NoteRow(this.title, this.date);
  final String title;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          const Icon(Icons.flag_rounded, color: _orange, size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: _StatusMini(title: title, value: date),
          ),
          const Icon(Icons.circle, color: _red, size: 8),
        ],
      ),
    );
  }
}

class _ConnectButton extends StatelessWidget {
  const _ConnectButton(this.icon, this.label);
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _line),
        ),
        child: Column(
          children: [
            Icon(icon, color: _purple, size: 20),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                color: _ink,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GradientBalanceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [_purple, Color(0xFF7B4FF5)]),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Balance',
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '\$5,234.50',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Up 5.4% from last month',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .16),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'All Accounts',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DonutChart extends StatelessWidget {
  const _DonutChart();

  @override
  Widget build(BuildContext context) => CustomPaint(painter: _DonutPainter());
}

class _DonutPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final colors = [
      _purple,
      _red,
      _orange,
      Colors.teal,
      Colors.blueAccent,
      Colors.blueGrey,
    ];
    final values = [.23, .2, .16, .14, .13, .14];
    final rect = Offset.zero & size;
    var start = -math.pi / 2;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 34
      ..strokeCap = StrokeCap.butt;
    for (var i = 0; i < values.length; i++) {
      paint.color = colors[i];
      final sweep = values[i] * math.pi * 2;
      canvas.drawArc(rect.deflate(24), start, sweep, false, paint);
      start += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _LegendList extends StatelessWidget {
  const _LegendList();

  @override
  Widget build(BuildContext context) {
    final rows = [
      ('Housing', '\$1,450.00', _purple),
      ('Food & Dining', '\$860.20', _orange),
      ('Transport', '\$420.30', _red),
      ('Shopping', '\$680.40', Colors.teal),
      ('Bills & Utilities', '\$610.00', _blue),
      ('Entertainment', '\$310.40', Colors.blueAccent),
      ('Others', '\$443.20', Colors.blueGrey),
    ];
    return Column(
      children: [
        for (final row in rows)
          Padding(
            padding: const EdgeInsets.only(bottom: 7),
            child: Row(
              children: [
                Icon(Icons.circle, size: 8, color: row.$3),
                const SizedBox(width: 7),
                Expanded(
                  child: Text(
                    row.$1,
                    style: const TextStyle(fontSize: 12, color: _ink),
                  ),
                ),
                Text(
                  row.$2,
                  style: const TextStyle(
                    fontSize: 12,
                    color: _ink,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _MoneyRow extends StatelessWidget {
  const _MoneyRow(this.title, this.price, this.status, this.color);
  final String title;
  final String price;
  final String status;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          _SquareIcon(Icons.apps_rounded, color),
          const SizedBox(width: 12),
          Expanded(child: _TinyTitle(title)),
          Text(
            price,
            style: const TextStyle(color: _ink, fontWeight: FontWeight.w700),
          ),
          const SizedBox(width: 12),
          Text(
            status,
            style: TextStyle(
              color: status == 'Active' ? _green : _muted,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _TransactionRow extends StatelessWidget {
  const _TransactionRow(
    this.icon,
    this.title,
    this.date,
    this.amount,
    this.color,
  );
  final IconData icon;
  final String title;
  final String date;
  final String amount;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          _CircleIcon(icon, color),
          const SizedBox(width: 12),
          Expanded(
            child: _StatusMini(title: title, value: date),
          ),
          Text(
            amount,
            style: TextStyle(
              color: amount.startsWith('+') ? _green : _ink,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _WeekStrip extends StatelessWidget {
  const _WeekStrip();

  @override
  Widget build(BuildContext context) {
    final days = [
      ('Sun', '11'),
      ('Mon', '12'),
      ('Tue', '13'),
      ('Wed', '14'),
      ('Thu', '15'),
      ('Fri', '16'),
      ('Sat', '17'),
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (final day in days)
          Container(
            width: 43,
            padding: const EdgeInsets.symmetric(vertical: 9),
            decoration: BoxDecoration(
              color: day.$2 == '15' ? _purple : Colors.transparent,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              children: [
                Text(
                  day.$1,
                  style: TextStyle(
                    color: day.$2 == '15' ? Colors.white : _ink,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  day.$2,
                  style: TextStyle(
                    color: day.$2 == '15' ? Colors.white : _ink,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow(this.time, this.title, this.place, this.color, this.icon);
  final String time;
  final String title;
  final String place;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
      child: IntrinsicHeight(
        child: Row(
          children: [
            SizedBox(
              width: 70,
              child: Padding(
                padding: const EdgeInsets.only(top: 18),
                child: Text(
                  time,
                  style: const TextStyle(color: _ink, fontSize: 12),
                ),
              ),
            ),
            Container(width: 3, color: color),
            const SizedBox(width: 14),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: _StatusMini(title: title, value: place),
              ),
            ),
            _CircleIcon(icon, color),
          ],
        ),
      ),
    );
  }
}

class _ReminderRow extends StatelessWidget {
  const _ReminderRow(this.title, this.date);
  final String title;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          const Icon(Icons.check_box_outline_blank_rounded, color: _muted),
          const SizedBox(width: 12),
          Expanded(
            child: _StatusMini(title: title, value: date),
          ),
          const Icon(Icons.chevron_right_rounded, color: _muted),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.date,
    required this.title,
    required this.time,
    required this.place,
    this.hot = false,
  });
  final String date;
  final String title;
  final String time;
  final String place;
  final bool hot;

  @override
  Widget build(BuildContext context) {
    final color = hot ? _red : _purple;
    return _Card(
      borderColor: color.withValues(alpha: .4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            date,
            style: TextStyle(color: color, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 10),
          _TinyTitle(title),
          const SizedBox(height: 10),
          Text(
            '$time\n$place',
            style: const TextStyle(color: _muted, fontSize: 12, height: 1.45),
          ),
          const SizedBox(height: 16),
          const Row(
            children: [_MiniAvatar('A'), _MiniAvatar('S'), _MiniAvatar('Z')],
          ),
        ],
      ),
    );
  }
}

class _HealthStat extends StatelessWidget {
  const _HealthStat(this.icon, this.value, this.label, this.meta, this.color);
  final IconData icon;
  final String value;
  final String label;
  final String meta;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: _Card(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
        child: Column(
          children: [
            Icon(icon, color: color, size: 27),
            const SizedBox(height: 10),
            Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: _ink,
                fontWeight: FontWeight.w900,
                fontSize: 15,
              ),
            ),
            Text(label, style: const TextStyle(color: _muted, fontSize: 11)),
            const SizedBox(height: 6),
            Text(
              meta,
              style: const TextStyle(
                color: _green,
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoundTool extends StatelessWidget {
  const _RoundTool(this.icon, this.label, this.color);
  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CircleIcon(icon, color),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: _muted, fontSize: 12)),
      ],
    );
  }
}

class _MedicationRow extends StatelessWidget {
  const _MedicationRow(
    this.name,
    this.meta,
    this.status,
    this.time, {
    this.due = false,
  });
  final String name;
  final String meta;
  final String status;
  final String time;
  final bool due;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          _CircleIcon(
            due ? Icons.emergency_outlined : Icons.medication_outlined,
            due ? _red : _blue,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _StatusMini(title: name, value: meta),
          ),
          _Badge(label: status, color: due ? _red : _green),
          const SizedBox(width: 12),
          Text(
            time,
            style: const TextStyle(
              color: _ink,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _InsightChart extends StatelessWidget {
  const _InsightChart({
    required this.title,
    required this.subtitle,
    required this.body,
    required this.color,
  });
  final String title;
  final String subtitle;
  final String body;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: color, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(color: _green, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          Text(
            body,
            style: const TextStyle(color: _ink, fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (var i = 0; i < 7; i++)
                Expanded(
                  child: Container(
                    height: 22 + (i % 4) * 12,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: .45),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ShieldBadge extends StatelessWidget {
  const _ShieldBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [_purple, _purpleDark]),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.lock_rounded, color: Colors.white, size: 30),
    );
  }
}

class _ConnectedAppIcon extends StatelessWidget {
  const _ConnectedAppIcon(this.initial, this.label, this.color);
  final String initial;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 74,
      child: Column(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: color.withValues(alpha: .14),
            child: Text(
              initial,
              style: TextStyle(color: color, fontWeight: FontWeight.w900),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: _ink,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
          const Text(
            'Connected',
            style: TextStyle(color: _muted, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class _VaultRow extends StatelessWidget {
  const _VaultRow(this.icon, this.title, this.status, {this.color = _muted});
  final IconData icon;
  final String title;
  final String status;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(child: _TinyTitle(title)),
          Text(status, style: const TextStyle(color: _muted, fontSize: 12)),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right_rounded, color: _muted),
        ],
      ),
    );
  }
}

class _DeviceRow extends StatelessWidget {
  const _DeviceRow(this.icon, this.title, this.subtitle, this.status);
  final IconData icon;
  final String title;
  final String subtitle;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          _SquareIcon(icon, _blue),
          const SizedBox(width: 12),
          Expanded(
            child: _StatusMini(title: title, value: subtitle),
          ),
          Text(
            status,
            style: const TextStyle(
              color: _green,
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right_rounded, color: _muted),
        ],
      ),
    );
  }
}

class _CircleIcon extends StatelessWidget {
  const _CircleIcon(this.icon, this.color);
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: color.withValues(alpha: .12),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }
}

class _SquareIcon extends StatelessWidget {
  const _SquareIcon(this.icon, this.color);
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: color.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _TinyTitle extends StatelessWidget {
  const _TinyTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: _ink,
        fontSize: 13,
        fontWeight: FontWeight.w900,
        height: 1.25,
      ),
    );
  }
}

class _MiniAvatar extends StatelessWidget {
  const _MiniAvatar(this.initial);
  final String initial;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      height: 26,
      margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        color: _purple.withValues(alpha: .15),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: const TextStyle(
          color: _purple,
          fontWeight: FontWeight.w900,
          fontSize: 11,
        ),
      ),
    );
  }
}

class _DividerInset extends StatelessWidget {
  const _DividerInset();

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, indent: 14, endIndent: 14, color: _line);
  }
}

class _HubItem {
  const _HubItem(this.title, this.icon, this.route);
  final String title;
  final IconData icon;
  final String route;
}
