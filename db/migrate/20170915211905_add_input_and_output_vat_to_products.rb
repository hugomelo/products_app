class AddInputAndOutputVatToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :input_vat,      :float, default: 0
    add_column :products, :output_vat,     :float, default: 0
    add_column :products, :price_with_vat, :float

    # set the price_with_vat to the same value as the price while VAT isn't setup. batches of 1000
    Product.find_each {|product| product.update output_vat: 0 }
  end

end
