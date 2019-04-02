#Loads userdata then gets dependencies
require 'io/console'
require "yaml"
require 'yaml/store'

#testing block
#balanceTest1 = userUsed[0]['balance']
#userTest1 = userUsed[0]['username']
#passwordTest1 = userUsed[0]['password']
#puts "#{balanceTest1}"
#puts "#{userTest1}"
#puts "#{passwordTest1}"
#define all used variables in app
#password = "users"

#assign all variables used and fill accounts + load users from file
Account = Struct.new :username, :password, :balance
userUsed = ""
objects = YAML.load_file('users.store')
$balance = 0
userDoneWithOption = 0
usingApp = 1
optionAmount = 0
depositAmount = 0
userNameUsed = 0
signupUser = ""
signupPassword = ""

#define all functions used for later
def newAccount(newUsername,newPassword)
	accountMake = [Account.new("#{newUsername}","#{newPassword}","0.0")]
	accountStore = YAML::Store.new "users.store"

	accountStore.transaction do
		accountStore["#{newUsername}"] = accountMake
	end
end

def saveAccount(usernameSaved)
	usernameSaved[0]["balance"] = $balance
	usernameUsed = usernameSaved[0]['username']
	accountStore = YAML::Store.new "users.store"
	
	accountStore.transaction do
		accountStore["#{usernameUsed}"] = usernameSaved
	end
end

def balanceCheck(balanceLocal)
	puts "Your balance is $#{$balance}"
	return $balance
end

def withdraw(balanceLocal)
	puts "How much would you like to withdraw?"
	withdrawAmount = gets.chomp.to_f
	if withdrawAmount > balanceLocal
		puts "You don't have that much to withdraw"
	else
		balanceLocal = balanceLocal.to_f - withdrawAmount
		puts "Your balance is now $#{balanceLocal}"
		$balance = balanceLocal
		return $balance
	end
end

def	deposit(balanceLocal)
	puts "How much would you like to deposit?"
  	depositAmount = gets.chomp.to_f
	balanceLocal = balanceLocal.to_f + depositAmount
	puts "Your balance is now $" + balanceLocal.to_s
	$balance = balanceLocal.to_f
	return $balance
end

#main
puts "Would you like to login or signup? (options: login, signup)"
userInput = gets.chomp
if userInput == "login"
	puts"\e[2J"
	puts "Enter your username"
	userInput = gets.chomp
	userNameUsed = userInput
	userGrab = objects["#{userInput}"]
	#puts "#{userGrab}"
	passGrab = userGrab[0]["password"]
	#puts "#{passGrab}"
	puts "Enter your password"
	userInput = STDIN.noecho(&:gets).chomp
	if userInput == "#{passGrab}"
		$balance = userGrab[0]["balance"]
		saveAccount(userGrab)
		puts "\e[2J"
		puts "Welcome to the banking app"
		puts "If for any reason you want to go back to the menu use (cancel)"
		puts "If for any reason you want to exit the app use (exit)"

		while usingApp == 1
		puts "What would you like to do? (options: balance, deposit, withdraw)"
		optionChose = gets.chomp

		if 	optionChose == "balance"
			puts "\e[2J"
			balanceCheck($balance)
			saveAccount(userGrab)
		elsif	optionChose == "deposit"
			puts "\e[2J"
			deposit($balance)
			saveAccount(userGrab)
		elsif 	optionChose == "withdraw"
			puts "\e[2J"
			withdraw($balance)
			saveAccount(userGrab)
		elsif	optionChose == "cancel"
			puts "\e[2J"
			saveAccount(userGrab)
		elsif	optionChose == "exit"
				usingApp = 0
				saveAccount(userGrab)
		else
			puts "The option #{optionChose} is Invalid"
			saveAccount(userGrab)
		end
		end
	else
		puts "invalid username/password"
	end
else
	puts "Please enter a username of your choice"
	signupUser = gets.chomp
	puts "Please enter a password of your choice"
	signupPassword = STDIN.noecho(&:gets).chomp
	newAccount("#{signupUser}","#{signupPassword}")
end