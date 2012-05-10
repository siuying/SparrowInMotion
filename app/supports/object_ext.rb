PI       = 3.14159265359
PI_HALF  = 1.57079632679
TWO_PI   = 6.28318530718

module GameNumbers
  def to_rad
    ((self) / PI * 180.0)
  end
  
  def to_degree
    ((self) / 180.0 * PI)
  end
end
  
class Fixnum
  include GameNumbers
end

class Float
  include GameNumbers
end
