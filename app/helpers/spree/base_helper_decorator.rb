module Spree::BaseHelper
  def layout_partial
      if devise_controller?
          'spree/base/devise'
      else
          'spree/base/application'
      end
  end

  def link_to_cart(text = nil)
    text = text ? h(text) : t('spree.cart')
    css_class = nil

    if current_order.nil? || current_order.item_count.zero?
      text = "#{text}: (#{t('spree.empty')})"
      css_class = 'empty'
    else
      text = "#{text}: (#{current_order.item_count})  <span class='amount'>#{current_order.display_total.to_html}</span>"
      css_class = 'full'
    end

    link_to text.html_safe, spree.cart_path, class: "cart-info menu-cart #{css_class}"
  end

  def logo(image_path=Spree::Config[:logo], img_options: {})
      link_to image_tag(image_path, img_options), spree.root_path, class: 'navbar-brand'
  end

  def nav_tree(root_taxon, current_taxon, max_level = 1)
      return '' if max_level < 1 || root_taxon.children.empty?
      content_tag :ul, class: 'dropdown-menu' do
        taxons = root_taxon.children.map do |taxon|
          css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon)) ? 'active' : nil
          content_tag :li, class: css_class do
            link_to(taxon.name, seo_url(taxon)) +
              taxons_tree(taxon, current_taxon, max_level - 1)
          end
        end
        safe_join(taxons, "\n")
      end
    end

    def applicable_filters_for(_taxon)
      [:brand_filter, :price_filter].map do |filter_name|
        Spree::Core::ProductFilters.send(filter_name) if Spree::Core::ProductFilters.respond_to?(filter_name)
      end.compact
    end
end