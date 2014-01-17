#!/usr/bin/env ruby

########################################
# Iqueue
########################################
class Iqueue
  def initialize(_size = 0)
    @size, @head, @tail = [0, nil, nil]
    _size.times{|i| enq( block_given? ? yield(i) : nil) }
  end
  attr_reader :size, :head, :tail

  #### enqueue, push ####
  def enqueue(_item); enq(_item); end
  def push(_item);    enq(_item); end
  def enq(_item)
    @size += 1
    iql = Iqueue_list.new(_item, @tail, nil)
    @head == nil ? @head = iql : @tail.next = iql
    @tail = iql
    self
  end

  #### unshift ####
  def unshift(_item)
    @size += 1
    iql = Iqueue_list.new(_item, nil, @head)
    @head = iql
    @tail = iql if @tail == nil
    self
  end

  #### dequeue, shift ####
  def dequeue; deq; end
  def shift;   deq; end
  def deq
    return nil if @head == nil
    @size -= 1
    iql = @head
    if @head.next == nil
      @head, @tail = [nil, nil]
    else
      @head = @head.next
      @head.prev = nil
    end
    iql.item
  end

  #### pop ####
  def pop
    return nil if @tail == nil
    @size += 1
    iql = @tail
    if @tail.prev == nil
      @head, @tail = [nil, nil]
    else
      @tail = @tail.prev
      @tail.next = nil
    end
    iql.item
  end

  #### clone ####
  def clone
    q = Iqueue.new
    self.each{|i| q.push(i)}
    q
  end

  #### to array ####
  def to_a
    ary = []
    self.each{|i| ary.push(i)}
    ary
  end

  #### each ####
  def each
    iql = @head
    while iql != nil
      yield(iql.item)
      iql = iql.next
    end
  end

  #### map ####
  def map; self.clone.map!{|i| yield(i)}; end
  def map!
    iql = @head
    while iql != nil
      iql.item = yield(iql.item)
      iql = iql.next
    end
    self
  end

  #### + ####
  def +(_q)
    @tail.next = _q.head if @tail != nil
    @tail = _q.tail
    @size += _q.size
    self
  end

  #### [] ####
  def [](key)
    return @tail.item if key < 0
    iql = @head
    key.times{|i| iql = iql.next}
    iql.item
  end
end

########################################
# Iqueue list
########################################
class Iqueue_list
  def initialize(_item = nil, _prev = nil, _next = nil)
    @item, @prev, @next = [_item, _prev, _next]
  end
  attr_accessor :item, :prev, :next
end
