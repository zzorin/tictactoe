class AddAasmStateToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :aasm_state, :string
  end
end
