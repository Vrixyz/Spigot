require 'redcarpet'

module MarkdownHelper

  def markdown_to_html(md)
    renderer = Redcarpet::Render::HTML.new
    extensions = {hard_wrap: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    return redcarpet.render(sanitize(md)).html_safe
  end
end
