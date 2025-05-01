import 'dart:io';

import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';

void main(final List<String> arguments) async {
  // 직접 API 키를 문자열로 입력
  final openAiApiKey = ''; // 여기서 API 키를 직접 넣어주세요

  if (openAiApiKey.isEmpty) {
    stderr.writeln('You need to set your OpenAI key.');
    exit(1);
  }

  final llm = ChatOpenAI(
    apiKey: openAiApiKey,
    defaultOptions: const ChatOpenAIOptions(temperature: 0.9),
  );

  stdout.writeln('How can I help you?');

  while (true) {
    stdout.write('> ');
    final query = stdin.readLineSync() ?? '';
    final humanMessage = ChatMessage.humanText(query);
    final aiMessage = await llm.call([humanMessage]);
    stdout.writeln(aiMessage.content.trim());
  }
}
