module Sparrow
  module GameNumbers
    PI       = 3.14159265359
    PI_HALF  = 1.57079632679
    TWO_PI   = 6.28318530718

    def to_degree
      ((self) / PI * 180.0)
    end
  
    def to_rad
      ((self) / 180.0 * PI)
    end
  end
end

Numeric.send :include, Sparrow::GameNumbers