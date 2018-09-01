class ChangeAddressToBeTextInEvents < ActiveRecord::Migration[5.1]
 def up
   change_column :events, :address, :text
 end

 def down
   change_column :events, :address, :string
 end
end
