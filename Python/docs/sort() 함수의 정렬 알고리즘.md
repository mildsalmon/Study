# 파이썬 sort() 함수의 정렬 알고리즘

TimSort 알고리즘을 사용한다.

## A. TimSort 알고리즘

Merge 정렬과 Insert 정렬에서 파생된 하이브리드 정렬 알고리즘이다.

stable하다. (정렬 알고리즘에서 stability란 원래 순서를 갖고 정렬을 할 수 있냐, 없냐의 차이)

### a. 시간복잡도

- 최상
	- O(n)
- 평균
	- O(nlogn)
- 최악
	- O(nlogn)

### b. 공간복잡도

O(n)

### c. TimSort 구현

- minrun
	- 임의의 run이 구성될 수 있는 최소 길이

Timsort는 run 생성시 run 크기를 동적으로 구한다. run을 만들 때 이미 정렬된 subsequence 기준으로 생성하며 만약 minrun보다 작게되면 insertion sort를 사용한다.

minimum run size(minrun)을 구하는 것은 data size에 의해 결정되며 elements가 64보다 작으면 minrun은 64가 되며 이처럼 사이즈가 작은 subsequence의 경우에 Timsort는 insertion sort를 수행한다. (이처럼 작은 단위에서는 binary insertion sort보다 빠른 정렬방법은 없기 때문에)

사이즈가 큰 array에서는 32~64 범위의 minrun을 가지고 array를 분할시킨다. 이러한 algorithm은 모든 array에 수행하며 크기가 64보다 작아질 때까지 한다.

### d. 코드

```python

MIN_MERGE = 64

def timSort(arr):
    def calcMinRun(n):
        """Returns the minimum length of a run from 23 - 64 so that
        the len(array)/minrun is less than or equal to a power of 2.

        e.g. 1=>1, ..., 63=>63, 64=>32, 65=>33, ..., 127=>64, 128=>32, ...
        """
        r = 0
        while n >= MIN_MERGE:
            r |= n & 1
            n >>= 1
        return n + r
        
    n = len(arr)
    minRun = calcMinRun(n)
    
    # min run 만큼 건너뛰면서 삽입 정렬 실행
    for start in range(0, n, minRun):
        end = min(start + minRun - 1, n - 1)
        arr = insert_sort(arr, start, end)
    currentSize = minRun

    # minRun이 배열 길이보다 작을 때까지만 minRun * 2 를 한다.
    while currentSize < n:
        for start in range(0, n, currentSize * 2):
            mid = min(n - 1, start + currentSize - 1)
            right = min(start + 2*currentSize - 1, n - 1)
            merged = merge_sort(array1=arr[start:mid + 1],
                               array2=arr[mid + 1:right + 1])
            arr[start:start + len(merged)] = merged

        currentSize *= 2

    return arr

```
