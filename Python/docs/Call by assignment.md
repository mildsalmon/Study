# Call by assignment (call by object-reference)

파이썬은 call by value, call by reference가 아닌 call by assignment이다.

mutable 객체를 바꾸는 것이 아닌, 객체 내의 원소(element, 요소)를 변경하는 것이다.

immutable 한 포멧의 객체 (tuple, int 등)는 변경할 수 없지만, mutable 한 포멧의 객체 (list, dict, set 등)는 변경할 수 있다는 특성을 갖는다.