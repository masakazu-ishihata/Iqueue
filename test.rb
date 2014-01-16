#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require "./Iqueue.rb"

for d in 1..5
  [ Array.new(10 ** d), Iqueue.new(10 ** d)].each do |a|
    # shift/push を 1000 回行い、時間を測定
    st, pt = [0, 0]
    for i in 1..1000
      # shift
      t = Time.now
      a.shift
      st += Time.now - t

      # push
      t = Time.now
      a.push(nil)
      pt += Time.now - t
    end

    # 結果
    printf("%2d %10d %.5e %.5e\n", d, 10 ** d, st, pt)
  end
end
