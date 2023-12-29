# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Student.destroy_all
Tutor.destroy_all
Book.destroy_all
Author.destroy_all

@student = Student.new(login: 'test', first_name: 'Test name', last_name: 'Test last name')
@student.password = 'teststu'
@student.save

@student = Student.new(login: 'VasIw', first_name: 'Василий', last_name: 'Иванов')
@student.password = 'IwanVasil'
@student.save
@student.groups.create(group_name: 'testgroup')

@tutor = Tutor.new(login: 'testtut', first_name: 'Test name', last_name: 'Test last name')
@tutor.password = 'testtut'
@tutor.save

@tutor = Tutor.new(login: 'MaxCos', first_name: 'Максим', last_name: 'Космонавтов')
@tutor.password = 'CosmonautMax'
@tutor.save
@tutor.groups << Group.find_by(group_name: 'testgroup')

@book = Book.new(book_name: 'Software Testing - Base Course', count: 3, restricted_access: true, description: 'Book for testing software.')
@book.content.attach(io: File.open('Software Testing - Base Course (Svyatoslav Kulikov) - 3rd edition - RU.pdf'), filename: 'Software Testing - Base Course (Svyatoslav Kulikov) - 3rd edition - RU.pdf')
@book.cover.attach(io: File.open('SWTesting.png'), filename: 'SWTesting.png')
@book.save
@book.authors.create(first_name: 'Святослав', last_name: 'Куликов')

@book = Book.new(book_name: 'Архитектура Компьютера', count: -1, restricted_access: false, description: 'Книга Эндрю Таненбаума, всемирно известного специалиста в области информационных техно-
  логий, писателя и преподавателя, выходящая уже в шестом издании, посвящена структурной орга-
  низации компьютера. В ее основе лежит идея иерархической структуры, в которой каждый уро-
  вень выполняет вполне определенную функцию. В рамках этого нетрадиционного подхода по-
  дробно описываются цифровой логический уровень, уровень архитектуры команд, уровень опера-
  ционной системы и уровень языка ассемблера.

  Книга рассчитана на широкий круг читателей: как на студентов, изучающих компьютерные тех-
  нологии, так и на тех, кто самостоятельно знакомится с архитектурой компьютера.')
@book.content.attach(io: File.open('Таненбаум-Остин-6 издание-2013.pdf'), filename: 'Таненбаум-Остин-6 издание-2013.pdf')
@book.cover.attach(io: File.open('Архком.png'), filename: 'Архком.png')
@book.save
@book.authors.create(first_name: 'Эндрю', last_name: 'Таненбаум')
@book.authors.create(first_name: 'Т', last_name: 'Остин')