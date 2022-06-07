== README


= Instructions on running application on local machine

	* rvm install ruby-3.0.0

	* bundle install

	* rails db:create db:migrate db:seed

NB: Use any client from Database for client login

	* Client Login-:

		curl -X POST -v -H 'Content-Type: application/json' http://localhost:3000/api/v1/clients/sign_in -d '{"client": {"email":"testclient@gmail.com", "password": "123123123"}}'

	* Customer Create-:

		curl --location --request POST 'http://localhost:3000/api/v1/customers' \
		--header 'Authorization: Bearer {token}' \
		--header 'Content-Type: application/json' \
		--data-raw '{
		    "customer": {
		        "name": "test_name",
		        "dob": "1996-09-12",
		        "email": "testemail@gmail.com"
		    }
		}'


	* Transaction Create-:

		curl --location --request POST 'http://localhost:3000/api/v1/transactions' \
		--header 'Authorization: Bearer {token}' \
		--header 'Content-Type: application/json' \
		--data-raw '{
		    "transaction": {
		        "amount": "100",
		        "description": "New Transaction",
		        "country": "US",
		        "currency": "USD",
		        "email": "testemail@gmail.com"

		    }
		}'

	* Get Rewards-:

		curl --location --request GET 'http://localhost:3000//api/v1/rewards/?email=harikrishnansr007@gmail.com' \
		--header 'Authorization: Bearer {token}'

	* Run test cases -  rspec
