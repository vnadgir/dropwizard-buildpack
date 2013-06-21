require 'java_buildpack/container'
require 'java_buildpack/container/main'
require 'java_buildpack/util/properties'

module JavaBuildpack::Container

  class Dropwizard < Main

    def release
      @java_opts << "-Ddw.http.port=$PORT"
      @java_opts << "-Ddw.http.adminPort=$PORT"
      # 0.7.0: @java_opts << "-Ddw.server.connector.port=$PORT"

      "#{@java_home}/bin/java -cp . #{java_opts} #{main_class} server"
    end

  end

end
