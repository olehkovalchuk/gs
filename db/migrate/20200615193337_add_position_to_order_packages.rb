class AddPositionToOrderPackages < ActiveRecord::Migration[6.0]
  def change
    add_column :order_packages, :position, :integer
    Order::Package.all.each_with_index do |p,idx|
      p.update(position: idx + 1)
    end
  end
end
