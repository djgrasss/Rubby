When(/^I enter (?:['"])(.*?)(?:['"])$/) do |source|
  @source = source
end

When(/^I transpile it$/) do
  @transpiler_output = Rubby.transpile(@source)
end

Then(/^I should get (?:['"])(.*?)(?:['"])$/) do |what|
  @transpiler_output.should eq(what)
end
