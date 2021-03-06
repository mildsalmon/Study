# 1. 컴퓨터 시스템 구조

![](/bin/OS_image/os_2_1.png)

![](/bin/OS_image/os_2_2.png)

- I/O device
	- device controller가 I/O device의 CPU 역할.
	- local buffer가 I/O device의 Memory 역할.
- Computer
	- registers
		- Memory보다 빠르고 정보를 저장할 수 있는 작은 공간
	- mode bit
		- CPU에서 실행되고 있는 것이 운영체제인지, 사용자 프로그램인지를 구분해줌
	- Interrupt line
		- I/O 장비에서 무엇을 읽어오거나, 작업을 다 끝냇다는 것을 전달하기 위해서 존재함.
	- CPU
		- CPU는 Memory에 있는 인스트럭션만 실행한다.
			- 인스트럭션 하나가 실행되면, 인스트럭션의 주소값이 증가하여 다음번에 실행할 인스트럭션이 정해진다.
		- Memory에서 I/O 접근이 필요하면, I/O 장비에 있는 device controller에 명령을 보내고, 대기없이 Memory에서 다음 인스트럭션을 실행한다.
		- 인스트럭션 실행하고, interrupt line 확인하고, 인터럽트가 없으면 인스트럭션 실행한다.
	- timer
		- 특정 프로그램이 CPU를 독점(무한루프)하는 것을 막기 위해서 존재함.
		- 인스트럭션이 실행될 때, timer에 셋팅해둔 시간이 지나면 CPU에 interrupt를 걸어서 시간이 종료되었다고 알린다.
		- timer가 인터럽트를 걸어왔으면, CPU는 하던일을 잠시 멈추고, CPU의 제어권이 사용자 프로그램 -> OS(운영체제)로 넘어가게 되어 있다.
			- OS에서 사용자 프로그램으로 제어권이 넘어갈 수는 있지만, 뺏을 수는 없다.
				- 본인의 interrupt line이 없기 때문.
		- CPU의 time sharing을 구현하기 위해 존재.
	- 사용자 프로그램
		- 사용자 프로그램이 실행되는 중에 I/O 작업이 필요하면, OS(운영 체제)에 CPU 제어권을 넘겨준다.
			- 운영체제는 I/O 작업을 실행하고, time sharing을 위해 다른 사용자 프로그램을 실행한다.
	- DMA controller
		- I/O 장치가 CPU에 자주 인터럽트를 거니까, CPU가 너무 많이 방해를 받기에 그것을 막기 위해서 존재함.
		- I/O 장치의 작업이 끝났으면, DMA controller가 I/O 장치의 local buffer에 정보를 직접 Memory에 복사해주는 역할을 함.
			- 이 작업이 끝나면, CPU에 인터럽트를 한번만 걸어서 작업이 완료되었다고 알림.

## A. Mode bit

사용자 프로그램의 잘모소딘 수행으로 다른 프로그램 및 운영체제에 피해가 가지 않도록 하기 위한 보호 장치 필요

- Mode bit을 통해 하드웨어적으로 두 가지 모드의 operation 지원
	```ad-note

	- 1 (사용자 모드)
		- 사용자 프로그램 수행
	- 0 (모니터 모드 = 커널 모드, 시스템 모드)
		- OS 코드 수행

	```
	- 보안을 해칠 수 있는 중요한 명령어는 모니터 모드에서만 수행 가능한 **특권명령**으로 규정
	- Interrupt나 Exception 발생시 하드웨어가 mode bit을 0으로 바꿈
	- 사용자 프로그램에게 CPU를 넘기기 전에 mode bit을 1로 셋팅

![](/bin/OS_image/os_2_3.png)

## B. Timer

- 타이머
	- 정해진 시간이 흐른 뒤 운영체제에게 제어권이 넘어가도록 인터럽트를 발생시킴
	- 타이머는 매 클럭 틱 때마다 1씩 감소
	- 타이머 값이 0이 되면 타이머 인터럽트 발생
	- CPU를 특정 프로그램이 독점하는 것으로부터 보호
- 타이머는 time sharing을 구현하기 위해 널리 이용됨
- 타이머는 현재 시간을 계산하기 위해서도 사용

