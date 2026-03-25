import 'package:ecommerce_shop_app/core/extensions/context_extension.dart';
import 'package:ecommerce_shop_app/core/extensions/text_style_extension.dart';
import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/res/styles/text.dart';
import 'package:ecommerce_shop_app/core/utils/core_utils.dart';
import 'package:ecommerce_shop_app/core/widgets/input_field.dart';
import 'package:ecommerce_shop_app/core/widgets/cart_badge.dart';
import 'package:ecommerce_shop_app/src/cart/presentation/views/cart_screen.dart';
import 'package:ecommerce_shop_app/src/chat/presentation/app/adapter/chat_cubit.dart';
import 'package:ecommerce_shop_app/src/chat/presentation/widgets/chat_bubble.dart';
import 'package:ecommerce_shop_app/src/chat/presentation/widgets/delete_chat_history_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static const path = "/chat";

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<ChatCubit>(),
        child: const DeleteChatHistoryModal(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<ChatCubit>().getMessages();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'AI Assistant',
          style: TextStyles.headingMedium3.adaptiveColor(context),
        ),
        actions: [
          CartBadge(
            child: IconButton(
              onPressed: () => context.push(CartScreen.path),
              icon: const Icon(Icons.shopping_cart_outlined),
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'delete') {
                _showDeleteConfirmation(context);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete_outline, color: Colors.red),
                    SizedBox(width: 8),
                    Text(
                      'Delete Chat History',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatMessagesUpdated) {
                  _scrollToBottom();
                }
                if (state is ChatHistoryDeleted) {
                  CoreUtils.showSnackBar(
                    context,
                    message: 'Chat history deleted successfully.',
                  );
                }
                if (state is ChatError) {
                  CoreUtils.showSnackBar(context, message: state.message);
                }
              },
              builder: (context, state) {
                final messages = context.read<ChatCubit>().messages;
                if (messages.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 64,
                          color: MyColors.lightThemeSecondaryColor.withOpacity(
                            0.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Ask me anything about our products!',
                          style: TextStyles.paragraphSubTextRegular1.grey,
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: messages.length + (state is ChatLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == messages.length) {
                      return _buildLoadingBubble();
                    }
                    final message = messages[index];
                    return ChatBubble(message: message);
                  },
                );
              },
            ),
          ),
          _buildInputSection(),
        ],
      ),
    );
  }

  Widget _buildLoadingBubble() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: CoreUtils.adaptiveColor(
            context,
            lightModeColor: MyColors.lightThemeStockColor,
            darkModeColor: MyColors.darkThemeDarkSharpColor,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }

  Widget _buildInputSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: InputField(
                controller: _messageController,
                hintText: 'Type your message...',
                defaultValidation: false,
              ),
            ),
            const SizedBox(width: 12),
            IconButton(
              onPressed: () {
                final message = _messageController.text.trim();
                if (message.isNotEmpty) {
                  context.read<ChatCubit>().sendMessage(message);
                  _messageController.clear();
                }
              },
              icon: const Icon(Icons.send),
              style: IconButton.styleFrom(
                backgroundColor: context.theme.primaryColor,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
