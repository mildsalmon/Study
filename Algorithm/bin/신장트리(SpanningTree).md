# 1. 신장 트리

> 하나의 그래프가 있을 때 모든 노드를 포함하면서 사이클이 존재하지 않는 부분 그래프

그래프 알고리즘 문제로 자주 출제되는 문제 유형. 모든 노드가 포함되어 서로 연결되면서 사이클이 존재하지 않는다는 조건은 트리의 성립 조건이기도 하다.

![신장트리](/bin/PS_image/신장트리(SpanningTree)_그래프.png)

![신장트리](/bin/PS_image/신장트리(SpanningTree)_신장트리.png)

![신장트리](/bin/PS_image/신장트리(SpanningTree)_신장트리x.png)

### A. 크루스칼 알고리즘 (Kruskal Algorithm)

다양한 문제 상황에서 가능한 한 최소한의 비용으로 신장 트리를 찾아야 할 때가 있다. 예를 들어 N개의 도시가 존재하는 상황에서 두 도시 사이에 도로를 놓아 전체 도시가 서로 연결될 수 있게 도로를 설치하는 경우. 모든 도시를 **연결**할 때, 최소한의 비용으로 연결하려면 어떤 알고리즘을 이용해야 할까?

3개의 도시가 있고 각 도시 간 도로를 건설하는 비용은 23, 13, 25이다.

![크루스칼_예시](/bin/PS_image/크루스칼_예시.png)

여기서 노드 1, 2, 3을 모두 연결하기 위해서 가장 최소한의 비용을 가지는 신장 트리는 36이다.

![크루스칼_예시](/bin/PS_image/크루스칼_예시_2.png)

1. 23 + 13 = 36
2. 23 + 25 = 48
3. 25 + 13 = 38

신장 트리 중에서 최소 비용으로 만들 수 있는 신장 트리를 찾는 알고리즘을**최소 신장 트리 알고리즘** 이라 한다. 대표적인 최소 신장 트리 알고리즘은 크루스칼 알고리즘이다.

크루스칼 알고리즘을 사용하면 가장 적은 비용으로 모든 노드를 연결할 수 있다. 크루스칼 알고리즘은 그리디 알고리즘으로 분류된다. 모든 간선에 대하여 정렬을 수행한 뒤에 가장 거리가 짧은 간선부터 집합에 포함시키면 된다. 만약 사이클을 발생시킬 수 있는 간선의 경우, 집합에 포함시키지 않는다.

1. 간선 데이터를 비용에 따라 오름차순으로 정렬한다.
2. 간선을 하나씩 확인하며 현재의 간선이 사이클을 발생시키는지 확인한다.
	1. 사이클이 발생하지 않는 경우 최소 신장트리에 포함시킨다.
	2. 사이클이 발생하는 경우 최소 신장 트리에 포함시키지 않는다.
3. 모든 간선에 대하여 2번의 과정을 반복한다.

최소 신장 트리는 일종의 트리(Tree) 자료구조이다. 최종적으로 신장 트리에 포함되는 간선의 개수가 **노드의 개수 - 1**과 같다는 특징이 있다.

핵심 원리는 가장 거리가 짧은 간선부터 차례대로 집합에 추가하면 된다는 것이다. 다만 사이클을 발생시키는 간선은 제외하고 연결한다.

##### a. 예시

- step 0

	그래프의 모든 간선 정보만 따로 빼내어 정렬을 수행한다.

	![신장 트리 (Spanning Tree)_예_1.png](/bin/PS_image/신장트리(SpanningTree)_예_1.png)

	| 간선 | (1, 2) | (1 ,5) | (2, 3) | (2, 6) | (3, 4) | (4, 6) | (4, 7) | (5, 6) | (6, 7) |
	| ---- | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ |
	| 비용 | 29     | 75     | 35     | 34     | 7      | 23     | 13     | 53     | 25     |

	| 노드 | 1   | 2   | 3   | 4   | 5   | 6   | 7   |
	| ---- | --- | --- | --- | --- | --- | --- | --- |
	| 부모 | 1   | 2   | 3   | 4   | 5   | 6   | 7   |

