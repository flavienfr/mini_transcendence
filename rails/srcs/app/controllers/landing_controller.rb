class LandingController < ApplicationController
$id = 42

def index
end

def update
  puts "update"
end

def create
  $id = 43
  puts "create"
  
end


end
