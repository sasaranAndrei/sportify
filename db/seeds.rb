Pay::Charge.create!([
  {customer_id: 1, subscription_id: nil, processor_id: "ch_3KaNNfG0cbVdinhJ0qmSZmtE", amount: 200, currency: "ron", application_fee_amount: nil, amount_refunded: 0, metadata: {}, data: {"brand"=>"Visa", "last4"=>"4242", "exp_year"=>"2024", "exp_month"=>"4", "payment_method_type"=>"card"}},
  {customer_id: 1, subscription_id: nil, processor_id: "ch_3KaNWGG0cbVdinhJ11eDQsIH", amount: 200, currency: "ron", application_fee_amount: nil, amount_refunded: 0, metadata: {}, data: {"brand"=>"Visa", "last4"=>"4242", "exp_year"=>"2042", "exp_month"=>"2", "payment_method_type"=>"card"}}
])
Pay::Customer.create!([
  {owner_type: "User", owner_id: 8, processor: "stripe", processor_id: "cus_LjNuMyugd6Amrt", default: true, data: {}, deleted_at: nil, plan: nil, quantity: nil, payment_method_token: nil},
  {owner_type: "User", owner_id: 11, processor: "stripe", processor_id: "cus_LoDgFNsDA2YFYT", default: true, data: {}, deleted_at: nil, plan: nil, quantity: nil, payment_method_token: nil},
  {owner_type: "User", owner_id: 1, processor: "stripe", processor_id: "cus_LGuyqJaftH8XNG", default: true, data: {}, deleted_at: nil, plan: nil, quantity: nil, payment_method_token: nil}
])
Pay::Webhook.create!([
  {processor: "stripe", event_type: "charge.succeeded", event: {"id"=>"evt_3KaNWGG0cbVdinhJ1WcjyLB7", "data"=>{"object"=>{"id"=>"ch_3KaNWGG0cbVdinhJ11eDQsIH", "paid"=>true, "order"=>nil, "amount"=>200, "object"=>"charge", "review"=>nil, "source"=>nil, "status"=>"succeeded", "created"=>1646586351, "dispute"=>nil, "invoice"=>nil, "outcome"=>{"type"=>"authorized", "reason"=>nil, "risk_level"=>"normal", "risk_score"=>25, "network_status"=>"approved_by_network", "seller_message"=>"Payment complete."}, "refunds"=>{"url"=>"/v1/charges/ch_3KaNWGG0cbVdinhJ11eDQsIH/refunds", "data"=>[], "object"=>"list", "has_more"=>false, "total_count"=>0}, "captured"=>true, "currency"=>"ron", "customer"=>"cus_LGuyqJaftH8XNG", "disputed"=>false, "livemode"=>false, "metadata"=>{}, "refunded"=>false, "shipping"=>nil, "application"=>nil, "description"=>nil, "destination"=>nil, "receipt_url"=>"https://pay.stripe.com/receipts/acct_1KaJgDG0cbVdinhJ/ch_3KaNWGG0cbVdinhJ11eDQsIH/rcpt_LGvNY6cnbmfKm7X1zPZ5f2QAB7gjlQb", "failure_code"=>nil, "on_behalf_of"=>nil, "fraud_details"=>{}, "receipt_email"=>nil, "transfer_data"=>nil, "payment_intent"=>"pi_3KaNWGG0cbVdinhJ1AopNai4", "payment_method"=>"pm_1KaNWkG0cbVdinhJm0GBHug4", "receipt_number"=>nil, "transfer_group"=>nil, "amount_captured"=>200, "amount_refunded"=>0, "application_fee"=>nil, "billing_details"=>{"name"=>"Sasaran Andrei", "email"=>"admin@sportify.com", "phone"=>nil, "address"=>{"city"=>nil, "line1"=>nil, "line2"=>nil, "state"=>nil, "country"=>"RO", "postal_code"=>nil}}, "failure_message"=>nil, "source_transfer"=>nil, "balance_transaction"=>"txn_3KaNWGG0cbVdinhJ1rw5DPDZ", "statement_descriptor"=>nil, "application_fee_amount"=>nil, "payment_method_details"=>{"card"=>{"brand"=>"visa", "last4"=>"4242", "checks"=>{"cvc_check"=>"pass", "address_line1_check"=>nil, "address_postal_code_check"=>nil}, "wallet"=>nil, "country"=>"US", "funding"=>"credit", "network"=>"visa", "exp_year"=>2042, "exp_month"=>2, "fingerprint"=>"gUVPOCbUGL5eiGAp", "installments"=>nil, "three_d_secure"=>nil}, "type"=>"card"}, "statement_descriptor_suffix"=>nil, "calculated_statement_descriptor"=>"SPORTIFY"}}, "type"=>"charge.succeeded", "object"=>"event", "created"=>1646586352, "request"=>{"id"=>"req_O1adOyZSATyiU8", "idempotency_key"=>"5516007b-395e-49b3-9be2-3e222936ce96"}, "livemode"=>false, "api_version"=>"2020-08-27", "pending_webhooks"=>2}}
])
AdminUser.create!([
  {email: "admin@example.com", encrypted_password: "$2a$12$GiTh50zqAMAZtKeRg7b6nencDBORc1iV7PiNaeA0/yBR8RQEca9BC", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil}
])
Arena.create!([
  {title: "Wonderland Cluj", location: "Feleacu, nr. 5 A-E", phone_number: "0740966337", latitude: "46.72209", longitude: "23.58956"},
  {title: "Baza Sportiva Gheorgheni", location: "str. Alexandru Vaida Voevod nr. FN, Cluj-Napoca", phone_number: "0729039322", latitude: "46.77108", longitude: "23.63603"},
  {title: "Baza Sportiva Unirea", location: "str. Aleea Clabucet nr. FN, Cluj-Napoca", phone_number: "0754052000", latitude: "46.74975", longitude: "23.54223"}
])
Field.create!([
  {arena_id: 1, sport_id: 1, label: "Teren Fotbal 1", min_players: 10, max_players: 12},
  {arena_id: 1, sport_id: 1, label: "Teren Fotbal 2", min_players: 8, max_players: 12}
])
Player.create!([
  {name: "Second User", nickname: "Secondyyy", birth_date: "1212-12-12", phone_number: "0712345678999", user_id: 9},
  {name: "Marcel Raducanu", nickname: "Marcy", birth_date: "1994-06-15", phone_number: "0745782932", user_id: 10},
  {name: "Alexandru Marin", nickname: "Alex", birth_date: "1999-09-28", phone_number: "0744178201", user_id: 1},
  {name: "Firsty Usery", nickname: "Firstyyyyyy", birth_date: "1111-11-11", phone_number: "0750512346", user_id: 8},
  {name: "User Nou", nickname: "UserNou", birth_date: "2003-06-21", phone_number: "0744788987", user_id: 11}
])
Reservation.create!([
  {booking_date: "2022-05-03", booking_hour: 19, owner_player_id: 4, field_id: 1, invitation_token: nil},
  {booking_date: "2022-05-28", booking_hour: 18, owner_player_id: 4, field_id: 1, invitation_token: nil},
  {booking_date: "2022-05-26", booking_hour: 18, owner_player_id: 5, field_id: 1, invitation_token: nil},
  {booking_date: "2022-05-31", booking_hour: 18, owner_player_id: 1, field_id: 1, invitation_token: "1131078996d4408a63e7"},
  {booking_date: "2022-06-21", booking_hour: 19, owner_player_id: 1, field_id: 1, invitation_token: nil},
  {booking_date: "2022-06-17", booking_hour: 18, owner_player_id: 1, field_id: 1, invitation_token: "948de1eac85ab70c5acd"},
  {booking_date: "2022-06-03", booking_hour: 20, owner_player_id: 1, field_id: 1, invitation_token: "751673c9fd1781440f65"},
  {booking_date: "2022-06-17", booking_hour: 23, owner_player_id: 1, field_id: 1, invitation_token: "948de1eac85ab70c5acd"},
  {booking_date: "2022-06-17", booking_hour: 22, owner_player_id: 1, field_id: 1, invitation_token: "948de1eac85ab70c5acd"},
  {booking_date: "2022-06-17", booking_hour: 21, owner_player_id: 1, field_id: 1, invitation_token: "948de1eac85ab70c5acd"},
  {booking_date: "2022-06-11", booking_hour: 20, owner_player_id: 1, field_id: 1, invitation_token: nil},
  {booking_date: "2022-06-15", booking_hour: 17, owner_player_id: 1, field_id: 1, invitation_token: nil},
  {booking_date: "2022-06-15", booking_hour: 11, owner_player_id: 1, field_id: 1, invitation_token: nil},
  {booking_date: "2022-06-15", booking_hour: 7, owner_player_id: 1, field_id: 1, invitation_token: nil},
  {booking_date: "2022-06-12", booking_hour: 20, owner_player_id: 1, field_id: 1, invitation_token: nil},
  {booking_date: "2022-06-18", booking_hour: 12, owner_player_id: 1, field_id: 2, invitation_token: nil},
  {booking_date: "2022-06-12", booking_hour: 18, owner_player_id: 1, field_id: 2, invitation_token: nil},
  {booking_date: "2022-06-15", booking_hour: 14, owner_player_id: 1, field_id: 1, invitation_token: "4aa0990a8f4e96d68f97"}
])
User.create!([
  {email: "marcel@gmail.com", encrypted_password: "$2a$12$dmISXIHxAxDZdo0OlmtuIOSpeVDsYzKWGhMIBD.4IO2DIhPH09hSe", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, tokens: 140},
  {email: "first_user@gmail.com", encrypted_password: "$2a$12$dGOktpFJ9Wge7rwwP0qUHO7sfrC0t76G7xeecJ/9qH5Db/Sgz7M0u", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, tokens: 205},
  {email: "second_user_test@sportify.com", encrypted_password: "$2a$12$MAl08yyF3xBjt2ey4XK4XOr4/sbH5cp1eRD8m.N/Co2E93tNgnPEm", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, tokens: 50},
  {email: "user_nou_2@sportify.com", encrypted_password: "$2a$12$iZSEzs4OYwzqD4Y7JLWFh.RYerwJDUi/XxqdEhz5K9niLwCSTxqem", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, tokens: 100},
  {email: "alexandru_marin@gmail.com", encrypted_password: "$2a$12$jPeN4Q.EMiQrWpRhPSyqT.Oh2t0lmEfmYEkEzistwvZyD2jrEyP1S", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, tokens: 200}
])
Tshirt.create!([
  {number: 11, nickname: "Alex", color: "orange", size: "M", player_id: 1},
  {number: 10, nickname: "Alex", color: "white", size: "M", player_id: 1},
  {number: 11, nickname: "Andrei", color: "red", size: "L", player_id: 7}
])
Ball.create!([
  {color: "red", player_id: 1},
  {color: "white", player_id: 1}
])
JoinRequest.create!([
  {player_id: 5, reservation_id: 12, approved: true},
  {player_id: 1, reservation_id: 11, approved: true},
  {player_id: 4, reservation_id: 12, approved: true},
  {player_id: 5, reservation_id: 13, approved: false},
  {player_id: 5, reservation_id: 1, approved: false}
])
ReservationPlayer.create!([
  {reservation_id: 1, player_id: 4, joined_by: "Join Request"},
  {reservation_id: 2, player_id: 1, joined_by: "Join Request"},
  {reservation_id: 11, player_id: 1, joined_by: "Join Request"},
  {reservation_id: 12, player_id: 4, joined_by: "Join Request"}
])
PlayerReview.create!([
  {rating: 5, player_id: 1, reviewer_id: 4, reservation_id: 2},
  {rating: 5, player_id: 4, reviewer_id: 1, reservation_id: 2},
  {rating: 1, player_id: 5, reviewer_id: 1, reservation_id: 11},
  {rating: 1, player_id: 1, reviewer_id: 5, reservation_id: 11}
])
Sport.create!([
  {name: "Football"}
])
ActiveStorage::Blob.create!([
  {key: "eq6f5s3y41gen63lyr9winfzvbe5", filename: "messi.jpg", content_type: "image/jpeg", metadata: {"identified"=>true, "analyzed"=>true}, service_name: "amazon", byte_size: 66384, checksum: "eMF5p/E5772IWx+qalHgsA=="},
  {key: "5qefobckhm87ocb98z1yelpbke13", filename: "ronaldo.jpg", content_type: "image/jpeg", metadata: {"identified"=>true, "analyzed"=>true}, service_name: "local", byte_size: 82721, checksum: "LIKp6pCnR2k/GIoM3loNcg=="},
  {key: "11357ps3c8uvocfnflidccyhmwsv", filename: "ronaldo.jpg", content_type: "image/jpeg", metadata: {"identified"=>true, "analyzed"=>true}, service_name: "local", byte_size: 82721, checksum: "LIKp6pCnR2k/GIoM3loNcg=="},
  {key: "qlzqcl2tpao91fqom0iedinnadzk", filename: "messi.jpg", content_type: "image/jpeg", metadata: {"identified"=>true, "analyzed"=>true}, service_name: "local", byte_size: 66384, checksum: "eMF5p/E5772IWx+qalHgsA=="}
])
ActiveStorage::Attachment.create!([
  {name: "avatar", record_type: "User", record_id: 1, blob_id: 1},
  {name: "avatar", record_type: "User", record_id: 9, blob_id: 2},
  {name: "avatar", record_type: "User", record_id: 10, blob_id: 3},
  {name: "avatar", record_type: "User", record_id: 11, blob_id: 4}
])
