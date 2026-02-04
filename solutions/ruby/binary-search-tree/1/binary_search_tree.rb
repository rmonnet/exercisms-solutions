class Bst

  attr_reader :data, :left, :right
  
  def initialize(value)
    @data = value
  end

  def insert(value)
    if value <= @data then
      if @left == nil then
        @left = Bst.new value
      else
        @left.insert value
      end
    else
      if @right == nil then
        @right = Bst.new value
      else
        @right.insert value
      end
    end
  end

  def each(&block)
    return to_enum(:each) unless block_given?
    @left.each(&block) unless @left == nil
    yield @data
    @right.each(&block) unless @right == nil
  end
end
