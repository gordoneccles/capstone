class User < ApplicationRecord
  has_attached_file :avatar, default_url: "default_avatar.png", :styles => {
                    :original => "200x200#"
                  }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates :username, :password_digest, :open_notebook_id, presence: true
  validates :username, :password_digest, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :ensure_session_token
  attr_reader :password

  has_many :notebooks, dependent: :destroy, inverse_of: :user

  def all_notes
    self.notebooks.includes(:notes).map{ |nb| nb.notes }.flatten
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)

    while User.find_by(password_digest: self.password_digest)
      self.password_digest = BCrypt::Password.create(password)
    end
  end

  def correct_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return user if user && user.correct_password?(password)
    nil
  end

  def reset_token!
    self.session_token = new_token

    while User.find_by(session_token: self.session_token)
      self.session_token = new_token
    end

    self.save!
    self.session_token
  end

  def all_tags
    tags = []
    self.all_notes.each{ |note| tags += note.tags }
    tags.uniq
  end

  def notebooks_hash
    notesbook_hash = {}

    self.notebooks.each do |notebook|
      id = notebook.id
      notesbook_hash[id] =  {
                              id: id,
                              name: notebook.name,
                              note_count: notebook.note_count,
                              removable: notebook.removable,
                              created_at: notebook.created_at,
                              updated_at: notebook.updated_at
                            }
    end

    notesbook_hash
  end

  def tags_hash
    tags_hash = {}

    self.all_tags.each do |tag|
      id = tag.id
      tags_hash[id] = { id: id, name: tag.name }
    end

    tags_hash
  end

  def set_open_notebook!(notebookId)
    self.open_notebook_id = notebookId
    self.save!
  end

  private

  def new_token
    SecureRandom.urlsafe_base64
  end

  def ensure_session_token
    self.session_token ||= new_token
  end

end
