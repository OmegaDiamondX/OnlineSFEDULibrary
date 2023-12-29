namespace :my_namespace do
  desc "TODO"
  task return_expired_books: :environment do
    Tutor_Books.where("return_date>=?",DateTime.now).delete_all
    Student_Books.where("return_date>=?",DateTime.now).delete_all
  end

end
