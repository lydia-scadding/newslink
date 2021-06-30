module CommentsHelper
  def parent_link(comment)
    if params[:controller] == "comments" && params[:action] == "index"
      content_tag :span, class: "parent-link" do
        " | on: #{link_to raw(comment.link.title), link_path(comment.link)}".html_safe
      end
    end
  end
end
