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
  movie_td = 'table#movies td:nth-child(5n+1)'
  movie_titles = page.all(:css, movie_td).map(&:text)
  expect(movie_titles.find_index(e1)).to be < movie_titles.find_index(e2)
end

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
