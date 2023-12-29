class SfedulibController < ApplicationController
  include SfedulibHelper

  def home
    session[:return] = 'home'
    session[:access_level] = 0 if session[:access_level].nil?
    @user_type = session[:access_level]
    @user = Student.find_by(id: session[:current_user]) if session[:access_level] == 1
    @user = Tutor.find_by(id: session[:current_user]) if session[:access_level] == 2
    @search = session[:search]
    @author_search = session[:author_search]
    @books = Book.joins(:authors).where('book_name LIKE ?', "%#{session[:search]}%").where('authors.first_name LIKE ? or authors.last_name LIKE ?', "%#{session[:author_search]}%", "%#{session[:author_search]}%")
    if session[:access_level] == 1
      @books = @books.left_joins(:student_books).where('student_id = ? or student_books.student_id is null', session[:current_user])
    end

    if session[:access_level] == 2
      @books = @books.left_joins(:tutor_books).where('tutor_id = ? or tutor_books.tutor_id is null', session[:current_user])
    end

    @books = @books.where(count: -1) if session[:access_level] == 0

    @books = @books.where(restricted_access: false) if session[:access_level] <= 1

    @books = @books.order('book_name ASC')
    @bookcount = @books.count
    @page = [1, [params[:page].to_i, @bookcount / 10 + 1].min].max
    @books = @books.offset(10 * (@page - 1)).limit(10)
  end

  def user
    session[:return] = 'user'
    session[:access_level] = 0 if session[:access_level].nil?
    redirect_to controller: 'sfedulib', action: 'home' if session[:access_level] == 0
    @user_type = session[:access_level]
    @user = Student.left_joins(:groups).find_by(id: session[:current_user]) if session[:access_level] == 1
    @user = Tutor.left_joins(:groups).find_by(id: session[:current_user]) if session[:access_level] == 2
    @search = session[:search]
    @author_search = session[:author_search]
    @books = Book.joins(:authors).where('book_name LIKE ?', "%#{session[:search]}%").where('authors.first_name LIKE ? or authors.last_name LIKE ?', "%#{session[:author_search]}%", "%#{session[:author_search]}%")

    if session[:access_level] == 1
      @books = @books.left_joins(:student_books).where('student_id = ?', session[:current_user])
    end

    if session[:access_level] == 2
      @books = @books.left_joins(:tutor_books).where('tutor_id = ?', session[:current_user])
    end

    @books = @books.order('book_name ASC')
    @bookcount = @books.count
    @page = [1, [params[:page].to_i, @bookcount / 10 + 1].min].max
    @books = @books.offset(10 * (@page - 1)).limit(10)
  end

  def update_search_parameters
    session[:search] = params[:search]
    session[:author_search] = params[:author_search]
    redirect_to controller: 'sfedulib', action: session[:return]
  end

  def login
    tutor = Tutor.find_by(login: params[:login])
    unless tutor.nil? || (tutor.authenticate(params[:password]) == false)
      session[:current_user] = Tutor.find_by(login: params[:login]).authenticate(params[:password]).id
      session[:access_level] = 2
    end

    student = Student.find_by(login: params[:login])
    unless student.nil? || (student.authenticate(params[:password]) == false)
      session[:current_user] = Student.find_by(login: params[:login]).authenticate(params[:password]).id
      session[:access_level] = 1
    end
    redirect_to controller: 'sfedulib', action: 'home', page: 1
  end

  def logout
    session[:current_user] = nil
    session[:access_level] = 0
    redirect_to controller: 'sfedulib', action: 'home', page: 1
  end

  def book
    @select_book = Book.find_by(id: params[:id])
    redirect_to controller: 'sfedulib', action: session[:return] if @select_book.nil?
    unless @select_book.nil?
      @book_cover = url_for(Book.find_by(id: params[:id]).cover)
      @book_description = url_for(Book.find_by(id: params[:id]).description)
    end
  end

  def take_book
    select_book = Book.find_by(id: params[:id])
    unless select_book.count == 0
      if (session[:access_level] == 1) && (StudentBook.where(student_id: session[:current_user], book_id: params[:id]).count == 0)
        if select_book.count == -1
          StudentBook.create!(student_id: session[:current_user], book_id: params[:id])
        else
          select_group = Group.joins(:group_books).joins(:groups_students).where('student_id = ?', session[:current_user]).where('book_id = ?', params[:id])
          if select_group.count == 0
            StudentBook.create!(student_id: session[:current_user], book_id: params[:id], return_date: select_group.max_by { |x| x.group_book.return_date })
          else
            StudentBook.create!(student_id: session[:current_user], book_id: params[:id], return_date: DateTime.now + 2.week)
          end
        end
      end
      if (session[:access_level] == 2) && (TutorBook.where(tutor_id: session[:current_user], book_id: params[:id]).count == 0)
        if select_book.count == -1
          TutorBook.create!(tutor_id: session[:current_user], book_id: params[:id])
        else
          select_group = Group.joins(:group_books).joins(:groups_tutors).where('tutor_id = ?', session[:current_user]).where('book_id = ?', params[:id])
          if select_group.count == 0
            TutorBook.create!(tutor_id: session[:current_user], book_id: params[:id], return_date: DateTime.now + 2.week)
          else
            TutorBook.create!(tutor_id: session[:current_user], book_id: params[:id], return_date: select_group.max_by { |x| x.group_book.return_date })
          end
        end
      end
    end

    redirect_to controller: 'sfedulib', action: session[:return], page: '1'
  end

  def return_book
    if session[:access_level] == 1
      book = StudentBook.find_by(student_id: session[:current_user], book_id: params[:id])
      book.destroy unless book.nil?
    end

    if session[:access_level] == 2
      book = TutorBook.find_by(tutor_id: session[:current_user], book_id: params[:id])
      book.destroy unless book.nil?
    end
    redirect_to controller: 'sfedulib', action: session[:return], page: '1'
  end

  def extend_book
    if session[:access_level] == 1
      @select_book = StudentBook.find_by(book_id: params[:id], student_id: session[:current_user])
      @select_book.update(return_date: DateTime.now + 2.week) if @select_book.return_date < DateTime.now + 2.week
    end

    if session[:access_level] == 2
      @select_book = TutorBook.find_by(book_id: params[:id], tutor_id: session[:current_user])
      @select_book.update(return_date: DateTime.now + 2.week) if @select_book.return_date < DateTime.now + 2.week
    end

    redirect_to controller: 'sfedulib', action: session[:return], page: '1'
  end

  def request_book
    Open_Book_Request.update(tutor_id: session[:current_user].id, book_id: params[:id])
  end

  def book_content
    @open_book = url_for(Book.find_by(id: params[:id]).content)
    @user_type = session[:access_level]
    @user_type = 0 if @user_type.nil?
    @user = Student.find_by(id: session[:current_user]) if session[:access_level] == 1
    @user = Tutor.find_by(id: session[:current_user]) if session[:access_level] == 2
  end

  def deadend; end
end
