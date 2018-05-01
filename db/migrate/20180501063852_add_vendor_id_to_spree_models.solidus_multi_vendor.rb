# This migration comes from solidus_multi_vendor (originally 20170406102944)
class AddVendorIdToSpreeModels < SolidusSupport::Migration[4.2]
  def change
    table_names = %w[
      products
      stock_locations
      shipping_methods
      stores
    ]

    table_names.each do |table_name|
      add_reference "spree_#{table_name}", :vendor, index: true
    end
  end
end
