# 난수를 발생하기 위해 random 모듈 호출
import random

# Q1 Character 클래스
class Character:
    def __init__(self,name,level,health,attack,defend):

        # 이름, 레벨, 체력, 공격력, 방어력 속성
        self.name = name
        self.level = level
        self.health = health
        self.attack = attack
        self.defend = defend

    # 현재 체력이 0 이상인지 bool값 반환하는 메서드
    def is_alive(self):
        if health >= 0:
            return True
        else
            return False

    # 공격을 받았을 때 체력감소 메서드 만들기
    def take_damage(self):
        if(damage > defend):
            health -= (damage - defend)

    # 타겟에게 데미지를 입히는 메서드
    def attack_target(self):
        damage = random.randint(1,attack)

# Q2 Character 클래스를 상속받는 Player 클래스
class Player(Character): # Character 상속받기
    def __init__(self,name,level,health,attack,defend,experience):

        # 이름, 레벨, 체력, 공격력, 방어력, 경험치 속성
        self.name = name
        self.level = 1 # 레벨 초기화
        self.health = health
        self.attack = 25 # 공격력 초기화
        self.defend = 5 # 방어력 초기화
        self.experience = experience # 경험치 속성 추가

    # gain_experience 메서드
    def gain_experience(exp):
        experience += exp

    # level_up 메서드
    def level_up(experience)
        if experience >= 50:
            level++
            attack += 10
            defend += 5

# Q2 Character 클래스를 상속받는 Monster 클래스
class Monster(Character): # Character 상속받기
    def __init__(self,name,level,health,attack,defend):

        # 체력, 공격력, 방어력 초기화
        self.name = name
        self.level = level
        self.health = random.randint(10,30)*level
        self.attack = random.randint(5,20)*level
        self.defend = random.randint(1,5)*level

# Q3 battle 함수 만들기
def battle(player,monster):
    result = player - monster
    if(result > 0):
        player.experience += monster.level*20
        player.level_up()
        print('전투승리!')
    else:
        print('전투패배..')

# Q4 main 함수 만들기
def main():
    monster_dict = {'슬라임':1,'고블린':2,'오크':3}
    Player p1 = input('플레이어 이름 입력:')
    Monster m1 = monster_dict[0]
    Monster m2 = monster_dict[1]
    Monster m3 = monster_dict[2]


    while(p1 >= 0):
        battle(p1,m1)
            if(p1 == 0):
                print('게임오버')
                break
        battle(p1,m2)
            if(p1 == 0):
                print('게임오버')
                break
        battle(p1,m3)
            if(p1 == 0):
                print('게임오버')
                break
