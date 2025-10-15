use context dcic2024
include csv

voter-data =
load-table: VoterID, DOB, Party, Address, City, County, Postcode source: csv-table-url("https://raw.githubusercontent.com/NU-London/LCSCI4207-datasets/refs/heads/main/voters.csv", default-options)
end
  
# Function name: normalize-date
# Purpose: Convert DD/MM/YYYY into YYYY-MM-DD
# Contract: normalize-date :: String -> String
# Examples:
# normalize-date(01/02/2013) is 2013-02-01
# normalize-date(25/12/2020) is 2020-12-25
  
fun normalize-date(dob :: String) -> String:
doc: "Makes the date in ISO format"
day = string-substring(dob, 0, 2)
month = string-substring(dob, 3, 5)
year = string-substring(dob, 6, 10)
year + "-" + month + "-" + day
end
  
check:
normalize-date("01/02/2013") is "2013-02-01" normalize-date("25/12/2020") is "2020-12-25" normalize-date("09/11/1998") is "1998-11-09"
end
  
corrected-date = transform-column(voter-data, "DOB"
, normalize-date)
  
# Function name: normalize-postcode
# Purpose: Convert postcodes to uppercase and ensure a space before the
last 3 characters.
# Contract: normalize-postcode :: String →> String
# Strategy: Use string-substring multiple times to extract parts.
  
fun normalize-postcode(pc :: String) -> String:
clean = string-replace(pc,"")
upper = string-to-upper (clean)
len = string-length(upper)
last3 = string-substring(upper, len - 3,len)
  first = string-substring(upper, o, len - 3)
first + " " + last3
end
  
check:
normalize-postcode("sw1a2aa") is "SW1A 2AA"
normalize-postcode("swla 2aa") is "SWIA 2AA"
normalize-postcode("E145AB") is "E14 5AB"
end
  
corrected-postcode = transform-column(voter-data, "Postcode", normalize-postcode)