- step 1

	첫 번째 단계에서는 가장 짧은 간선을 선택한다. (3, 4)를 선택하고 집합에 포함하면 된다. 노드 3과 노드 4에 대하여 union 함수를 수행한다.

	![신장 트리 (Spanning Tree)_예_1.png](/bin/PS_image/신장트리(SpanningTree)_예_2.png)

	| 간선 | (1, 2) | (1 ,5) | (2, 3) | (2, 6) | (3, 4)     | (4, 6) | (4, 7) | (5, 6) | (6, 7) |
	| ---- | ------ | ------ | ------ | ------ | ---------- | ------ | ------ | ------ | ------ |
	| 비용 | 29     | 75     | 35     | 34     | 7          | 23     | 13     | 53     | 25     |
	| 순서 |        |        |        |        | **step 1** |        |        |        |        |

	| 노드 | 1   | 2   | 3   | 4   | 5   | 6   | 7   |
	| ---- | --- | --- | --- | --- | --- | --- | --- |
	| 부모 | 1   | 2   | 3   | 3   | 5   | 6   | 7   |

- step 2

	그 다음 비용이 가장 작은 간선인 (4, 7)을 선택한다.

	![신장 트리 (Spanning Tree)_예_1.png](/bin/PS_image/신장트리(SpanningTree)_예_3.png)

	| 간선 | (1, 2) | (1 ,5) | (2, 3) | (2, 6) | (3, 4)     | (4, 6) | (4, 7)     | (5, 6) | (6, 7) |
	| ---- | ------ | ------ | ------ | ------ | ---------- | ------ | ---------- | ------ | ------ |
	| 비용 | 29     | 75     | 35     | 34     | 7          | 23     | 13         | 53     | 25     |
	| 순서 |        |        |        |        | **step 1** |        | **step 2** |        |        |

	| 노드 | 1   | 2   | 3   | 4   | 5   | 6   | 7   |
	| ---- | --- | --- | --- | --- | --- | --- | --- |
	| 부모 | 1   | 2   | 3   | 3   | 5   | 6   | 3   | 

- step 3

	그 다음 비용이 가장 작은 간선인 (4, 6)을 선택한다.

	![신장 트리 (Spanning Tree)_예_1.png](/bin/PS_image/신장트리(SpanningTree)_예_4.png)

	| 간선 | (1, 2) | (1 ,5) | (2, 3) | (2, 6) | (3, 4)     | (4, 6)     | (4, 7)     | (5, 6) | (6, 7) |
	| ---- | ------ | ------ | ------ | ------ | ---------- | ---------- | ---------- | ------ | ------ |
	| 비용 | 29     | 75     | 35     | 34     | 7          | 23         | 13         | 53     | 25     |
	| 순서 |        |        |        |        | **step 1** | **step 3** | **step 2** |        |        |

	| 노드 | 1   | 2   | 3   | 4   | 5   | 6   | 7   |
	| ---- | --- | --- | --- | --- | --- | --- | --- |
	| 부모 | 1   | 2   | 3   | 3   | 5   | 3   | 3   |

- step 4

	그 다음 비용이 가장 작은 간선인 (6, 7)을 선택한다. 다만, 노드 6과 노드 7의 루트가 이미 동일한 집합에 포함되어 있으므로 신장 트리에 포함하지 않아야 한다.

	![신장 트리 (Spanning Tree)_예_1.png](/bin/PS_image/신장트리(SpanningTree)_예_5.png)

	| 간선 | (1, 2) | (1 ,5) | (2, 3) | (2, 6) | (3, 4)     | (4, 6)     | (4, 7)     | (5, 6) | (6, 7) |
	| ---- | ------ | ------ | ------ | ------ | ---------- | ---------- | ---------- | ------ | ------ |
	| 비용 | 29     | 75     | 35     | 34     | 7          | 23         | 13         | 53     | 25     |
	| 순서 |        |        |        |        | **step 1** | **step 3** | **step 2** |        | step 4 |

	| 노드 | 1   | 2   | 3   | 4   | 5   | 6   | 7   |
	| ---- | --- | --- | --- | --- | --- | --- | --- |
	| 부모 | 1   | 2   | 3   | 3   | 5   | 3   | 3   |

