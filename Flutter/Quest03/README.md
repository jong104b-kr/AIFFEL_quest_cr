* 레포지토리에 대한 간략한 소개

모두연 아이펠 12기 코어 플러터 모듈 레포지토리

# AIFFEL Campus Online Code Peer Review Templete
- 코더 : 윤경석,변종현
- 리뷰어 : 류지호, 공옥례

🔑 **PRT(Peer Review Template)**

- [x]  **1. 주어진 문제를 해결하는 완성된 코드가 제출되었나요?**
    - 문제에서 요구하는 기능이 정상적으로 작동하는지?

        - 직접 화면으로 잘 구현하여 주셨습니다.
        - Next와 Back 버튼을 통해서 FirstScreen과 SecondScreen 이동이 원활하게 됩니다.
        - console화면에 이미지를 클릭했을 때 true와 false가 잘 출력됩니다.
        
- [x]  **2. 핵심적이거나 복잡하고 이해하기 어려운 부분에 작성된 설명을 보고 해당 코드가 잘 이해되었나요?**
    - 해당 코드 블럭에 doc string/annotation/markdown이 달려 있는지 확인
    - 해당 코드가 무슨 기능을 하는지, 왜 그렇게 짜여진건지, 작동 메커니즘이 뭔지 기술.
    - 주석을 보고 코드 이해가 잘 되었는지 확인

![image](https://github.com/user-attachments/assets/a8121189-e5e4-4a2e-8c51-e60f32593afc)
![image](https://github.com/user-attachments/assets/282323bf-978c-44f6-b291-89742ff520b9)
![image](https://github.com/user-attachments/assets/8a7a50ab-7684-4b3d-872f-87b5c1b6b665)
![image](https://github.com/user-attachments/assets/d7d0e045-3bc2-4d63-8850-df63df0e9e74)
![image](https://github.com/user-attachments/assets/74baf74e-caab-4d7d-8a95-4215ce423bcb)
![image](https://github.com/user-attachments/assets/b944feb7-9233-4b9d-a495-fa0ea10eb1f3)
- is_cat bool 자료형에 대한 설명과 아이콘 바꾸는 작업에 대한 설명이 잘 적혀있습니다.
- dart 파일을 3개로 나눠서 작업을 진행하신 것도 잘 명시해주셨습니다.
        
- [x]  **3.** 에러가 난 부분을 디버깅하여 “문제를 해결한 기록”을 남겼나요? 또는
   “새로운 시도 및 추가 실험”을 해봤나요? ****
    - 문제 원인 및 해결 과정을 잘 기록하였는지 확인 또는
    - 문제에서 요구하는 조건에 더해 추가적으로 수행한 나만의 시도,
    실험이 기록되어 있는지 확인
![image](https://github.com/user-attachments/assets/6588f2d9-f49b-4b53-9ce0-642e9e3e52fe)
![image](https://github.com/user-attachments/assets/7669cc10-a153-4520-9b89-b7d19f3709a9)
어느 부분에서 문제가 생겼는지, 어떻게 해결했는지 주석으로 남겨주셨습니다.
        
- [ ]  **4. 회고를 잘 작성했나요?**
    - 프로젝트 결과물에 대해 배운점과 아쉬운점, 느낀점 등이 상세히 기록 되어 있나요?

- [x]  **5. 코드가 간결하고 효율적인가요?**
    - 코드 중**복을 최소화하고 범용적으로 사용할 수 있도록 모듈화(함수화) 했는지**
![image](https://github.com/user-attachments/assets/307b7609-4356-412a-88a2-82cc504711d6)
![image](https://github.com/user-attachments/assets/2cefa2c0-0690-44f6-9cbe-41353f8f915d)
dart 파일을 3개로 나눠서 각각 간결하게 적어주신 점이 가독성이 좋았습니다.


# 회고(참고 링크 및 코드 개선)
두 page 간의 작업을 깔끔하게 잘 처리하셨고, Navigator.pushNamed와 Navigator.pop을 이용해 페이지를 전환하는 방식이 명확합니다.
GestureDetector를 통해 이미지 클릭 시 is_cat 값을 변경하고 출력하는 방식이 가독성이 좋게 느껴졌습니다.
미션내용과 반대로 첫번째 page에서 강아지, 두번째 page에서 고양이가 등장한 사소한 점이 아쉬웠습니다.
이미지 처리에서 네트워크 이미지를 사용하여 동적으로 UI를 업데이트하는 방식이 새로웠습니다.
상태 변경과 출력을 통해 is_cat 값을 추적하며, 코드 내에서 상태 변화에 대해 잘 읽을 수 있었습니다.
페이지를 나누어 작업을 한 것이 좋았고 적절한 고양이와 강아지 이미지를 다운로드 받아 사용한 것도 좋았습니다.
```
