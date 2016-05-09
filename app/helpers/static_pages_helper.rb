module StaticPagesHelper
	def render_snippet(slug)
	  page = StaticPage.find_by_slug(slug)
	  raw page.body if page
	end
end