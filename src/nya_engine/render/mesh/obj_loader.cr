require "../../bindings/tinyobj"
require "./loader"

module Nya::Render
  class Mesh::OBJLoader < Nya::Render::Mesh::Loader
    extension ".obj"

    private def pull_v3(ptr, offset)
      CrystalEdge::Vector3.new(
        ptr[offset].to_f64,
        ptr[offset+1].to_f64,
        ptr[offset+2].to_f64
      )
    end

    def load(file : String)
      buffer = Storage::Reader.read_to_end(file)
      result = TinyOBJ.parse_obj(
        out attrib,
        out shapes,
        out num_shapes,
        out materials,
        out num_materials,
        buffer,
        buffer.size,
        1
      )
      nv, nn, nt = attrib.num_vertices, attrib.num_normals, attrib.num_texcoords
      Nya.log.debug "Loaded #{nv} vertices, #{nn} normals, #{nt} texcoords", "OBJLoader"
      Nya.log.warn "Obj parser returned #{result} for #{file}", "OBJLoader"
      mesh = Mesh.new
      attrib.num_vertices.times do |i|
        mesh.vertices << pull_v3 attrib.vertices, i*3
      end

      attrib.num_normals.times do |i|
        mesh.normals << pull_v3 attrib.normals, i*3
      end

      attrib.num_texcoords.times do |i|
        mesh.texcoords << pull_v3 attrib.texcoords, i*3
      end
      mesh.mode = Mode::QUADS
      Nya.log.info "#{file} : #{attrib.num_vertices} V, #{attrib.num_normals} N", "OBJLoader"
      mesh
    end
  end
end
