require "HTTP"
x = 0
final_input = "no"
system "clear"

while final_input == "no" do 
  if x == 0
    print "Enter the name of a subreddit: " 
  elsif x > 0
    print "Enter another subreddit to check-out: "
  end

  sub_reddit = gets.chomp.to_s

  response = HTTP.get("https://www.reddit.com/r/#{sub_reddit}/.json")


  subreddit_info = response.parse
  posts = subreddit_info["data"]["children"].length

  index = 0
  bullet = 1
  posts_array = ["empty", ]
  posts.times do
    puts " "
    posts_array << subreddit_info["data"]["children"][index]["data"]["title"].to_s          # Adds all the posts into the array.
    puts "#{bullet}) " + posts_array[bullet].to_s
    puts " "

    index += 1
    bullet += 1
  end

  print "Choose post number: "

  @section = gets.chomp.to_i

  # puts "The permalink chosen #{subreddit_info["data"]["children"][@section - 1]["data"]["permalink"]}"   # Sanity check for correct permalink

  link_to_permalink = subreddit_info["data"]["children"][@section - 1]["data"]["permalink"]

  comment_web_address = "https://www.reddit.com"+link_to_permalink+".json".to_s

  comment_web = HTTP.get("#{comment_web_address}")

  comments_info = comment_web.parse

  all_comments = comments_info[1]["data"]["children"].length

  puts " "
  puts "----- Here are the commments for '#{posts_array[@section]}' -----"  
  index2 = 0
  bullet2 = 1
  all_comments.times do             
    puts " "
    one_comment = comments_info[1]["data"]["children"][index2]["data"]["body"]
    puts "#{bullet2}) "+one_comment.to_s
    index2 += 1
    bullet2 += 1
  end

  puts " "
  puts "------------------------------------------"  
  print "Do you want to exit? Type 'yes' or 'no': "
  @final_input = gets.chomp.to_s

  if @final_input == "yes"
    system "clear"
    break
  else
    system "clear"
    x += 1
  end
end




def get_post (sub_reddit)
  sub_reddit = gets.chomp.to_s

  response = HTTP.get("https://www.reddit.com/r/#{sub_reddit}/.json")


  subreddit_info = response.parse
  posts = subreddit_info["data"]["children"].length

  index = 0
  bullet = 1
  posts_array = ["empty", ]
  posts.times do
    puts " "
    posts_array << subreddit_info["data"]["children"][index]["data"]["title"].to_s          # Adds all the posts into the array.
    puts "#{bullet}) " + posts_array[bullet].to_s
    puts " "

    index += 1
    bullet += 1
  end
end




def get_comment (*)

  print "Choose post number: "

  @section = gets.chomp.to_i

  link_to_permalink = subreddit_info["data"]["children"][@section - 1]["data"]["permalink"]

  comment_web_address = "https://www.reddit.com"+link_to_permalink+".json".to_s

  comment_web = HTTP.get("#{comment_web_address}")

  comments_info = comment_web.parse

  all_comments = comments_info[1]["data"]["children"].length

  puts " "
  puts "----- Here are the commments for '#{posts_array[@section]}' -----"  
  index2 = 0
  bullet2 = 1
  all_comments.times do             
    puts " "
    one_comment = comments_info[1]["data"]["children"][index2]["data"]["body"]
    puts "#{bullet2}) "+one_comment.to_s
    index2 += 1
    bullet2 += 1
  end
end