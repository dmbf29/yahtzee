namespace :category do
  desc "Changing name from Total to Total (Need 63)"
  task update_total_name: :environment do
    category = Category.find_by_name('Total')
    if category
      category.name = 'Total (Need 63)'
      category.save
    end
  end
end
