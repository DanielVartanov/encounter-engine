module GamePassingsHelper
  def answer_posted?
    ! @answer.nil?
  end

  def answer_was_correct?
    !! @answer_was_correct
  end
end