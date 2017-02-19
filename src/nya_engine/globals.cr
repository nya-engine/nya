require "./render/*"

module Nya
  @@width = 640.0
  @@height = 480.0
  @@camera_list = [] of Nya::Render::Camera

  class_property width, height, camera_list
end
