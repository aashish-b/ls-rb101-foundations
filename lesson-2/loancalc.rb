# thanks for the review!
require 'yaml'
MESSAGES = YAML.load_file('loancalc_messages.yml')

def prompt(message)
  Kernel.puts("=> #{message}")
end

def to_float(string)
  Float(string).round(2)
rescue ArgumentError
  nil
end

def valid_number?(num)
  /(^[0-9]+\.[0-9]+$|^[0-9]+$)/.match(num)
end

def clear_screen
  system('clear') || system('cls')
end

prompt(MESSAGES['welcome'])

prompt(MESSAGES['askname'])
givenname = gets.chomp

loop do
  prompt("Hi #{givenname}, please enter your full loan amount (in USD $):")
  loan_amt = ''
  loop do
    loan_amt = gets.chomp.to_s
    if valid_number?(loan_amt) && loan_amt.to_f > 0
      break
    else
      prompt(MESSAGES['invalidamount'])
    end
  end
  loan_amtreal = to_float(loan_amt)

  clear_screen

  prompt(MESSAGES['durationmsg'])
  loan_dur = ''
  loop do
    loan_dur = gets.chomp.to_s
    if valid_number?(loan_dur) && loan_dur.to_i >= 1
      break
    else
      prompt(MESSAGES['invalidduration'])
    end
  end

  loan_durreal = to_float(loan_dur)

  prompt(MESSAGES['apramount'])
  prompt(MESSAGES['aprexample'])
  aprate = ''
  loop do
    aprate = gets.chomp.to_s
    if valid_number?(aprate)
      break
    else
      prompt(MESSAGES['invalidapr'])
    end
  end

  zerointerest = to_float(loan_amtreal / loan_durreal)

  aprate_real = to_float(aprate)
  if aprate_real == 0
    puts "Your interest rate is 0 so your monthly payment will be
          $#{zerointerest} per month (in USD)."
    prompt("Do you want to use LoanCalc again, #{givenname}? ('y' for yes)")
    run_again = gets.chomp
    break unless run_again.downcase == 'y'
  end

  clear_screen

  monthly_ir = aprate_real / 12 / 100

  monthly_pmt = loan_amtreal * (monthly_ir /
                (1 -
                (1 + monthly_ir)**(-loan_durreal)))
  monthly_pmt_final = to_float(monthly_pmt)
  prompt("Your monthly payment is $#{monthly_pmt_final} per month (in USD $).")
  prompt("Do you want to use LoanCalc again, #{givenname}? ('y' for yes)")
  run_again = gets.chomp
  break unless run_again.downcase == 'y'
end

# issues
# 1. didn't initialize float value variable outside the
#    method so program stopped.
# 2. failed to add very first "loop do" so
#    the "break unless" at the end kept giving errors.
# 3. UNSOLVED - how to use commas for numbers?
#    more natural but no idea how.
# 4. UNSOLVED - YAML can't call on variables;
#    all solutions direct to Rails methods. not sure.
