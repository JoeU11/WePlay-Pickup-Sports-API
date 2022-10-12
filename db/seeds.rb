# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# Populates 10 sample users in MD, DC and Northern VA

coords = Geocoder.search("1500 S Capitol St SE, Washington, DC 20003").first.coordinates
user = User.new(name: "Jane", email: "jane@jane.com", password: "password", location: "1500 S Capitol St SE, Washington, DC 20003", lat: coords[0], long: coords[1])
user.save

coords = Geocoder.search("333 W Camden St, Baltimore, MD 21201").first.coordinates
user = User.new(name: "Bob", email: "bob@bob.com", password: "password", location: "333 W Camden St, Baltimore, MD 21201", lat: coords[0], long: coords[1])
user.save

coords = Geocoder.search("1101 Russell St, Baltimore, MD 21230").first.coordinates
user = User.new(name: "Frank", email: "frank@frank.com", password: "password", location: "1101 Russell St, Baltimore, MD 21230", lat: coords[0], long: coords[1])
user.save

coords = Geocoder.search("2400 East Capitol St NE, Washington, DC 20003").first.coordinates
user = User.new(name: "Nikolai", email: "nick@nickolai.com", password: "password", location: "2400 East Capitol St NE, Washington, DC 20003", lat: coords[0], long: coords[1])
user.save

coords = Geocoder.search("401 Oklahoma Ave NE, Washington, DC 20002").first.coordinates
user = User.new(name: "Susan", email: "Susan@Susan.com", password: "password", location: "401 Oklahoma Ave NE, Washington, DC 20002", lat: coords[0], long: coords[1])
user.save

coords = Geocoder.search("First St SE, Washington, DC 20004").first.coordinates
user = User.new(name: "Joe", email: "joe@joe.com", password: "password", location: "First St SE, Washington, DC 20004", lat: coords[0], long: coords[1])
user.save

coords = Geocoder.search("14101 Darnestown Rd, Darnestown, MD 20874").first.coordinates
user = User.new(name: "Mary", email: "Mary@Mary.com", password: "password", location: "14101 Darnestown Rd, Darnestown, MD 20874", lat: coords[0], long: coords[1])
user.save

coords = Geocoder.search("15800 Quince Orchard Rd, Gaithersburg, MD 20878").first.coordinates
user = User.new(name: "William", email: "William@William.com", password: "password", location: "15800 Quince Orchard Rd, Gaithersburg, MD 20878", lat: coords[0], long: coords[1])
user.save

coords = Geocoder.search("25921 Ridge Rd, Damascus, MD 20872").first.coordinates
user = User.new(name: "Thierry", email: "Thierry@Thierry.com", password: "password", location: "25921 Ridge Rd, Damascus, MD 20872", lat: coords[0], long: coords[1])
user.save

coords = Geocoder.search("155 Hillwood Ave, Falls Church, VA 22046").first.coordinates
user = User.new(name: "Cristiano", email: "Cristiano@Christiano.com", password: "password", location: "155 Hillwood Ave, Falls Church, VA 22046", lat: coords[0], long: coords[1])
user.save

# Populate User Availabilities (preferred times for playing). Sets all as available sunday morning. First half as available saturday evening, second half as available sunday evening. First two available Friday afternoon

users = User.all
users.each do |user|
  availability = Availability.new(user_id: user.id, day: "Sunday", time_slot: "morning")
  availability.save

  if user.id < (users.length / 2)
    availability = Availability.new(user_id: user.id, day: "Saturday", time_slot: "evening")
    availability.save
  else
    availability = Availability.new(user_id: user.id, day: "Sunday", time_slot: "evening")
    availability.save
  end
end

availability = Availability.new(user_id: User.first.id, day: "Friday", time_slot: "afternoon")
availability.save

availability = Availability.new(user_id: User.second.id, day: "Friday", time_slot: "afternoon")
availability.save