## C. Device Controller

- I/O device controller
	- 해당 I/O 장치유형을 관리하는 일종의 작은 CPU
	- 제어 정보를 위해 control register, status register를 가짐
	- local buffer를 가짐 (일종의 data register)
- I/O는 실제 device와 local buffer 사이에서 일어남
- Device controller는 I/O가 끝났을 경우 interrupt로 CPU에 그 사실을 알림

### a. device driver (장치구동기)

- software
- OS 코드 중 각 장치별 처리루틴

### b. device controller (장치제어기)

- hardware
- 각 장치를 통제하는 일종의 작은 CPU

## D. 입출력(I/O)의 수행

- 모든 입출력 명령은 특권 명령
- 사용자 프로그램은 어떻게 I/O를 하는가?
	- 시스템콜 (system call)
		- 사용자 프로그램은 운영체제에게 I/O 요청(부탁하는 것)
		- 사용자 프로그램이 운영체제의 커널(함수)를 호출하는 것
	- trap을 사용하여 인터럽트 벡트의 특정 위치로 이동
	- 제어권이 인터럽트 벡터가 가리키는 인터럽트 서비스 루틴으로 이동
	- 올바른 I/O 요청인지 확인 후 I/O 수행
	- I/O 완료 시 제어권을 시스템콜 다음 명령으로 옮김

## E. 인터럽트 (Interrupt)

- 인터럽트
	- 인터럽트 당한 시점의 레지스터와 program counter를 save한 후 CPU의 제어를 인터럽트 처리 루틴에 넘긴다.
- Interrupt (넓은 의미)
	- Interrupt (하드웨어 인터럽트)
		- 하드웨어가 발생시킨 인터럽트
		- Timer, I/O Controller가 거는 인터럽트
	- Trap (소프트웨어 인터럽트)
		- Exception
			- 프로그램이 오류를 범한 경우
		- System call
			- 프로그램이 커널 함수를 호출하는 경우
- 인터럽트 관련 용어
	- 인터럽트 벡터
		- 해당 인터럽트의 처리 루틴 주소를 가지고 있음
		- 각 인터럽트 종류마다, 그 인터럽트가 생겼을 때 어디에 있는 함수를 실행해야하는지, 그 함수의 주소들을 정의해놓은 일종의 테이블
	- 인터럽트 처리 루틴 (Interrupt Service Routine, 인터럽트 핸들러)
		- 해당 인터럽트를 처리하는 커널 함수 
		- 인터럽트 종류마다 해야하는 일이 운영체제의 코드에 정의되어 있다.
			- 각 인터럽트마다 실제 실행해야 하는 코드를 인터럽트 처리 루틴이라 부른다.
			- 실제로 인터럽트 처리하는 부분.

```ad-note

I/O 요청을 할 때는 Trap(소프트웨어 인터럽트)가 발생하고, I/O가 다 끝났으면 interrupt(하드웨어 인터럽트)를 통해 인터럽트가 끝났음을 알려줌.

```

![](/bin/OS_image/os_2_4.png)

- 현대의 운영체제는 인터럽트에 의해 구동된다.
	- 운영체제는 CPU를 사용할일이 없다. 인터럽트가 들어올 때만 CPU가 운영체제한테 넘어간다. 그렇지 않으면 CPU는 사용자 프로그램이 쓰게 된다.

## F. 시스템콜 (System Call)

사용자 프로그램이 운영체제의 서비스를 받기 위해 커널 함수를 호출하는 것.

![](/bin/OS_image/os_2_5.png)

## G. 동기식 입출력과 비동기식 입출력

> 두 경우 모두 I/O의 완료는 인터럽트로 알려줌

### a. 동기식 입출력 (synchronous I/O)

> I/O장치에 쓰라는 작업이 주어지면, 쓰고 확인하고나서 다음 일을 해야함.

- I/O 요청 후 입출력 작업이 완료된 후에야 제어가 사용자 프로그램에 넘어감.
- 구현 방법 1
	- I/O가 끝날 때까지 CPU를 낭비시킴
	- 매시점 하나의 I/O만 일어날 수 있음

	> 특정 시점에서 I/O 장치나 CPU의 낭비가 발생함.

