# Table of Contents

- [1. Routing Protocol Algorithm](#1-routing-protocol-algorithm)
  - [A. DV (Distance Vector)](#a-dv-distance-vector)
  - [B. LS (Link State)](#b-ls-link-state)

---

# 1. Routing Protocol Algorithm

> DV Routing / LS Routing은 다른 강의 보고 정리해야함.

## A. DV (Distance Vector)

> 주변 정보만 가지는 라우팅

- 각각의 노드들은 전체 네트워크에 대한 정보를 가지고 있는게 아님
- 내 주변의 노드들(이웃한 노드들)이 네트워크 안에 있는 각 노드로 가는데 비용이 얼마나 드는지를 알고 있고, 내가 그 이웃까지 가는 비용을 알고 있으면 내가 목적지까지 가는 비용을 계산할 수 있음 
- 나와 내 주변 노드들이 최종 목적지까지 가는데 얼만큼의 비용이 드는지를 가지고 내가 목적지까지 가는데 걸리는 비용을 계산해서 다음 노드로 어떤 노드가 최적일지를 정하는 방법
- 문제
	- 네트워크에 변화가 없다고 가정하면 Distance Vector 알고리즘도 언제나 최적값을 준다.	
	- 최적값을 구한 상태에서 정보 하나가 바뀌게 되면, 지금까지 가지고 있던 정보가 틀어지게 된다.
		- 이때, 문제가 생기게 된다. (카운팅 ~~~ (? count to infinity))
	- 최적값이 아닌건 큰 문제가 아님. 다만, 라우팅이 loop가 생기게 됨.
		- loop에 걸쳐져 있는 모든 네트워크 장비들을 다운시키게 됨.

## B. LS (Link State)

> 전체 네트워크를 가지고 라우팅

- 각각의 노드가 네트워크 전체에 대한 정보를 알고 있는 것이 좋겠더라.
- 비용은 더 많이 듬
	- 요즘은 네트워크가 빨라서, 네트워크의 속도에 비하면 큰 비용이 아님
