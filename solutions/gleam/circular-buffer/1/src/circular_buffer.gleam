import gleam/queue.{type Queue}

pub opaque type CircularBuffer(t) {
  CircularBuffer(cap: Int, queue: Queue(t))
}

pub fn new(capacity: Int) -> CircularBuffer(t) {
  CircularBuffer(cap: capacity, queue: queue.new())
}

pub fn read(buffer: CircularBuffer(t)) -> Result(#(t, CircularBuffer(t)), Nil) {
  case queue.is_empty(buffer.queue) {
    True -> Error(Nil)
    False -> {
      let assert Ok(#(value, queue)) = queue.pop_front(buffer.queue)
      Ok(#(value, CircularBuffer(buffer.cap, queue)))
      }
  }
}

pub fn write(
  buffer: CircularBuffer(t),
  item: t,
) -> Result(CircularBuffer(t), Nil) {
  case queue.length(buffer.queue) == buffer.cap {
    True -> Error(Nil)
    False -> Ok(CircularBuffer(buffer.cap, queue.push_back(buffer.queue, item)))
  }
}

pub fn overwrite(buffer: CircularBuffer(t), item: t) -> CircularBuffer(t) {
  case queue.length(buffer.queue) == buffer.cap {
    True -> {
      let assert Ok(#(_, queue)) = queue.pop_front(buffer.queue)
      CircularBuffer(buffer.cap, queue.push_back(queue, item))
    }
    False -> CircularBuffer(buffer.cap, queue.push_back(buffer.queue, item))
  }
}


pub fn clear(buffer: CircularBuffer(t)) -> CircularBuffer(t) {
  CircularBuffer(buffer.cap, queue.new())
}
