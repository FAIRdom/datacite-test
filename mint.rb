#!/bin/ruby

require 'rest-client'

ENDPOINT = 'https://test.datacite.org/mds'

# READ IN THE CREDENTIALS TO USE THE TEST SERVICE
puts 'Datacite username:'
user = gets.chomp
puts 'Datacite password:'
password = gets.chomp


# REGISTER THE ENDPOINT ALONG WITH THE CREDENTIALS
endpoint = RestClient::Resource.new(ENDPOINT, user, password)



# REGISTER THE METADATA WITH A POST TO http://test.datacite.org/mds/metadata
# THE METADATA IS JUST FROM AN EXAMPLE I FOUND
metadata = open('metadata.xml').read
response = endpoint['metadata'].post(metadata,content_type: 'application/xml;charset=UTF-8')
puts "RESPONSE FROM REGISTERING METADATA: #{response}"




# THE DOI TO BE CREATED, AND THE URL TO BE REGISTERED. THE DOI MUST MATCH THAT IN THE METADATA FILE
# YOU COULD ALSO GET THE DOI FROM THE RESPONSE FROM UPLOADING METADATA
doi = '10.5072/test-2'
url = 'http://www.manchester.ac.uk/research/peter.oakes/'




# MINT THE DOI WITH A POST TO http://test.datacite.org/mds/metadata/doi PASSING THE REQUESTED DOI AND URL
response = endpoint['doi'].post("doi=#{doi}\nurl=#{url}",content_type: 'text/plain;charset=UTF-8')

puts "RESPONSE FROM MINTING DOI: #{response}"
