require 'redcarpet'

module MarkdownHelper

  def markdown_to_html(md)
    renderer = Redcarpet::Render::HTML.new
    extensions = {}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    return redcarpet.render md.html_safe
  end
end
