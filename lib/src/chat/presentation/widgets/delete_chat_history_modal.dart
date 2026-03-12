import 'package:ecommerce_shop_app/src/chat/presentation/app/adapter/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteChatHistoryModal extends StatelessWidget {
  const DeleteChatHistoryModal({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Chat History?'),
      content: const Text(
        'This will permanently delete your conversation with the AI. This action cannot be undone.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            context.read<ChatCubit>().deleteChatHistory();
          },
          style: TextButton.styleFrom(foregroundColor: Colors.red),
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
