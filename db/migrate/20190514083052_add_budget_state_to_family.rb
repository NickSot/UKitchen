class AddBudgetStateToFamily < ActiveRecord::Migration[5.2]
  def change
    change_table :families do |t|
      t.remove :budget
      t.decimal :weekly_budget, precision: 10, scale: 2, default: 0.0
      t.decimal :current_budget_state, precision: 10, scale: 2, default: 0.0
    end
  end
end
