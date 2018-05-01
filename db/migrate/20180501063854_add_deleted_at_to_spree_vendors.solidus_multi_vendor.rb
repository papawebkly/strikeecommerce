# This migration comes from solidus_multi_vendor (originally 20170412124925)
class AddDeletedAtToSpreeVendors < SolidusSupport::Migration[4.2]
  def change
    add_column :spree_vendors, :deleted_at, :datetime
    add_index :spree_vendors, :deleted_at
  end
end
