# Responsible for returning a collection of items
# Results can be sorted, filtered, and paginated
class BlogPostQuery < BaseQuery
  def tables_hash
    {
      blog_posts: ::Blog::Post.arel_table,
    }
  end

  def base_collection
    collection || ::Blog::Post.all
  end

  def filter_class
    QueryFilters::BlogPostFilter
  end

  protected

  def sort_by
    tables.blog_posts[sort.key]
  end
end
