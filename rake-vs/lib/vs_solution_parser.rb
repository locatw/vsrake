module RakeVs
  class VsSolutionParser

    def parse_project(contents)
      projects = []

      proj_def = extract_project_defs(contents)
      proj_type, proj_params = split_project_def(proj_def)
      proj_name, proj_path, = split_project_params(proj_params)
      
      proj = {}
      proj[:name] = proj_name.delete('"')
      proj[:path] = proj_path.delete('"')
      projects << proj 

      projects
    end

    private

    def extract_project_defs(contents)
      # 改行を含むので/m修飾子が必要
      match_data = contents.match(/Project.+EndProject/m)
      raise "project definition not found" if match_data.nil?
      match_data[0]
    end

    def split_project_def(project_def)
      type, params = project_def.split("=", 2)
      return [type, params]
    end

    def split_project_params(project_params_def)
      name, path, = project_params_def.split(",", 3)
      name.strip!
      path.strip!
      return [name, path]
    end

  end
end
