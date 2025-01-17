# 난수를 발생하기 위해 random 모듈 호출
import random

# Account 클래스 설계(정의)
class Account:

    # 계좌객체의 개수 저장 변수 선언 및 초기화 - 클래스 변수 이용
    accountCounter = 0
    
    def __init__(self,owner,returnValue): # owner:예금주, returnValue:잔액, bank:은행이름, accountNumber : 계좌번호

        # 입금횟수 세는 변수 선언 및 초기화
        self.depositCounter = 0

        # 입금내역, 출금내역 저장할 리스트 선언
        self.depositLog = []
        self.withdrawLog = []

        self.owner = owner
        self.returnValue = returnValue
        self.bank = 'SC은행'

        firstDigits = random.randint(0,999)
        secondDigits = random.randint(0,99)
        thirdDigits = random.randint(0,999999)

        # 빈 자릿수 0으로 채우기
        firstDigits = str(firstDigits).zfill(3)
        secondDigits = str(secondDigits).zfill(2)
        thirdDigits = str(thirdDigits).zfill(6)
        self.accountNumber = firstDigits + '-' + secondDigits + '-' + thirdDigits

        # Account클래스를 통해 계좌객체를 생성하면 개수세기
        Account.accountCounter += 1

    @classmethod
    def get_account_num(cls):
        print(cls.accountCounter)

    # 입금메서드
    def deposit(self,income):
        if income >= 1:
            self.returnValue += income

            self.depositCounter += 1
            if self.depositCounter % 5 == 0:

                # 이자를 1% 지급합니다.
                self.returnValue = (self.returnValue * 1.01)

    # 출금메서드
    def withdraw(self,outcome):
        if self.returnValue > outcome:
            self.returnValue -= outcome

    # 정보 출력 메서드
    def display_info(self):
        print('은행이름: ', self.bank)
        print('예금주: ', self.owner)
        print('계좌번호: ', self.accountNumber)
        print('잔고: ', f'{self.returnValue:,}')

    # 출금내역 메서드
    def withdraw_history(self):
        for returnValue in self.withdrawLog:
            print(returnValue)

    # 입금내역 메서드
    def deposit_history(self):
        for returnValue in self.withdrawLog:
            print(returnValue)

# account클래스의 객체 생성
account101 = Account('홍길동',10000)

# Q1 답안
print(account101.owner)
print(account101.returnValue)
print(account101.bank)
print(account101.accountNumber)

# Q2 답안
account102 = Account('고길동',15000)
print(Account.accountCounter)
account103 = Account('이길동',20000)
print(Account.accountCounter)

# Q3 답안
account103.get_account_num()

# Q4,Q5 답안
account103.deposit(10000)
account103.withdraw(5000)
print(account103.returnValue)

# Q6 답안
account104 = Account('파이선', 10000)
account104.display_info()

# Q7 답안
account105 = Account('파이선', 10000)

account105.deposit(10000)
account105.deposit(10000)
account105.deposit(10000)
account105.deposit(10000)
account105.deposit(10000) # 5회 입금
print(account105.returnValue)

# Q8 답안
accountList = []
account106 = Account('홍길동', 200000000)
account107 = Account('고길동', 20000)
account108 = Account('이길동', 30000)

accountList.append(account106)
accountList.append(account107)
accountList.append(account108)

print(accountList)

# Q9 답안
for counter in accountList:
    if counter.returnValue >= 1000000:
        counter.display_info()

# Q10 답안
account109 = Account('정길동',10000)
account109.deposit(5000)
account109.deposit(3000)
account109.deposit(2000)
account109.deposit_history()

account109.withdraw(5000)
account109.withdraw(2000)
account109.withdraw_history()
