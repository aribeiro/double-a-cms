require 'spec_helper'
describe ApplicationHelper do
  describe "Strip Words" do
    before :each do
      @text = "<p>&nbsp;&nbsp; Sed  nec  diam &nbsp;eu diam     mattis viverra.</p>
      <p>Nulla fringilla, orci ac euismod semper, magna.</p>
      <p>Nulla fringilla, orci ac euismod semper, magna diam<p>
      <p>porttitor mauris, quis sollicitudin sapien justo in libero.</p> 
      <p>Vestibulum mollis mauris enim. Morbi euismod magna ac lorem</p> 
      <p>rutrum elementum. Donec viverra auctor lobortis.</p> 
      <p>Pellentesque eu est a nulla placerat dignissim.</p>
      <p>Morbi a enim in magna semper bibendum. Etiam scelerisque, nunc ac</p> 
      <p>egestas consequat, odio nibh euismod nulla, eget auctor orci nibh vel</p>
      <p>nisi. Aliquam erat volutpat. Mauris vel neque sit amet nunc gravida</p>
      <p>congue sed sit amet purus. Quisque lacus quam, egestas.</p>"
    end

    it "should strip the white spaces" do
      helper.strip_words(@text, 7).should == "Sed nec diam eu diam mattis viverra...."
    end
    it "should return 30 words without argument" do
      helper.strip_words(@text).split(" ").length.should eq(30)
    end
    it "should return 5 words" do
      helper.strip_words(@text, 5).split(" ").length.should eq(5)
    end
    it "should return 5 words with [more] as extension" do
      helper.strip_words(@text, 5, " [more]").should == "Sed nec diam eu diam [more]"
    end
  end
end
