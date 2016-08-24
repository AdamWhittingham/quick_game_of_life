class World
  def initialize(rows, cols, seed = [])
    @max_row = rows - 1
    @max_col = cols - 1
    @state = build_new_world
    seed.each { |(x,y)| @state[y][x] = :alive }
  end

  def step
    new_state = build_new_world
    @state.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        alive_neighbours = neighbours_around(x, y)

        next_cell_state = case alive_neighbours
                          when 0, 1 then nil
                          when 2 then cell
                          when 3 then :alive
                          else
                            nil
                          end

        new_state[y][x] = next_cell_state
      end
    end
    @state = new_state
  end

  def run
    loop do
      system 'clear'
      puts to_s
      step
      sleep 0.1
    end
  end

  def to_s
    @state.map do |row|
      '|' << row.map{|cell| cell_to_s(cell) }.join(' ') << "|\n"
    end
  end

  private def cell_to_s cell
    cell == :alive ? '●' : ' '
  end

  private def neighbours_around(x, y)
    neighbours = [
      [ x,     y - 1 ],
      [ x + 1, y - 1 ],
      [ x + 1, y     ],
      [ x + 1, y + 1 ],
      [ x,     y + 1 ],
      [ x - 1, y + 1 ],
      [ x - 1, y     ],
      [ x - 1, y - 1 ],
    ]

    neighbours
      .reject{|(xp, yp)| xp < 0 || yp < 0 || xp > @max_row || yp > @max_col}
      .select{|(xp, yp)| @state[yp][xp] == :alive}
      .count
  end

  private def build_new_world
    new_world = []
    (@max_row + 1).times{ new_world << Array.new(@max_col + 1) }
    new_world
  end
end

LENGTH = 50

OSCILATOR = [
  [0, 1],
  [1, 1],
  [2, 1],
]

DEAD_AND_STABLE = [
  [10, 18],
  [10, 19],
  [10, 20],
  [11, 20],
  [20,  3],
  [19,  4],
  [21,  3],
]

RANDOM = 200.times
  .map{rand(LENGTH)}
  .each_cons(2)
  .to_a

GLIDER_GUN = [
  [1,  5],
  [1,  6],
  [2,  5],
  [2,  6],
  [11, 5],
  [11, 6],
  [11, 7],
  [12, 4],
  [12, 8],
  [13, 3],
  [13, 9],
  [14, 3],
  [14, 9],
  [15, 6],
  [16, 4],
  [16, 8],
  [17, 5],
  [17, 6],
  [17, 7],
  [18, 6],
  [21, 3],
  [21, 4],
  [21, 5],
  [22, 3],
  [22, 4],
  [22, 5],
  [23, 2],
  [23, 6],
  [25, 1],
  [25, 2],
  [25, 6],
  [25, 7],
  [35, 3],
  [35, 4],
  [36, 3],
  [36, 4],
  [35, 22],
  [35, 23],
  [35, 25],
  [36, 22],
  [36, 23],
  [36, 25],
  [36, 26],
  [36, 27],
  [37, 28],
  [38, 22],
  [38, 23],
  [38, 25],
  [38, 26],
  [38, 27],
  [39, 23],
  [39, 25],
  [40, 23],
  [40, 25],
  [41, 24],
]

World.new(LENGTH, LENGTH, RANDOM).run
