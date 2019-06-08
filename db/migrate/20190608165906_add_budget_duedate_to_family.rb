class AddBudgetDuedateToFamily < ActiveRecord::Migration[5.2]
  def change
    change_table :families do |t|
      t.date :budget_duedate
    end
  end
end