- 구현 방법 2 (인터럽트가 발생하여 다른 프로그램에 CPU를 할당함)
	- I/O가 완료될 때까지 해당 프로그램에게서 CPU를 빼앗음
	- I/O 처리를 기다리는 줄에 그 프로그램을 줄 세움
	- 다른 프로그램에게 CPU를 줌

	> I/O 장치와 CPU가 놀지 않고 일을 함.

### b. 비동기식 입출력 (asynchronous I/O)

> I/O 장치에 쓰라고 하고 다음일을 함.

- I/O가 시작된 후 입출력 작업이 끝나기를 기다리지 않고 제어가 사용자 프로그램에 즉시 넘어감

![](/bin/OS_image/os_2_6.png)
## H. DMA (Direct Memory Access)

- 빠른 입출력 장치를 메모리에 가까운 속도로 처리하기 위해 사용
- CPU의 중재 없이 device controller가 device의 buffer storage의 내용을 메모리에 block 단위로 직접 전송
- 바이트 단위가 아니라 block 단위로 인터럽트를 발생시킴

![](/bin/OS_image/os_2_7.png)
- 메모리에 접근할 수 있는 장치
- I/O 장치에서 모든 작업에 대한 인터럽트를 CPU에 걸면, CPU가 효율적으로 동작하지 못함.
	- 그래서, DMA 장치를 두고, DMA가 I/O 장치의 local buffer의 내용을 Memory에 copy를 하고, block에 대한 인터럽트가 끝났으면, CPU에 인터럽트를 한 번 걸어서 작업이 메모리에 올라갔다는 것을 알려줌.
		- 그럼, CPU가 인터럽트를 당하는 빈도가 줄어들어서, 더 효율적으로 동작할 수 있음

## I. 서로 다른 입출력 명령어

- I/O를 수행하는 special instruction에 의해
	- 메모리만 접근하는 인스트럭션 (로드스토어)
	- I/O 장치만 접근하는 인스트럭션 
		- I/O 디바이스도 주소가 있어서, 특정 주소에 대해서 I/O 접근하는 인스트럭션을 실행하면 그 디바이스를 접근하는게 된다.
- Memory Mapped I/O에 의해
	- I/O 디바이스에 메모리 주소를 매겨서 메모리에 접근하는 인스트럭션을 통해서 I/O에 접근할 수 있음. 

![](/bin/OS_image/os_2_8.png)
## J. 저장장치 계층 구조

![](/bin/OS_image/os_2_9.png)
- Primary
	- Registers
	- Cache Memory
		- Main Memory와 Registers의 속도 차이를 보완하기 위해 존재.
	- Main Memory
- Secondary
	- Magnetic Disk
	- Optical Disk
	- Magnetic Tape

> 보통 위로갈수록, Speed가 빠르다, Cost가 비싸다, 용량이 적다, Volatility(휘발성)하다.

- Caching
	- 재사용을 목적으로 함.
	- disk에 한번 요청을 해서 읽었으면, 같은거를 두 번째 요청할 때는 disk까지 가지 않고 이미 위(Cache)에 읽은 데이터가 있으면, 위에서 바로 읽어간다.

## K. 프로그램의 실행 (메모리 load)

 ![](/bin/OS_image/os_2_10.png)
 
 보통 프로그램은 실행 파일 형태로 Hard Disk에 File형식으로 저장되어 있다. 이런 실행 파일을 실행시키게 되면, 메모리로 올라가서 프로세스가 된다. 

![](/bin/OS_image/os_2_11.png)

Physical Memory에 바로 올라가는 것이 아니라, 먼저 Virtual Memory에 올라간다.

### a. Virtual Memory

프로그램을 실행시키면, 그 프로그램만의 독자적인 Address Space(주소 공간)가 형성된다. 

- 주소 공간
	- code
		- CPU에서 실행할 기계어 코드를 담고 있음
	- data
		- 변수, 전역 변수 등의 프로그램이 실행하는 자료구조를 담고 있음
	- stack
		- 코드가 함수 구조로 되어 있기 때문에, 함수를 호출하거나 리턴할 때 데이터를 쌓았다가 꺼내가는 용도로 사용.

