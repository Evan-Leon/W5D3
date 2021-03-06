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

    def self.find_by_id(id)
        question = QuestionDBConnection.instance.execute(<<-SQL, id) 
        SELECT
          *
        FROM
          questions 
        WHERE
          id = ? 
        SQL
        return nil unless question.length > 0

        Questions.new(question.first)
    end

    def self.find_by_name(title)
        question = QuestionDBConnection.instance.execute(<<-SQL, title) 
        SELECT
          *
        FROM
          questions 
        WHERE
          title = ? 
        SQL
        return nil unless question.length > 0
        Questions.new(question.first)
    end

     def self.find_by_users_id(users_id)
        question = QuestionDBConnection.instance.execute(<<-SQL, users_id) 
        SELECT
          *
        FROM
          replies 
        WHERE
          users_id = ? 
        SQL
        return nil unless question.length > 0
        Questions.new(question.first)
    end

    attr_accessor :id, :title, :body, :users_id
    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @users_id = options['users_id']
    end 

    def author 
        Users.find_by_id(users_id)
    end

    def replies 
        Replies.find_by_question_id(self.id)
    end

end

class Users

    def self.all
        data = QuestionDBConnection.instance.execute('SELECT * FROM users')
        data.map { |datum| Users.new(datum) }
    end 

    def self.find_by_id(id)
        user = QuestionDBConnection.instance.execute(<<-SQL, id) 
        SELECT
          *
        FROM
          users 
        WHERE
          id = ? 
        SQL
        return nil unless user.length > 0

        Users.new(user.first)
    end

    def self.find_by_name(fname, lname)
        user = QuestionDBConnection.instance.execute(<<-SQL, fname, lname) 
        SELECT
          *
        FROM
          users 
        WHERE
          id = ? 
        SQL
        return nil unless user.length > 0

        Users.new(user.first)
    end

    attr_accessor :id, :fname, :lname

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end 

    def authored_questions
        Questions.find_by_users_id(self.id)
    end 

    def authored_replies 
        Replies.find_by_users_id(self.id)
    end
end 







class QuestionsFollows

    def self.all
        data = QuestionDBConnection.instance.execute('SELECT * FROM questions_follows')
        data.map { |datum| QuestionsFollows.new(datum) }
    end 

    def self.find_by_id(id)
        question_follow = QuestionDBConnection.instance.execute(<<-SQL, id) 
        SELECT
          *
        FROM
          questions_follows 
        WHERE
          id = ? 
        SQL
        return nil unless question_follow.length > 0

        QuestionsFollows.new(question_follow.first)
    end

    attr_accessor :id, :users_id, :questions_id
    def initialize(options)
        @id = options['id']
        @users_id = options['users_id']
        @questions_id = options['questions_id']
    end 
end 






class Replies

    def self.all
        data = QuestionDBConnection.instance.execute('SELECT * FROM replies')
        data.map { |datum| Replies.new(datum) }
    end 

    def self.find_by_id(id)
        reply = QuestionDBConnection.instance.execute(<<-SQL, id) 
        SELECT
          *
        FROM
          replies 
        WHERE
          id = ? 
        SQL
        return nil unless reply.length > 0

        Replies.new(reply.first)
    end

    def self.find_by_users_id(users_id)
        question = QuestionDBConnection.instance.execute(<<-SQL, users_id) 
        SELECT
          *
        FROM
          replies 
        WHERE
          title = ? 
        SQL
        return nil unless question.length > 0
        Replies.new(question.first)
    end

    def self.find_by_question_id(question_id)
        question = QuestionDBConnection.instance.execute(<<-SQL, question_id) 
        SELECT
          *
        FROM
          replies 
        WHERE
          title = ? 
        SQL
        return nil unless question.length > 0
        Replies.new(question.first)
    end

    attr_accessor :id, :body, :users_id, :questions_id

    def initialize(options)
        @id = options['id']
        @body = options['body']
        @users_id = options['users_id']
        @questions_id = options['questions_id']
    end 

    def author 
        Users.find_by_id(users_id)
    end

    def question 
        Questions.find_by_id(questions_id)
    end

    def parent_reply
        #if this self.id - 1 does not = 0
        if id - 1 != 0 && questions_id == 

        end
        #AND quesitons id of self id == questions id of self id-1
        #return self id -1 
        

        Replies.find_by_id(id - 1)
    end
end 


class QuestionsLikes

    def self.all
        data = QuestionDBConnection.instance.execute('SELECT * FROM questions_likes')
        data.map { |datum| QuestionsLikes.new(datum) }
    end 

    def self.find_by_id(id)
        question_like = QuestionDBConnection.instance.execute(<<-SQL, id) 
        SELECT
          *
        FROM
          questions_likes 
        WHERE
          id = ? 
        SQL
        return nil unless question_like.length > 0

        QuestionsLikes.new(question_like.first)
    end

    attr_accessor :id, :likes, :body, :users_id, :questions_id
    def initialize(options)
        @id = options['id']
        @likes = options['likes']
        @users_id = options['users_id']
        @questions_id = options['questions_id']
    end 
end 



#   def self.find_by_id
#         raise "#{self} already in database" if @id
#         QuestionDBConnection.instance.execute(<<- SQL, @title, @body, @users_id) 
#         SELECT
#             *
#         FROM
#             questions
#         WHERE
#             id = self;
#         SQL
# end 

# ques = Questions.all 

# p Questions.find_by_id(1) 