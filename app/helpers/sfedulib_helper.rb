module SfedulibHelper

require 'digest'
  
def valid_step2?(answer)
  answer.upcase == 'DHH'
end

  
def correct_final_answer?(final_params)
  input = "#{final_params[:major]}.#{final_params[:minor]}.#{final_params[:patch]}"
   Digest::SHA2.hexdigest(input) == "164f3e60dde4f0eda5dd7e38384d16d94dc6da214950a48f44b5e8ea4b34ab1b"
end
  
end