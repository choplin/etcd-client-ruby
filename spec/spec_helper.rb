require 'fileutils'
require 'awesome_print'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

module EtcdHelper
  @@workdir = File.join(File.dirname(__FILE__), 'tmp')

  def cleanup_etcd_env
    FileUtils.rm_rf(@@workdir)
    FileUtils.mkdir(@@workdir)
  end

  def setup_etcd
    cleanup_etcd_env
    @@pid = spawn('etcd', :chdir => @@workdir, :out => '/dev/null', :err => '/dev/null')
    sleep 1
  end

  def teardown_etcd
    Process.kill "TERM", @@pid
    Process.waitpid @@pid
  end
end
