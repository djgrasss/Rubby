Before do |scenario|
  @feature_name = scenario.feature.name
end

When(/^I enter (?:['"])(.*?)(?:['"])$/) do |source|
  source << "\n" unless source[-1] == "\n"
  @source = source
end

When(/^I transpile it$/) do
  @transpiler_output = Rubby.transpile(@source, @feature_name, @target_version)
end

Then(/^I should get (?:['"])(.*?)(?:['"])$/) do |what|
  @transpiler_output.chomp.should eq(what)
end

Given(/^I am targetting Ruby ([\d\.p]+)$/) do |ver|
  @target_version = ver
end

When(/^I enter$/) do |source|
  source << "\n" unless source[-1] == "\n"
  @source = source
end

Then(/^I should get$/) do |what|
  @transpiler_output.chomp.should eq(what)
end

Then(/^transpilation will raise a ([\w ]+)$/) do |error|
  exception = Rubby::Exceptions.const_get(error.to_sym)
  expect { Rubby.transpile(@source, @feature_name, @target_version) }.to raise_error(exception)
end
