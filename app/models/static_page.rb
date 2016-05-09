class StaticPage < ActiveRecord::Base
	default_scope { order(position: :asc) }

	validates :title, presence: true
	validates :slug, :body, presence: true, if: :not_using_foreign_link?
	validates :slug, uniqueness: true, if: :not_using_foreign_link?
	validates :foreign_link, uniqueness: true, allow_blank: true

	scope :visible, -> { where(visible: true) }
	scope :header_links, -> { where(show_in_header: true).visible }
	scope :sidebar_links, -> { where(show_in_sidebar: true).visible }

  before_save :update_positions_and_slug


	def initialize(*args)
  	super(*args)
  	last_page = StaticPage.last
  	self.position = last_page ? last_page.position + 1 : 0
	end

  def link
    foreign_link.blank? ? slug : foreign_link
  end

	private

	def update_positions_and_slug
    # Ensure that all slugs start with a slash.
    slug.prepend('/') if not_using_foreign_link? && !slug.start_with?('/')
    return if new_record?
    return unless (prev_position = StaticPage.find(id).position)
    if prev_position > position
      StaticPage.where('? <= position and position < ?', position, prev_position).update_all('position = position + 1')
    elsif prev_position < position
      StaticPage.where('? < position and position <= ?', prev_position, position).update_all('position = position - 1')
  	end
	end

  def not_using_foreign_link?
    foreign_link.blank?
  end

	def self.matches?(request)
    return false if request.path =~ %r{\A\/+(admin|account|cart|checkout|content|login|pg\/|orders|products|s\/|session|signup|shipments|states|t\/|tax_categories|user)+}
    !StaticPage.visible.find_by_slug(request.path).nil?
  end
end
