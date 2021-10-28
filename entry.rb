require 'boxr'
require 'dotenv'; Dotenv.load(".env")

# Source: https://github.com/cburnette/boxr

# For some reason, get_enterprise_token() fails with "400: {"error":"invalid_grant","error_description":"Current date\/time MUST be before the expiration date\/time listed in the 'exp' claim"}" for the first time
# It appears that it works when trying again. I'll give 3 chances to try this.
def get_token(times: 3)
  try = 0
  begin
    try += 1
    return Boxr::get_enterprise_token()
  rescue
    retry if try < times
    raise
  end
end

token = get_token()
client = Boxr::Client.new(token)
items = client.folder_items(Boxr::ROOT)
items.each {|i| puts i.name}