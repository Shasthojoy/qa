module QuestionsHelper
  def homepage_user(user)
    if user == nil
      "anonymous"
    else
      %Q[#{link_to user.name, user_url(user)} <span class="reputation">#{reputation_formatter user.reputation}</span>].html_safe
    end
  end
end