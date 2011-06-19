# encoding: UTF-8

require "cutest"
require "open3"

test "CABA" do
  assert_equal `./bin/cpa 'Lavalleja 795, Capital Federal'`, "C1414DTO\n"
  assert_equal `./bin/cpa 'Lavalleja 795, CABA'`, "C1414DTO\n"
  assert_equal `./bin/cpa 'Lavalleja 795, Ciudad Autónoma de Buenos Aires'`, "C1414DTO\n"
end

test "Interior" do
  assert_equal `./bin/cpa 'Independencia 333, Sunchales, Santa Fe'`, "S2322AWD\n"
  assert_equal `./bin/cpa 'Av Independencia 333, Sunchales, Santa Fe'`, "S2322AWD\n"
  assert_equal `./bin/cpa 'Avenida Independencia 333, Sunchales, Santa Fe'`, "S2322AWD\n"
end

test "stdin" do
  Open3.popen3("./bin/cpa -") do |stdin, stdout|
    stdin.puts "Amenábar 1294, Capital Federal"
    assert_equal "C1426AJV\n", stdout.gets
    stdin.puts "Aguirre 230, Capital Federal"
    assert_equal "C1414ASF\n", stdout.gets
  end
end

test "errors" do
  Open3.popen3("./bin/cpa 'Lavalleja 795'") do |_, stdout, stderr, wait|
    assert stdout.read.empty?
    assert stderr.read =~ /Error: no se encontró la provincia/
    assert !wait.value.success?
  end

  Open3.popen3("./bin/cpa 'Lavalleja 795, New York'") do |_, stdout, stderr, wait|
    assert stdout.read.empty?
    assert stderr.read =~ /Error: no se encontró la provincia 'New York'/
    assert !wait.value.success?
  end

  Open3.popen3("./bin/cpa") do |_, stdout, stderr, wait|
    assert stdout.read.empty?
    assert stderr.read =~ /Error: nada que buscar/
    assert !wait.value.success?
  end
end
