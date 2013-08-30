require 'spec_helper'

describe "Ecore" do
  it "should initialize" do
    Ecore::ecore_init().should eq(1)
    Ecore::ecore_shutdown().should eq(0)
  end

  it "should add jobs" do
    JobCallback = Proc.new do |data|
      $stdout.puts data.read_string
    end

    $stdout.should_receive(:puts).with("foo")
    $stdout.should_not_receive(:puts).with("bar")

    Ecore::ecore_init
    job1 = Ecore::ecore_job_add(JobCallback, FFI::MemoryPointer.from_string("foo"))
    job2 = Ecore::ecore_job_add(JobCallback, FFI::MemoryPointer.from_string("bar"))
    quit_job = Ecore::ecore_job_add(Proc.new { Ecore::ecore_main_loop_quit }, nil)

    job2_data = Ecore::ecore_job_del(job2).read_string
    job2_data.should eq("bar")

    Ecore::ecore_main_loop_begin
    Ecore::ecore_shutdown
  end

  it "should adjust throttle" do
    Ecore::ecore_init

    Ecore::ecore_throttle_adjust(0.7)
    Ecore::ecore_throttle_get.should eq(0.7)

    Ecore::ecore_shutdown
  end
end
