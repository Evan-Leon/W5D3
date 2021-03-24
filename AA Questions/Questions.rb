require "sqlite3"
require "singleton"

class QuestionDBConnection < SQLite3::Database
    include Singleton

    def initialize 
        super('questions.db')
        self.type_translation = true 
        self.results_as_hash = true
    end 
end 

class Questions

    def self.all
        data = QuestionDBConnection.instance.execute('SELECT * FROM questions')
        data.map { |datum| Questions.new(datum) }
    end 

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @users_id = options['users_id']
    end 

    def self.find_by_id
        raise "#{self} already in database" if @id
        QuestionDBConnection.instance.execute(<<- SQL, @title, @body, @users_id) 
        SELECT
            *
        FROM
            questions
        WHERE
            id = self;
        SQL
end 

class Users

    def self.all
        data = QuestionDBConnection.instance.execute('SELECT * FROM users')
        data.map { |datum| Questions.new(datum) }
    end 

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end 
end 

class QuestionsFollows

    def self.all
        data = QuestionDBConnection.instance.execute('SELECT * FROM questions_follows')
        data.map { |datum| Questions.new(datum) }
    end 

    def initialize(options)
        @id = options['id']
        @users_id = options['users_id']
        @questions_id = options['questions_id']
    end 
end 

class Replies

    def self.all
        data = QuestionDBConnection.instance.execute('SELECT * FROM replies')
        data.map { |datum| Questions.new(datum) }
    end 

    def initialize(options)
        @id = options['id']
        @body = options['body']
        @users_id = options['users_id']
        @questions_id = options['questions_id']
    end 
end 


class QuestionsLikes

    def self.all
        data = QuestionDBConnection.instance.execute('SELECT * FROM questions_likes')
        data.map { |datum| Questions.new(datum) }
    end 

    def initialize(options)
        @id = options['id']
        @likes = options['likes']
        @body = options['body']
        @users_id = options['users_id']
        @questions_id = options['questions_id']
    end 
end 