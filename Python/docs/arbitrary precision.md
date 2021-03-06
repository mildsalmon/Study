# arbitrary precision

사용할 수 있는 메모리양이 정해져 있는 기존의 fixed-precision과 달리, 현재 남아있는 만큼의 가용 메모리를 모든 수 표현에 끌어다 쓸 수 있는 형태를 이야기한다.

특정 값을 나타내는데 4Byte가 부족하다면 5Byte, 6Byte까지 사용할 수 있게 유동적으로 운용한다.

![](/bin/Python_image/arbirary_precision.png)

파이썬에서는 0은 24Byte, $2^0$ ~ $2^{30}-1$은 28Byte, $2^{30}$ ~ $2^{60}-1$은 32Byte로 4Byte씩 늘어난다.

# 참고문헌

[1] AHRA CHO. [[기초 파이썬] 파이썬 3에는 오버플로우가 없다? | Tech Blog for Everyone (ahracho.github.io)](https://ahracho.github.io/posts/python/2017-05-09-python-integer-overflow/). Github. (accessed Mar 30. 2022)

[2] [Can Integer Operations Overflow in Python? — Random Points (mortada.net)](https://mortada.net/can-integer-operations-overflow-in-python.html). Blog. (accessed Mar 30. 2022)