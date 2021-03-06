# Cloud Foundry Java Buildpack
# Copyright (c) 2013 the original author or authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'spec_helper'
require 'java_buildpack/framework/java_opts'

module JavaBuildpack::Framework

  describe JavaOpts do

    let(:java_opts) { [] }

    it 'should detect with java.opts configuration' do
      detected = JavaOpts.new(
        :java_opts => java_opts,
        :configuration => { 'java_opts' => '-Xmx1024M' }).detect

      expect(detected).to be_true
    end

    it 'should not detect without java_opts configuration' do
      detected = JavaOpts.new(
        :java_opts => java_opts,
        :configuration => { }).detect

      expect(detected).to be_false
    end

    it 'should add split java_opts to context' do
      JavaOpts.new(
        :java_opts => java_opts,
        :configuration => { 'java_opts' => "-Xdebug -Xnoagent -Xrunjdwp:transport=dt_socket,server=y,address=8000,suspend=y -XX:OnOutOfMemoryError='kill -9 %p'" }).release

      expect(java_opts).to include('-Xdebug')
      expect(java_opts).to include('-Xnoagent')
      expect(java_opts).to include('-Xrunjdwp:transport=dt_socket,server=y,address=8000,suspend=y')
      expect(java_opts).to include('-XX:OnOutOfMemoryError=kill\ -9\ %p')
    end

  end

end
