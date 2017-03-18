
require 'rubygems'

require 'httparty'


class Wiki

	def initialize (search = "Ruby", lang = "en")

		@search, @lang = search, lang

	end

	
	def take

		# Error : #{}

		uri = HTTParty.get("http://dbpedia.org/data/"+@search.gsub(" ", "_")+".json")

	end

	
	def find_lang (object, lang, result = [])

		object.keys.each do |ky|

			if object[ky].is_a? Hash

				find_lang(object[ky], lang, result)

			elsif object[ky].is_a? Array

				object[ky].each do |i|

					find_lang(i, lang, result) if i.is_a? Hash

				end

			else

				result.push(object) if ky.eql?("lang") && object[ky].eql?(lang)

			end

		end

		result[2]

	end

end


def Clear

	system ("clear || cls")

end


############ -

Clear()

obj = Wiki.new(ARGV[0])

print "\n\n #{obj.find_lang(obj.take, "pt")["value"]}\n\n"

############ -


# Other link' here
