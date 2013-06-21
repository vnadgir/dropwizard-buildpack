require 'spec_helper'
require 'java_buildpack/container/dropwizard'

module JavaBuildpack::Container

  describe Dropwizard do

    it 'should return command' do
      command = Dropwizard.new(
        :java_home => 'test-java-home',
        :java_opts => [ 'test-opt-2', 'test-opt-1' ],
        :configuration => { 'java_main_class' => 'test-java-main-class' }).release

      expect(command).to eq('test-java-home/bin/java -cp . -Ddw.http.adminPort=$PORT -Ddw.http.port=$PORT test-opt-1 test-opt-2 test-java-main-class server')
    end
  end

end

module Test
  class StubContainer
  end
end
