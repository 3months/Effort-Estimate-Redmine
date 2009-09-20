require File.dirname(__FILE__) + '/../spec_helper'

describe Issue, '#before_save' do
  it 'should call #update_estimate' do
    Issue.before_save.collect(&:method).should include(:update_estimate)
  end
end

describe Issue, '#update_due_date' do
  before(:each) do
    @issue = Issue.new
  end
  
  describe "for an issue with an estimate" do
    it 'should set the estimate from the effort' do
      @issue.should_receive(:set_estimate_from_effort)
      @issue.update_estimate
    end
  end

end

describe Issue, '#set_estimate_from_effort' do
  before(:each) do
    @issue = Issue.new
  end

  it "should do nothing if the issue has no effort" do
    @issue.should_not_receive(:estimated_hours=)
    @issue.set_estimate_from_effort
  end

  it "should set the estimated_hours to the effort value if it is present" do
    effort_field_id = CustomField.find_by_name("Effort").id
    value = @issue.custom_value.new
    value.custom_field_id = effort_field_id
    value.value = "High 10-20"
    value.save
    @issue.should_receive(:estimated_hours=).with(20)
    @issue.save
    @issue.set_estimate_from_effort
  end
end