- step 5

	그 다음 비용이 가장 작은 간선인 (1, 2)을 선택한다.

	![신장 트리 (Spanning Tree)_예_1.png](/bin/PS_image/신장트리(SpanningTree)_예_6.png)

	| 간선 | (1, 2)     | (1 ,5) | (2, 3) | (2, 6) | (3, 4)     | (4, 6)     | (4, 7)     | (5, 6) | (6, 7) |
	| ---- | ---------- | ------ | ------ | ------ | ---------- | ---------- | ---------- | ------ | ------ |
	| 비용 | 29         | 75     | 35     | 34     | 7          | 23         | 13         | 53     | 25     |
	| 순서 | **step 5** |        |        |        | **step 1** | **step 3** | **step 2** |        | step 4 |

	| 노드 | 1   | 2   | 3   | 4   | 5   | 6   | 7   |
	| ---- | --- | --- | --- | --- | --- | --- | --- |
	| 부모 | 1   | 1   | 3   | 3   | 5   | 3   | 3   |

- step 6

	그 다음 비용이 가장 작은 간선인 (2, 6)을 선택한다.

	![신장 트리 (Spanning Tree)_예_1.png](/bin/PS_image/신장트리(SpanningTree)_예_7.png)

	| 간선 | (1, 2)     | (1 ,5) | (2, 3) | (2, 6)     | (3, 4)     | (4, 6)     | (4, 7)     | (5, 6) | (6, 7) |
	| ---- | ---------- | ------ | ------ | ---------- | ---------- | ---------- | ---------- | ------ | ------ |
	| 비용 | 29         | 75     | 35     | 34         | 7          | 23         | 13         | 53     | 25     |
	| 순서 | **step 5** |        |        | **step 6** | **step 1** | **step 3** | **step 2** |        | step 4 |

	| 노드 | 1   | 2   | 3   | 4   | 5   | 6   | 7   |
	| ---- | --- | --- | --- | --- | --- | --- | --- |
	| 부모 | 1   | 1   | 1   | 1   | 5   | 1   | 1   |

- step 7

	그 다음 비용이 가장 작은 간선인 (2, 3)을 선택한다. 다만, 노드 2와 노드 3의 루트가 이미 동일한 집합에 포함되어 있으므로 union 함수를 호출하지 않는다.

	![신장 트리 (Spanning Tree)_예_1.png](/bin/PS_image/신장트리(SpanningTree)_예_8.png)

	| 간선 | (1, 2)     | (1 ,5) | (2, 3) | (2, 6)     | (3, 4)     | (4, 6)     | (4, 7)     | (5, 6) | (6, 7) |
	| ---- | ---------- | ------ | ------ | ---------- | ---------- | ---------- | ---------- | ------ | ------ |
	| 비용 | 29         | 75     | 35     | 34         | 7          | 23         | 13         | 53     | 25     |
	| 순서 | **step 5** |        | step 7 | **step 6** | **step 1** | **step 3** | **step 2** |        | step 4 |

	| 노드 | 1   | 2   | 3   | 4   | 5   | 6   | 7   |
	| ---- | --- | --- | --- | --- | --- | --- | --- |
	| 부모 | 1   | 1   | 1   | 1   | 5   | 1   | 1   |

