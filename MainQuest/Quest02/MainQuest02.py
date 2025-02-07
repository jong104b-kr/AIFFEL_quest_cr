# 1. 기본 모델이 동작하는 코드 제출 : 1점
# 기본 모델은 Feature Engineering을 수행하기 전 Decision Tree 모델을 의미함

from sklearn.tree import DecisionTreeClassifier # 의사 결정 트리 모델 : sklearn 패키지의 DecisionTreeClassifier 모듈로 호출
model = DecisionTreeClassifier(random_state=25) # 모델 정의, random_state는 모델의 랜덤성을 제어

# 2. 데이터 전처리 : 1점
# 전처리 수행에 대한 설명이 각 과정에 포함되어야 함

pokemon["name_count"] = pokemon["Name"].apply(lambda i: len(i)) # (1) 이름의 길이가 10 이상인가 아닌가
pokemon["long_name"] = pokemon["name_count"] >= 10 # 이름의 길이가 10 이상이면 True, 미만이면 False 인 long_name 컬럼 생성
pokemon["Name_nospace"] = pokemon["Name"].apply(lambda i: i.replace(" ", "")) # 알파벳 체크를 위해 띄어쓰기가 없는 컬럼을 따로 만든 후, 띄어쓰기를 빈칸으로 처리해서 확인
pokemon["name_isalpha"] = pokemon["Name_nospace"].apply(lambda i: i.isalpha()) # isalpha() 함수를 이용해 이름이 알파벳으로만 이루어졌는지 확인
print(pokemon[pokemon["name_isalpha"] == False].shape) # 알파벳에 해당하지 않는 다른 문자가 이름에 포함된 경우
for t in types: # Type별로 원-핫 인코딩
    pokemon[t] = (pokemon["Type 1"] == t) | (pokemon["Type 2"] == t)

# 3. 베이스라인 모델 학습 성공 및 분석 : 1점
# 베이스라인 모델은 feature engineering을 수행한 이후의 Decision Tree모델을 의미함

model = DecisionTreeClassifier(random_state=25)
model.fit(X_train, y_train) # train 데이터로 decision tree 모델을 학습시키고, test 데이터로 모델의 예측 값을 얻기
y_pred = model.predict(X_test)
from sklearn.metrics import confusion_matrix # confusion matrix 확인
confusion_matrix(y_test, y_pred)
from sklearn.metrics import classification_report # classification report 확인
print(classification_report(y_test, y_pred))

# 4. 비교 모델 학습 성공 및 비교 분석 : 1점
# 비교모델은 Decision Tree 이외의 분류 모델을 의미함

from sklearn.ensemble import RandomForestClassifier # 의사 결정 트리 모델 : sklearn 패키지의 RandomForestClassifier 모듈로 호출
model = RandomForestClassifier(n_estimators=500, max_leaf_nodes=16, random_state=25) # 모델 정의, random_state는 모델의 랜덤성을 제어
model.fit(X_train, y_train) # train 데이터로 decision tree 모델을 학습
y_pred = model.predict(X_test) # test 데이터로 모델의 예측 값을 얻기

# 5. 보고서 양식 : 1점 ★
# 보고서란 체계적인 노드 수행 결과를 텍스트로 정리한 내용이 포함된 Notebook파일을 의미함
# 노드수행 결과:개요, 목차, 주석 및 의견, summary, 회고, reference 등
# 개요 - 퀘스트 슬라이드를 차례로 위에서부터 아래로 해당하는 코드 작성 및 주석 첨부
# 목차 - 1. 기본 모델이 동작하는 코드 제출, 2. 데이터 전처리, 3. 베이스라인 모델 학습 성공 및 분석, 4. 비교 모델 학습 성공 및 비교 분석, 5.보고서 양식
# 주석 및 의견 - 해당코드 우측에 작성함
# summary - 이론 이외 실습과정을 배운다는 생각으로 메인퀘스트를 수행함, 시간과 연습량이 모자라다고 판단함.
# 회고 - lms 노드에서 X, y 변수를 파이선 문법으로 설정하는 과정이 자료형과 겹쳐 헷갈렸습니다. 그 부분을 다시 학습하고 넘어와야 이후 과정들을 수행하는데 문제가 없으리라 생각합니다.
# reference 등
# 1. https://joowon582.tistory.com/160
