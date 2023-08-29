OmniAuth.config.test_mode = true

OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
  provider: 'facebook',
  uid: '700609',
  credentials: {
    expires: true,
    expires_at: 1410484859,
    token: "CAAJZBZBmFSIUoBAKuCZCxZBBL9qZBZC5U2oq3KRZCfeWiBRpNze04IAprhKlRHNB23HNQkeBrUt5nly4Y4LwlVZBHH5tm3phIqRHviIJr2GQS0yKF4cEDhEqwb0rnkWL8O9eoV6Yn2TtDkrwUXPSZAR24ngIkuKfLTx1MEB1TYlprxBnaayJJCItg"
  },
  extra: {
    raw_info:  {
      bio:          "Information written about myself",
      email:        "sid137@gmail.com",
      first_name:   "Sidney",
      gender:       "male",
      id:           "700609",
      last_name:    "Burks",
      link:         "https://www.facebook.com/sid137",
      locale:       "en_US",
      name:         "Sidney Burks",
      quotes:       "\"First they ignore you, then they laugh at you, then they fight you, then you win.\"",
      timezone:     2,
      updated_time: "2014-05-21T12:01:29+0000",
      username:     "sid137",
      verified:true
    }
  },
  info: {
    description: "Information written about myself",
    email:       "sid137@gmail.com",
    first_name:  "Sidney",
    image:       "http://graph.facebook.com/700609/picture",
    last_name:   "Burks",
    name:        "Sidney Burks",
    nickname:    "sid137",
    verified:    true
  }
})

# <OmniAuth::AuthHash
#     credentials=
#         #<OmniAuth::AuthHash
#             expires=true
#             expires_at=1410484859
#             token="CAAJZBZBmFSIUoBAKuCZCxZBBL9qZBZC5U2oq3KRZCfeWiBRpNze04IAprhKlRHNB23HNQkeBrUt5nly4Y4LwlVZBHH5tm3phIqRHviIJr2GQS0yKF4cEDhEqwb0rnkWL8O9eoV6Yn2TtDkrwUXPSZAR24ngIkuKfLTx1MEB1TYlprxBnaayJJCItg"
#         >
#     extra=
#         #<OmniAuth::AuthHash
#             raw_info=
#                 #<OmniAuth::AuthHash
#                     bio="Information written about myself"
#                     email="sid137@gmail.com"
#                     favorite_teams=[#<OmniAuth::AuthHash id="50806422841" name="Atlanta Falcons">, #<OmniAuth::AuthHash id="39399781765" name="Boston Red Sox">, #<OmniAuth::AuthHash id="35071097830" name="Atlanta Braves">]
#                     first_name="Sidney"
#                     gender="male"
#                     id="700609"
#                     last_name="Burks"
#                     link="https://www.facebook.com/sid137"
#                     locale="en_US"
#                     name="Sidney Burks"
#                     quotes="\"First they ignore you, then they laugh at you, then they fight you, then you win.\""
#                     timezone=2
#                     updated_time="2014-05-21T12:01:29+0000"
#                     username="sid137"
#                     verified=true
#                     work=[#<OmniAuth::AuthHash description="World's first automatic subtitling telephone for the hearing impaired" employer=#<OmniAuth::AuthHash id="594853203945265" name="RogerVoice"> location=#<OmniAuth::AuthHash id="110774245616525" name="Paris, France"> position=#<OmniAuth::AuthHash id="274909646015557" name="CTO / Founder"> start_date="2013-12-31">, #<OmniAuth::AuthHash description="Big data analytics for retail locations" employer=#<OmniAuth::AuthHash id="1399768973568709" name="Ividata"> location=#<OmniAuth::AuthHash id="110774245616525" name="Paris, France"> position=#<OmniAuth::AuthHash id="274909646015557" name="CTO / Founder"> start_date="2013-09-01">]
#                 >
#          >
#     info=
#         #<OmniAuth::AuthHash::InfoHash
#             description="Information written about myself"
#             email="sid137@gmail.com"
#             first_name="Sidney"
#             image="http://graph.facebook.com/700609/picture"
#             last_name="Burks"
#             name="Sidney Burks"
#             nickname="sid137"
#             urls=#<OmniAuth::AuthHash Facebook="https://www.facebook.com/sid137">
#             verified=true
#         >
#     provider="facebook"
#     uid="700609"
#   >
