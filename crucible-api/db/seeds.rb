# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
billy = User.create(name: "Billy", email: "billy@aol.com", password: "greenbeans")
claire = User.create(name: "Claire", email: "claire@gmail.com", password: "fishsticks")
ashley = User.create(name: "Ashley", email: "ashley@yahoo.com", password: "milkmaid")
megan = User.create(name: "Megan", email: "megan@aol.com", password: "greenbeans")
ben = User.create(name: "Ben", email: "ben@gmail.com", password: "fishsticks")
luke = User.create(name: "Luke", email: "luke@yahoo.com", password: "milkmaid")
 
fact1 = Fact.create(content: "pandas are big", url: "pandas.com")
fact2 = Fact.create(content: "shrimp are small", url: "shrimp.com")

fact3 = Fact.create(content: "science is cool", url: "science.com")
fact4 = Fact.create(content: "science is hard", url: "science.com")

billy.facts << fact1
billy.facts << fact2

newFacts = Topic.create(name: "New Facts", user: billy)

science = Topic.create(name: "Science", user: billy)
zoo = Topic.create(name: "Zoology", user: billy, parent: science)
zoo.facts << fact1
zoo.facts << fact2

politics = Topic.create(name: "Politics", user: billy)
civil_rights = Topic.create(name: "Civil Rights", user: billy, parent: politics)
climate_change = Topic.create(name: "Climate Change", user: billy, parent: politics)

blm = Topic.create(name: "Black Lives Matter", user: billy, parent: civil_rights)
free_speech = Topic.create(name: "Free Speech", user: billy, parent: civil_rights)

fifth_amendment = Topic.create(name: "Fith Amendment", user: billy, parent: free_speech)



fam = Group.create(name: "The Fam")
econ = Group.create(name: "Econ 100")

fam.users.push(billy, megan, ashley)


# new_drug = Discussion.create(name: "This New Drug is Lit", group: fam)


