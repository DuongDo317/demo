class UserInfoPresenter < BasePresenter
  def as_json
    json_obj = obj.as_json
    if json_obj.is_a?(Array)
      json_obj.map { |x| x.except("id", "user_id") }
    else
      json_obj.except("id", "user_id")
    end
  end
end
