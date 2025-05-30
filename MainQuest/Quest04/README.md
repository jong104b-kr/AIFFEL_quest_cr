# AIFFEL Campus Online Code Peer Review Templete
- 코더 : 류지호
- 리뷰어 : 안진용

🤔 피어리뷰 템플릿

- [x]  **1. 주어진 문제를 해결하는 완성된 코드가 제출되었나요? (완성도)**
    - 문제에서 요구하는 최종 결과물이 첨부되었는지 확인
    - 문제를 해결하는 완성된 코드란 프로젝트 루브릭 3개 중 2개, 
    퀘스트 문제 요구조건 등을 지칭
        - 해당 조건을 만족하는 부분의 코드 및 결과물을 캡쳐하여 사진으로 첨부
     
          ![image](https://github.com/user-attachments/assets/609f9135-9d56-4091-a29a-c1beb6d0d725)


- [x]  **2. 프로젝트에서 핵심적인 부분에 대한 설명이 주석(닥스트링) 및 마크다운 형태로 잘 기록되어있나요? (설명)**
    - [x]  모델 선정 이유
    - [x]  하이퍼 파라미터 선정 이유
    - [x]  데이터 전처리 이유 또는 방법 설명

            ![image](https://github.com/user-attachments/assets/783988b1-4522-42c0-b647-205e7c9e54e1)

            
- [x]  **3. 체크리스트에 해당하는 항목들을 수행하였나요? (문제 해결)**
    - [x]  데이터를 분할하여 프로젝트를 진행했나요? (train, validation, test 데이터로 구분)
    - [x]  하이퍼파라미터를 변경해가며 여러 시도를 했나요? (learning rate, dropout rate, unit, batch size, epoch 등)
    - [x]  각 실험을 시각화하여 비교하였나요?
    - [x]  모든 실험 결과가 기록되었나요?

        ![image](https://github.com/user-attachments/assets/80a1882b-9d77-4ec6-b15c-bd808f4669f3)
        ![image](https://github.com/user-attachments/assets/8a350a2d-609c-47aa-97fa-910cb666b9a2)

        

- [x]  **4. 프로젝트에 대한 회고가 상세히 기록 되어 있나요? (회고, 정리)**
    - [x]  배운 점
    - [x]  아쉬운 점
    - [x]  느낀 점
    - [x]  어려웠던 점

        ![image](https://github.com/user-attachments/assets/f1363c37-aeda-47ff-8d5d-466634685406)


- [ ]  **5.  앱으로 구현하였나요?**
    - [ ]  구현된 앱이 잘 동작한다.
    - [ ]  모델이 잘 동작한다.

# 회고(참고 링크 및 코드 개선)
```
# 리뷰어의 회고를 작성합니다.
민유경 - 학습에 맞는 모델선정과 그에 따른 코드작성이 체계적으로 잘 이뤄진 것 같다.
윤경석 - 저도 유경님과 같은 의견입니다
안진용 - WGAN-GP를 몰랐는데 이런 방법도 있는것을 지호님을 통해서 알게 되었다.
# 코더 리뷰
기본 GAN은 생성자와 판별자 손실이 크게 흔들리며 수렴하지 않고, 이로 인해 생성된 이미지 품질도 불안정하게 나타났다.
여기에 더해서, 손실 값 결과와 이미지 품질이 직관적으로 연결되어 있지 않는다는 사실도 인상깊게 학습했다.
WGAN-GP는 Wasserstein 거리를 손실로 사용하고 gradient penalty로 1-Lipschitz 제약을 부드럽게 적용해 학습이 안정화되고 손실 변화도 예측 가능했던 것이
만족스러운 학습 결과였다.
