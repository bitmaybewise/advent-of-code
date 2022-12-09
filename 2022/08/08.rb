input = File.read("#{__dir__}/input")

trees = input.split("\n").map(&:chars).map { |chars| chars.map(&:to_i) }

trees_borders_count = (trees.size * 2) + (trees[0].size - 2) * 2
left_border, top_border = 0, 0
right_border, bottom_border = trees[0].size-1, trees.size-1

visible = 0
i, j = 1, 1
while i < right_border
  while j < bottom_border
    current = trees[i][j]

    left, visible_left = j-1, true
    while left >= left_border
      if current <= trees[i][left]
        visible_left = false
        break
      end
      left -= 1
    end

    right, visible_right = j+1, true
    while right <= right_border
      if current <= trees[i][right]
        visible_right = false
        break
      end
      right += 1
    end

    top, visible_top = i-1, true
    while top >= top_border
      if current <= trees[top][j]
        visible_top = false
        break
      end
      top -= 1
    end

    bottom, visible_bottom = i+1, true
    while bottom <= bottom_border
      if current <= trees[bottom][j]
        visible_bottom = false
        break
      end
      bottom += 1
    end

    visible += 1 if visible_left || visible_right || visible_top || visible_bottom

    j += 1
  end
  
  i += 1
  j = 1
end

puts "answer 1", visible + trees_borders_count

right_border = trees[0].size
scenic_score = {}
i, j = 0, 0
while i < right_border
  scenic_score[i] = {}

  while j < bottom_border
    current = trees[i][j]

    left, seen_left = j-1, 1
    while left > left_border
      break if current <= trees[i][left]
      seen_left += 1
      left -= 1
    end

    right, seen_right = j+1, 0
    while right < right_border
      break if current <= trees[i][right]
      seen_right += 1
      right += 1
    end

    top, seen_top = i-1, 1
    while top > top_border
      break if current <= trees[top][j]
      seen_top += 1
      top -= 1
    end

    bottom, seen_bottom = i+1, 1
    while bottom < bottom_border
      break if current <= trees[bottom][j]
      seen_bottom += 1
      bottom += 1
    end

    scenic_score[i][j] = seen_left * seen_right * seen_top * seen_bottom

    j += 1
  end
  
  i += 1
  j = 0
end

puts "answer 2", scenic_score.values.flat_map(&:values).max

__END__

--- Day 8: Treetop Tree House ---

The expedition comes across a peculiar patch of tall trees all planted carefully in a grid. The Elves explain that a previous expedition planted these trees as a reforestation effort. Now, they're curious if this would be a good location for a tree house.

First, determine whether there is enough tree cover here to keep a tree house hidden. To do this, you need to count the number of trees that are visible from outside the grid when looking directly along a row or column.

The Elves have already launched a quadcopter to generate a map with the height of each tree (your puzzle input). For example:

30373
25512
65332
33549
35390

Each tree is represented as a single digit whose value is its height, where 0 is the shortest and 9 is the tallest.

A tree is visible if all of the other trees between it and an edge of the grid are shorter than it. Only consider trees in the same row or column; that is, only look up, down, left, or right from any given tree.

All of the trees around the edge of the grid are visible - since they are already on the edge, there are no trees to block the view. In this example, that only leaves the interior nine trees to consider:

    The top-left 5 is visible from the left and top. (It isn't visible from the right or bottom since other trees of height 5 are in the way.)
    The top-middle 5 is visible from the top and right.
    The top-right 1 is not visible from any direction; for it to be visible, there would need to only be trees of height 0 between it and an edge.
    The left-middle 5 is visible, but only from the right.
    The center 3 is not visible from any direction; for it to be visible, there would need to be only trees of at most height 2 between it and an edge.
    The right-middle 3 is visible from the right.
    In the bottom row, the middle 5 is visible, but the 3 and 4 are not.

With 16 trees visible on the edge and another 5 visible in the interior, a total of 21 trees are visible in this arrangement.

Consider your map; how many trees are visible from outside the grid?

Your puzzle answer was 1823.

The first half of this puzzle is complete! It provides one gold star: *

--- Part Two ---

Content with the amount of tree cover available, the Elves just need to know the best spot to build their tree house: they would like to be able to see a lot of trees.

To measure the viewing distance from a given tree, look up, down, left, and right from that tree; stop if you reach an edge or at the first tree that is the same height or taller than the tree under consideration. (If a tree is right on the edge, at least one of its viewing distances will be zero.)

The Elves don't care about distant trees taller than those found by the rules above; the proposed tree house has large eaves to keep it dry, so they wouldn't be able to see higher than the tree house anyway.

In the example above, consider the middle 5 in the second row:

30373
25512
65332
33549
35390

    Looking up, its view is not blocked; it can see 1 tree (of height 3).
    Looking left, its view is blocked immediately; it can see only 1 tree (of height 5, right next to it).
    Looking right, its view is not blocked; it can see 2 trees.
    Looking down, its view is blocked eventually; it can see 2 trees (one of height 3, then the tree of height 5 that blocks its view).

A tree's scenic score is found by multiplying together its viewing distance in each of the four directions. For this tree, this is 4 (found by multiplying 1 * 1 * 2 * 2).

However, you can do even better: consider the tree of height 5 in the middle of the fourth row:

30373
25512
65332
33549
35390

    Looking up, its view is blocked at 2 trees (by another tree with a height of 5).
    Looking left, its view is not blocked; it can see 2 trees.
    Looking down, its view is also not blocked; it can see 1 tree.
    Looking right, its view is blocked at 2 trees (by a massive tree of height 9).

This tree's scenic score is 8 (2 * 2 * 1 * 2); this is the ideal spot for the tree house.

Consider each tree on your map. What is the highest scenic score possible for any tree?

Your puzzle answer was 211680.

Both parts of this puzzle are complete! They provide two gold stars: **