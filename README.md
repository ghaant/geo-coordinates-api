This is a simple web-server application that get an address or a name of a place as an input parameter and returns its coordinates (latitude and longitude) along with a place name. As a search service it uses a 3rd-party service LocationIQ, therefore besides a search value mentioned above you also have to provide your LocationIQ access token.

The URL: <base_url>/locate.
Parameters: token, search_value

An example of usage: http://localhost:3000/locate?token=q1w2e3r4t5y6&search_value=checkpoint%20charlie
