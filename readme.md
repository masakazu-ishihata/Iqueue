# Ruby で Q !

Ruby の Array さんは要素数が増えると push が死ぬほど遅くなる。  
快適な push life のため、自作で双方向 queue を作りました。  

## 使い方
こんな感じで使えばよいと思う。

    q = Iqueue.new(10){|i| i}

    p q.to_a # => [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

    q.push(10)
    q.shift

    p q.to_a # => [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

対応してるメソッドは以下。詳しくは q.methods で。

    shift / unshift
    pop / push
    deq / enq
    each / map
    to_a
