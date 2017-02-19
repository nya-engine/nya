require "./storage/*"

module Nya
  class SceneManager
    @@current_scene : AbsScene?

    def self.current_scene; @@current_scene end
    def self.current_scene=(s); @@current_scene = s end

    def self.render(tag : String? = nil)
      if @@current_scene.nil?
        Nya.log.warn "Scene is nil"
      else
        @@current_scene.not_nil!.render tag
      end
    end

    def self.update
      return if current_scene.nil?
      current_scene.not_nil!.update
    end

    def self.load_from_file(filename : String)
      Nya.log.debug "Trying to load scene from #{filename}", "SceneManager"
      Storage::Reader.read_file filename do |file|
        obj = XML.parse file
        Nya.camera_list = [] of Nya::Render::Camera
        @@current_scene = Scene.deserialize(obj.first_element_child.not_nil!).as(Scene)
        @@current_scene.not_nil!.awake
      end
      Nya.log.debug "#{Nya.camera_list.select(&.enabled?).size} camera(s) active", "SceneManager"
    end
  end
end
