# GIL에 대해 설명하시오.

Global Interpreter Lock

GIL은 한번에 하나의 스레드만 수행할 수 있도록 인터프리터에 lock을 거는 기능.

파이썬 객체는 garbage collection 기능을 위해, reference count를 가지고 있는데, 해당 객체를 참조할때마다 reference count 값을 변경해야 한다. 멀티스레드를 실행하게되면 reference count를 관리하기 위해서 모든 객체에 대한 lock이 필요할 것이다. 이런 비효율을 막기위해서 gil을 사용한다.

하나의 lock을 통해서 모든 객체들에 대한 reference count의 동기화 문제를 해결한 것이다.
