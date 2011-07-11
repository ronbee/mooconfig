# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'minitest' do
  # with Minitest::Unit
  watch(/^test\/(.*).rb/)                               { "test" }
  watch(/^lib\/(.*)([^\/]+)\.rb/)                       { "test" }
  watch(/^test\/test_helper.rb/)                       { "test" }

  # with Minitest::Spec
  # watch(/^spec\/(.*)_spec.rb/)
  # watch(/^lib\/(.*)\.rb/)                            { |m| "spec/#{m[1]}_spec.rb" }
  # watch(/^spec\/spec_helper.rb/)                     { "spec" }
end
