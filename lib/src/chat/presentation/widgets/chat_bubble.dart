import 'package:ecommerce_shop_app/core/utils/core_utils.dart';
import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/res/styles/text.dart';
import 'package:ecommerce_shop_app/core/widgets/product/product_card.dart';
import 'package:ecommerce_shop_app/src/chat/domain/entities/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_shop_app/core/extensions/context_extension.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({required this.message, super.key});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final isUser = message.type == ChatMessageType.user;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(12),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            decoration: BoxDecoration(
              color: isUser
                  ? context.theme.primaryColor
                  : CoreUtils.adaptiveColor(
                      context,
                      lightModeColor: MyColors.lightThemeStockColor,
                      darkModeColor: MyColors.darkThemeDarkSharpColor,
                    ),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: Radius.circular(isUser ? 16 : 0),
                bottomRight: Radius.circular(isUser ? 0 : 16),
              ),
            ),
            child: Text(
              message.message,
              style: TextStyles.paragraphSubTextRegular3.copyWith(
                color: isUser ? Colors.white : context.theme.textTheme.bodyMedium?.color,
              ),
            ),
          ),
          if (message.responseType == ChatResponseType.products && message.products != null)
            SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: message.products!.length,
                itemBuilder: (context, index) {
                  final product = message.products![index];
                  return Container(
                    width: 160,
                    margin: const EdgeInsets.only(right: 12),
                    child: ProductCard(product),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