모든 프로그램은 독자적인 주소 공간이 있는데, 이것을 물리적인 메모리에 올려서 실행시킨다. 

커널은 항상 메모리에 상주하지만, 사용자 프로그램들은 실행을 시키면, 주소 공간이 생겼다가 프로그램을 종료시키면 사라진다. 

프로그램을 실행시켰을 때 만들어지는 주소 공간을 물리적인 메모리에 통째로 다 올려놓는 것이 아니다 (메모리 낭비 때문). 당장 필요한 부분 (A라는 함수를 실행한다면, 그 부분에 해당하는 코드) 은 Physical Memory에 올려두고 그렇지 않은 부분은 올리지 않는다. 나중에 해당 코드가 사용이 안되면, 메모리에서 쫒아낸다(당장 필요하지 않은 부분은 DISK(Swap area)에 내려둔다.).

Virtual Memory는 각 프로그램마다 독자적으로 가지고 있는 메모리 공간.

#### 1) File System

전원이 꺼지더라도 파일은 내용이 유지되어야 함.

비휘발성 용도로 사용

#### 2) Swap area

전원이 꺼지면 의미 없는 데이터,

전원이 꺼지면 프로세스는 종료되기 때문.

Physical Memory 용량의 한계로 Memory 연장 공간으로써 사용하는 것

#### 3) Address translation

Virtual Memory를 Physical Memory로 변환하는 것 

### b. 커널 주소 공간의 내용

![](/bin/OS_image/os_2_12.png)

#### 1) Code

- 자원을 효율적으로 관리하기 위한 코드
- 편리한 인터페이스를 제공하기 위한 코드
- 시스템콜(소프트웨어 인터럽트), 인터럽트(하드웨어 인터럽트) 처리를 위한 코드

#### 2) data

운영체제가 사용하는 자료구조들이 정의가 되어 있음

운영체제는 하드웨어(CPU, Memory, Disk)를 직접 관리하고 통제한다. 하드웨어를 관리하기 위해서 하드웨어 종류마다 자료구조를 하나씩 만들어서 관리한다. 각 프로그램마다 운영체제가 관리하고 있는 자료구조(PCB)를 만들어서 관리한다.

#### 3) stack

운영체제도 함수 구조로  짜여있기 때문에, 함수를 호출하거나 리턴할 때 stack 영역을 사용해야한다.

커널 스택이라고 한다.

사용자 프로그램(프로세스)마다 커널 스택을 따로 두고 있다.

## L. 사용자 프로그램이 사용하는 함수

### a. 함수 (function)

![](/bin/OS_image/os_2_13.png)

#### 1) 사용자 정의 함수

- 자신의 프로그램에서 정의한 함수

#### 2) 라이브러리 함수

- 자신의 프로그램에서 정의하지 않고 갖다 쓴 함수
- 자신의 프로그램의 실행 파일에 포함되어 있다.

#### 3) 커널 함수

- 운영체제 프로그램의 함수
- 커널 함수의 호출 = 시스템 콜
- 내 프로그램 안에는 커널 함수의 정의가 없고 호출만 하게 된다. 그러면 커널 함수로 넘어가서 호출해야 한다.
	- 시스템 콜을 통해 인터럽트 라인을 셋팅해서 CPU 제어권이 커널 함수 쪽으로 넘어가게 하여 실행한다.

## M. 프로그램의 실행

![](/bin/OS_image/os_2_14.png)

1. user mode
	- 프로그램이 직접 CPU를 잡고 있는 상태
	- 자신이 정의한 사용자 정의 함수를 호출해도 user mode에서 실행
	- system call을 하면 kernel 주소 공간이 실행된다.
2. kernel mode
	- system call이 끝나면 A라는 프로그램에 CPU 제어권이 넘어가고, A의 주소공간이 실행된다.

# 참고자료

[1] 반효경, [System Structure & Program Execution 1](javascript:void(0);). kocw. [운영체제 - 이화여자대학교 | KOCW 공개 강의](http://www.kocw.net/home/cview.do?cid=3646706b4347ef09). (accessed Nov 23, 2021)
