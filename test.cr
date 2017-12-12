require "./src/nya"

engine = Nya::Engine.new("Cube", 640.0, 480.0)
Nya::SceneManager.load_from_file("res/testscene2.xml")
loop{ engine.frame! }
