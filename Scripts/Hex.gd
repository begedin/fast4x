func cube_to_oddq(cube):
      col = cube.x
      row = cube.z + (cube.x - (cube.x&1)) / 2
      return Hex(col, row)

func oddq_to_cube(hex):
      x = hex.col
      z = hex.row - (hex.col - (hex.col&1)) / 2
      y = -x-z
      return Cube(x, y, z)