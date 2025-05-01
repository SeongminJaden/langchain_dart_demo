# LangChain.dart

LangChain.dart는 Harrison Chase가 만든 인기 있는 LangChain Python 프레임워크의 비공식 Dart 포트입니다.

LangChain은 언어 모델을 다루는 데 필요한 준비된 구성 요소들을 제공하며, 이를 연결하여 더 고급 사용 사례(예: 챗봇, RAG를 이용한 Q&A, 에이전트, 요약, 번역, 추출, 추천 시스템 등)를 만들 수 있는 표준 인터페이스를 제공합니다.

이 문서는 [LangChain.dart](https://github.com/davidmigloz/langchain_dart) 레포지토리를 번역하였습니다.

구성 요소는 몇 가지 핵심 모듈로 그룹화할 수 있습니다:

## LangChain.dart

### 📃 모델 I/O
LangChain은 다양한 LLM 제공자(예: OpenAI, Google, Mistral, Ollama 등)와 상호작용하기 위한 통합 API를 제공하며, 이를 통해 개발자는 쉽게 제공자를 전환할 수 있습니다. 또한 모델 입력 관리(프롬프트 템플릿 및 예시 선택기) 및 모델 출력 분석 도구도 제공합니다.

### 📚 검색
사용자 데이터를 로드하는 도구(문서 로더), 데이터를 변환하는 도구(텍스트 분할기), 의미를 추출하는 도구(임베딩 모델), 저장 도구(벡터 저장소), 검색 도구(검색기)를 제공하여, 이를 통해 모델의 응답을 강화할 수 있습니다(즉, Retrieval-Augmented Generation(RAG)).

### 🤖 에이전트
LLM을 활용하여 어떤 작업을 수행할지 결정하기 위해 사용할 도구들(예: 웹 검색, 계산기, 데이터베이스 조회 등)을 선택하는 "봇"입니다.

이 구성 요소들은 LangChain 표현 언어(LCEL)를 사용하여 서로 연결할 수 있습니다.

## 동기

대형 언어 모델(LLM)은 질문 응답, 요약, 번역, 텍스트 생성 등 다양한 응용 프로그램에서 중요한 구성 요소로 자리잡고 있습니다. LLM의 채택은 새로운 기술 스택을 형성하고 있으며, 대부분의 도구는 Python과 JavaScript 생태계에서 주로 개발되고 있습니다. 그로 인해 LLM을 활용하는 응용 프로그램이 급격히 증가하고 있습니다.

그러나 Dart와 Flutter 생태계는 LLM을 다루는 라이브러리가 부족하여 비슷한 성장을 하지 못했습니다. LangChain.dart는 Dart와 Flutter에서 LLM을 다루는 복잡성을 추상화하여, 개발자가 LLM의 잠재력을 효과적으로 활용할 수 있도록 도와주는 라이브러리입니다.

## 패키지

LangChain.dart는 모듈화된 디자인으로, 개발자가 필요한 구성 요소만 선택적으로 임포트할 수 있습니다. 이 생태계는 여러 패키지로 구성되어 있습니다:

### `langchain_core`
- LangChain의 핵심 추상화 및 LangChain 표현 언어를 포함합니다. LangChain.dart 위에 프레임워크를 구축하거나 LangChain.dart와 상호작용하는 데 의존합니다.

### `langchain`
- 애플리케이션의 인지 구조에 필요한 상위 레벨의 체인, 에이전트 및 검색 알고리즘을 포함한 패키지입니다. 이 패키지를 통해 LangChain.dart로 LLM 응용 프로그램을 구축합니다.

### `langchain_community`
- LangChain.dart API에 포함되지 않은 타사 통합 및 커뮤니티 기여 구성 요소를 포함합니다. 통합 또는 구성 요소를 사용하려면 이 패키지를 의존합니다.

### 통합 전용 패키지
인기 있는 타사 통합(예: `langchain_openai`, `langchain_google`, `langchain_ollama` 등)은 별도의 패키지로 분리되어 있어, 전체 `langchain_community` 패키지를 의존하지 않고 독립적으로 임포트할 수 있습니다.

#### API 클라이언트 패키지
LangChain.dart에서 내부적으로 사용되거나 독립적으로 사용될 수 있는 API 클라이언트 패키지입니다.

## 시작하기

LangChain.dart를 사용하려면 `pubspec.yaml` 파일에 `langchain`을 의존성으로 추가하고, 필요한 특정 통합 패키지(예: `langchain_community`, `langchain_openai`, `langchain_google` 등)를 추가하십시오.

### 예시 1: LLM 호출

가장 기본적인 LangChain.dart의 사용법은 프롬프트를 전달하여 LLM을 호출하는 것입니다. 예를 들어, Google의 Gemini 모델을 호출하려면 다음과 같이 할 수 있습니다:

```dart
final model = ChatGoogleGenerativeAI(apiKey: googleApiKey);
final prompt = PromptValue.string('Hello world!');
final result = await model.invoke(prompt);
// 결과: "Hello everyone! I'm new here and excited to be part of this community."
```
### 예시 2: RAG 파이프라인 구축
복잡한 사용 사례는 여러 구성 요소를 연결하여 만들 수 있습니다. 예를 들어, RAG(검색-강화 생성) 파이프라인을 구축하려면:

벡터 저장소 생성 및 문서 추가:

```dart
final vectorStore = MemoryVectorStore(
  embeddings: OpenAIEmbeddings(apiKey: openaiApiKey),
);
await vectorStore.addDocuments(
  documents: [
    Document(pageContent: 'LangChain은 Harrison에 의해 만들어졌습니다.'),
    Document(pageContent: 'David는 LangChain을 Dart로 포팅했습니다.'),
  ],
);
```
### 검색 체인 정의:

```dart
final retriever = vectorStore.asRetriever();
final setupAndRetrieval = Runnable.fromMap<String>({
  'context': retriever.pipe(
    Runnable.mapInput((docs) => docs.map((d) => d.pageContent).join('\n')),
  ),
  'question': Runnable.passthrough(),
});
```
### RAG 프롬프트 템플릿 정의:

```dart
final promptTemplate = ChatPromptTemplate.fromTemplates([
  (ChatMessageType.system, '다음의 내용만을 기반으로 질문에 답해주세요:\n{context}'),
  (ChatMessageType.human, '{question}'),
]);
```
### 최종 체인 정의:

```dart
final model = ChatOpenAI(apiKey: openaiApiKey);
const outputParser = StringOutputParser<ChatResult>();
final chain = setupAndRetrieval
    .pipe(promptTemplate)
    .pipe(model)
    .pipe(outputParser);
```
### 파이프라인 실행:

```dart
final res = await chain.invoke('LangChain.dart는 누가 만들었나요?');
print(res);
// 출력: 'David가 LangChain.dart를 만들었습니다.'
```
### 문서화
LangChain.dart 문서 및 샘플 앱은 공식 웹사이트에서 확인할 수 있습니다. 또한, 커뮤니티 및 도움을 주고받을 수 있는 공식 Discord 서버도 운영 중입니다.

### 기여
LangChain.dart는 MIT 라이선스 하에 제공되며, 새로운 기여자를 환영합니다. 기여를 원하시면 Contributors Guide를 참고하세요.

### 관련 프로젝트
- LangChain: 원래 Python 기반 LangChain 프로젝트

- LangChain.js: LangChain의 JavaScript 포트

- LangChain.go: LangChain의 Go 포트

- LangChain.rb: LangChain의 Ruby 포트