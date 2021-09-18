module ChallengesHelper
  def countdown_string(next_date = nil)
    if next_date.nil?
      @seconds = (Time.now.utc.tomorrow.midnight - Time.now.utc).to_i
    else
      @seconds = (next_date.to_time - Time.now).to_i
    end
    return Time.at(@seconds).utc.strftime("%H:%M:%S") if @seconds < 86_400
    return Time.at(@seconds).utc.strftime("%dj. %H:%M:%S") if @seconds > 86_400
  end
end