- step 8

	그 다음 비용이 가장 작은 간선인 (5, 6)을 선택한다.

	![신장 트리 (Spanning Tree)_예_1.png](/bin/PS_image/신장트리(SpanningTree)_예_9.png)

	| 간선 | (1, 2)     | (1 ,5) | (2, 3) | (2, 6)     | (3, 4)     | (4, 6)     | (4, 7)     | (5, 6)     | (6, 7) |
	| ---- | ---------- | ------ | ------ | ---------- | ---------- | ---------- | ---------- | ---------- | ------ |
	| 비용 | 29         | 75     | 35     | 34         | 7          | 23         | 13         | 53         | 25     |
	| 순서 | **step 5** |        | step 7 | **step 6** | **step 1** | **step 3** | **step 2** | **step 8** | step 4 |

	| 노드 | 1   | 2   | 3   | 4   | 5   | 6   | 7   |
	| ---- | --- | --- | --- | --- | --- | --- | --- |
	| 부모 | 1   | 1   | 1   | 1   | 1   | 1   | 1   |

- step 9

	그 다음 비용이 가장 작은 간선인 (1, 5)을 선택한다. 다만, 노드 1과 노드 5의 루트가 이미 동일한 집합에 포함되어 있으므로 union 함수를 호출하지 않는다.

	![신장 트리 (Spanning Tree)_예_1.png](/bin/PS_image/신장트리(SpanningTree)_예_10.png)

	| 간선 | (1, 2)     | (1 ,5) | (2, 3) | (2, 6)     | (3, 4)     | (4, 6)     | (4, 7)     | (5, 6)     | (6, 7) |
	| ---- | ---------- | ------ | ------ | ---------- | ---------- | ---------- | ---------- | ---------- | ------ |
	| 비용 | 29         | 75     | 35     | 34         | 7          | 23         | 13         | 53         | 25     |
	| 순서 | **step 5** | step 9 | step 7 | **step 6** | **step 1** | **step 3** | **step 2** | **step 8** | step 4 |

	| 노드 | 1   | 2   | 3   | 4   | 5   | 6   | 7   |
	| ---- | --- | --- | --- | --- | --- | --- | --- |
	| 부모 | 1   | 1   | 1   | 1   | 1   | 1   | 1   |

##### b. 결론

이렇게 최소 신장 트리를 찾았고 최소 신장 트리에 포함된 간선 비용을 모두 더하면, 그 값이 최종 비용이다.

![신장트리](/bin/PS_image/신장트리(SpanningTree)_예_결론.png)

##### c. 소스코드

```python

def find_parent(parent, x):  
    if parent[x] != x:  
        parent[x] = find_parent(parent, parent[x])  
    return parent[x]  
  
def union_parent(parent, a, b):  
    a = find_parent(parent, a)  
    b = find_parent(parent, b)  
      
    if a < b:  
        parent[b] = a  
    else:  
        parent[a] = b  
          
v, e = map(int, input().split())  
parent = [0] * (v+1)  
  
edges = []  
result = 0  
  
for i in range(1, v+1):  
    parent[i] = i  
      
for _ in range(e):  
    a, b, cost = map(int, input().split())  
    edges.append((cost, a, b))  
      
edges.sort()  
  
for edge in edges():  
    cost, a, b = edge  
      
    if find_parent(parent, a) != find_parent(parent, b):  
        union_parent(parent, a, b)  
        result += cost  
          
print(result)

```

##### d. 크루스칼 알고리즘의 시간 복잡도

간선의 개수가 E개일 때, O(ElogE)의 시간 복잡도를 가진다. 크루스칼 알고리즘에서 시간이 가장 오래 걸리는 부분이 간선을 정렬하는 작업이며, E개의 데이터를 정렬했을 떄의 시간 복잡도는 O(ElogE)이기 때문이다. 크루스칼 내부에서 사용되는 서로소 집합 알고리즘의 시간 복잡도는 정렬 알고리즘의 시간 복잡도보다 작으므로 무시한다.



# 참고문헌

나동빈, "이것이 취업을 위한 코딩 테스트다 with 파이썬", 초판, 2쇄, 한빛미디어, 2020년

#코딩테스트 #파이썬 #나동빈 #한빛미디어 #이것이취업을위한코딩테스트다 #개념 #신장트리 #크루스칼알고리즘