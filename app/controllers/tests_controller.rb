class TestsController < ApplicationController
	attr_accessor :test

	def index
		@test = "lol"
	end

end