# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    @movie = Movie.create!(movie)
  end
end

Then /(.*) seed movies should exist/ do |n_seeds|
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(",").each do |rating|
    strip = rating.strip
    if uncheck.eql? "un"
      steps %(And I uncheck "#{strip}")
    else
      steps %(And I check "#{strip}")
    end
  end
end

Then /I should see all the movies/ do
  table = page.find(:css, 'table tbody')
  row_count = table.all(:css, 'tr').size
  expect(row_count).to eq 10
end
