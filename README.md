# README

## Project Title

* Koala Tea Control Final Project *
This project takes a database of tea subscriptions and allows an admin to have easy access and view to them all. It includes a search feature allowing them to look for a variety of traits, including all subscriptions by a single customer, popular teas, subscription status, and more.

## Systems

The BE of this is handled in Ruby on Rails, the normal version that we are supposed to use in class (I know, I should put the actual version, I will for job projects I promise). It also makes use of the FactoryBot and Faker gems for testing.

## Getting Started

- Clone the repo
- bundle install
- rails db:{create,migrate,seed}
- to start the server, use rails s
- Localhost URL (http://localhost:3000)

## Testing

To test, run (bundle exec rspec spec). Alter the ending with /requests or /models as desired
