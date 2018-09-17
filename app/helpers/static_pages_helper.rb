module StaticPagesHelper
	def render_snippet(slug)
	  page = StaticPage.find_by(slug: slug)
	  raw page.body if page
	end

  def locale_switcher_link lang, static_page: nil
    res = nil
    url = baseUri_with_lang(lang)
    if static_page.present? && static_page.is_a?(StaticPage)
       unless lang.nil?
        url += (static_page.send('slug_' + lang.to_s) || static_page.slug)
       else
        url += static_page.slug
       end
      url.gsub!('//', '/')
      res = link_to(t(lang), url)
    else
      res = link_to(t(lang), params.to_unsafe_h.merge({ locale: lang }))
    end
    
    res
  end
end