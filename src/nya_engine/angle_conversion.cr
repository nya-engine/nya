module Nya
  def self.to_deg(angle)
    angle * 180.0 / Math::PI
  end

  def self.to_rad(angle)
    angle * Math::PI / 180.0
  end
end