# Populate 7 Sample Locations

coords = Geocoder.search("2400 East Capitol St NE, Washington, DC 20003").first.coordinates
location = Location.new(name: "RFK Stadium", address: "2400 East Capitol St NE, Washington, DC 20003", lat: coords[0], long: coords[1])
location.save

coords = Geocoder.search("7898 Championship Ln, College Park, MD 20740").first.coordinates
location = Location.new(name: "Ludwig Field", address: "7898 Championship Ln, College Park, MD 20740", lat: coords[0], long: coords[1])
location.save

coords = Geocoder.search("3201 Toone St, Baltimore, MD 21224").first.coordinates
location = Location.new(name: "Bonvegna Field", address: "3201 Toone St, Baltimore, MD 21224", lat: coords[0], long: coords[1])
location.save

coords = Geocoder.search("650 Carroll Pkwy, Frederick, MD 21701").first.coordinates
location = Location.new(name: "Frederick High School", address: "650 Carroll Pkwy, Frederick, MD 21701", lat: coords[0], long: coords[1])
location.save

coords = Geocoder.search("Schaeffer Rd, Germantown, MD 20874").first.coordinates
location = Location.new(name: "Montgomery County SoccerPlex", address: "18031 Central Park Cir, Boyds, MD 20841", lat: coords[0], long: coords[1])
location.save

coords = Geocoder.search("8100 VA-620, Annandale, VA 22003").first.coordinates
location = Location.new(name: "Wakefield Park", address: "8100 VA-620, Annandale, VA 22003", lat: coords[0], long: coords[1])
location.save

coords = Geocoder.search("4202 E Fowler Ave, Tampa, FL 33620").first.coordinates
location = Location.new(name: "Fowler Fields", address: "4202 E Fowler Ave, Tampa, FL 33620", lat: coords[0], long: coords[1])
location.save

# Populate Sports - must be in this order. Frontend itentifies by sport ID
sport = Sport.new(name: "soccer")
sport.save

sport = Sport.new(name: "tennis")
sport.save

sport = Sport.new(name: "basketball")
sport.save

# Populate 6 sample events in the next month. Estimated Participants are calculated during event creation via the events controller. Sample data will be hardcoded. 

today = DateTime.now

event = Event.new(sport_id: 1, location_id: 1, time:today.tomorrow, user_id: 1, estimated_participants: 7)
event.save

event = Event.new(sport_id: 1, location_id: 3, time:today.sunday, user_id: 1, estimated_participants: 0)
event.save

event = Event.new(sport_id: 1, location_id: 7, time:today.next_week, user_id: 1, estimated_participants: 4)
event.save

event = Event.new(sport_id: 2, location_id: 4, time:today.next_month, user_id: 1, estimated_participants: 3)
event.save

event = Event.new(sport_id: 2, location_id: 4, time:today.next_week(:friday), user_id: 1, estimated_participants: 3)
event.save

event = Event.new(sport_id: 3, location_id: 6, time:today.next_week(:wednesday), user_id: 1, estimated_participants: 3)
event.save

# Populate 10 event participants (users signed up for events)

participant = EventParticipant.new(user_id: 3, event_id: 1)
participant.save

participant = EventParticipant.new(user_id: 4, event_id: 1)
participant.save

participant = EventParticipant.new(user_id: 3, event_id: 3)
participant.save

participant = EventParticipant.new(user_id: 6, event_id: 1)
participant.save

participant = EventParticipant.new(user_id: 6, event_id: 4)
participant.save

participant = EventParticipant.new(user_id: 6, event_id: 6)
participant.save

participant = EventParticipant.new(user_id: 7, event_id: 1)
participant.save

participant = EventParticipant.new(user_id: 8, event_id: 2)
participant.save

participant = EventParticipant.new(user_id: 9, event_id: 7)
participant.save

participant = EventParticipant.new(user_id: 4, event_id: 7)
participant.save




