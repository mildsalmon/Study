# 파이썬에서 Switch/Case문이 없는 이유

switch문을 어떤 방식으로 구현하는 것이 효율적인지 결정하는 것이 까다롭다.

인기가 없어서 구현되지 않았다.

## A. 대안

if~elif문이나 dict를 통해 switch/case문을 대체할 수 있다.

---

-   일반적인 경우: `if...elif`
-   많은 경우 중에서 하나를 택해야 하는 경우: 딕셔너리와 함수를 매핑
    
    예시:
    
    ```
    def function_1(...):
        ...
    
    functions = {'a': function_1,
                 'b': function_2,
                 'c': self.method_1, ...}
    
    func = functions[value]
    func()
    ```
