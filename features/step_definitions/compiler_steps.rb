When(/^I enter (?:['"])(.*?)(?:['"])$/) do |source|
  source << "\n" unless source[-1] == "\n"
  @source = source
end

When(/^I transpile it$/) do
  @transpiler_output = Rubby.transpile(@source, @target_version)
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
