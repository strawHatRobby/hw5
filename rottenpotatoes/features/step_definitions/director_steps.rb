Given /^the following movies exist:$/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end

# Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |arg1, arg2|
#     if !body.include? arg1
#         flunk("Page missing the movie!")
#     end
#     if !body.include? arg2
#         flunk("Page missing the director!")
#     end
# end
Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  assert page.body =~ /#{e1}.*#{e2}/m, "#{e1} was not before #{e2}"
end


Then /^the director of "(.*?)" should be "(.*?)"$/ do |movie_title, new_director|
  movie = Movie.find_by_title movie_title
  movie.director.should == new_director
end
