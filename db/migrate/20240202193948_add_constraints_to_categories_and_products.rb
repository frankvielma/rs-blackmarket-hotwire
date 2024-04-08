# frozen_string_literal: true

class AddConstraintsToCategoriesAndProducts < ActiveRecord::Migration[7.1]
  def up
    # Add foreign key constraint with ON DELETE NO ACTION
    execute <<-SQL.squish
      ALTER TABLE products
        ADD CONSTRAINT fk_products_category_id
          FOREIGN KEY (category_id)
          REFERENCES categories(id)
          ON DELETE NO ACTION;
    SQL
  end

  def down
    # Remove check constraint (if added)
    execute <<-SQL.squish
      ALTER TABLE categories
        DROP CONSTRAINT chk_categories_no_products;
    SQL
  end
end
