# This migration comes from solidus_multi_vendor (originally 20170410111150)
class AddStateToVendors < SolidusSupport::Migration[4.2]
  def change
    add_column :spree_vendors, :state, :string
    add_index :spree_vendors, :state
  end
end
