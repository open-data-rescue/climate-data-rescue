class StaticPage < ActiveRecord::Base
  default_scope { order(position: :asc) }

  validates :title, presence: true
  validates :slug, :body, presence: true, if: :not_using_foreign_link?
  validates :slug, uniqueness: true, if: :not_using_foreign_link?
  validates :foreign_link, uniqueness: true, allow_blank: true

  scope :visible, -> { where(visible: true) }
  scope :top_level, -> { where(parent_id: nil) }
  scope :header_links, -> { where(show_in_header: true).visible.top_level }
  scope :sidebar_links, -> { where(show_in_sidebar: true).visible.top_level }

  before_save :update_positions_and_slug

  translates :title, :body, :slug, :meta_keywords, :meta_title,
             :meta_description, fallbacks_for_empty_translations: true

  globalize_accessors

  has_many :children, class_name: 'StaticPage', :dependent => :destroy, foreign_key: :parent_id
  belongs_to :parent, class_name: 'StaticPage'

  def initialize(*args)
    super(*args)
    last_page = StaticPage.last
    self.position = last_page ? last_page.position + 1 : 0
  end

  def link
    foreign_link.blank? ? ('/' + I18n.locale.to_s + slug) : foreign_link
  end
  
  def is_external?
    foreign_link.present?
  end

  def self.matches?(request)
    Rails.logger.info '================================='
    slug = request.path
    I18n.available_locales.each do |locale|
      slug.gsub!('/' + locale.to_s + '/', '/')
    end
    # return false if slug =~ %r{\A\/+(admin|account|cart|checkout|content|login|pg\/|orders|products|s\/|session|signup|shipments|states|t\/|tax_categories|user)+}
    StaticPage.visible.find_by(slug: slug).present?
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
end
