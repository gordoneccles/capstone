# Let's clean up first
# User.destroy_all
# Notebook.destroy_all
# Note.destroy_all
# NotebookNote.destroy_all
# Tagging.destroy_all
# Tag.destroy_all

# Alright, now for some users
# gordo = User.new(username: "gordo", password: "badpass")
# pooch = User.new(username: "pooch", password: "dogpass")
# kit   = User.new(username: "kat", password: "catpass")
#
# [gordo, pooch, kit].each do |user|
#   inbox = user.notebooks.new(name: "Inbox", removable: false)
#   inbox.save!
#   recycling = user.notebooks.new(name: "Recycling", removable: false)
#   recycling.save!
#   getting_started = user.notebooks.new(name: "Getting Started")
#   getting_started.save!
#
#   getting_started.notes.create!(
#     title: "Welcome to TogetherNote!",
#     body: "Start writing! We'll save everything automagically.\nUse the 'Collaborate' button to add collaborators to this note.")
#
#   user.open_notebook_id = getting_started.id
#   user.save!
# end
#
# gordo_notebook = Notebook.find(gordo.open_notebook_id)
# hobbit = gordo_notebook.notes.create!(title: "Intro to The Hobbit", body: "In a hole in the ground there lived a hobbit. Not a nasty, dirty, wet hole, filled with the ends of worms and an oozy smell, nor yet a dry, bare, sandy hole with nothing in it to sit down on or to eat: it was a hobbit-hole, and that means comfort. It had a perfectly round door like a porthole, painted green, with a shiny yellow brass knob in the exact middle.")
# gordo_notebook.notes.create!(title: "Super Note", body: "Let it be noted: notes are not notable unless noteworthy.")
#
# pooch_notebook = Notebook.find(pooch.open_notebook_id)
# pooch_notebook.note_ids += [hobbit.id]
