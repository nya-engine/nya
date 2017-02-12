module Nya
  class SceneManager
    @@current_scene : AbsScene?

    def self.current_scene; @@current_scene end
    def self.current_scene=(s); @@current_scene = s end

    def self.render
      return if current_scene.nil?
      current_scene.not_nil!.render
    end

    def self.update
      return if current_scene.nil?
      current_scene.not_nil!.update
    end
  end
end
